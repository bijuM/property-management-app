import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'database.g.dart';

// Villa Table
class Villas extends Table {
  TextColumn get id => text()();
  TextColumn get villaName => text()();
  TextColumn get villaNumber => text()();
  TextColumn get location => text()();
  TextColumn get tenantName => text()();
  TextColumn get tenantPhone => text()();
  RealColumn get monthlyRent => real()();
  DateTimeColumn get contractStartDate => dateTime()();
  DateTimeColumn get contractEndDate => dateTime()();
  IntColumn get paymentDueDay => integer()();
  TextColumn get status => text()(); // occupied, vacant
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Income Table
class Incomes extends Table {
  TextColumn get id => text()();
  TextColumn get villaId => text().references(Villas, #id)();
  TextColumn get villaName => text().withDefault(const Constant(''))();
  TextColumn get incomeType =>
      text()(); // rent, deposit, maintenanceCharge, penalty, other
  RealColumn get amount => real()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get paymentMethod =>
      text()(); // cash, check, transfer, online, other
  DateTimeColumn get monthCovered => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Expense Table
class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get villaId => text().nullable().references(Villas, #id)();
  TextColumn get category =>
      text()(); // maintenance, repair, electricity, water, cleaning, commission, insurance, governmentFee, loan, other
  RealColumn get amount => real()();
  DateTimeColumn get expenseDate => dateTime()();
  TextColumn get paidTo => text()();
  TextColumn get paymentMethod =>
      text()(); // cash, check, transfer, online, other
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Villas, Incomes, Expenses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(incomes, incomes.villaName);
            await migrator.addColumn(incomes, incomes.updatedAt);
          }
        },
      );

  // Villa Queries
  Future<List<Villa>> getAllVillas() => select(villas).get();

  Future<Villa?> getVillaById(String id) =>
      (select(villas)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<int> insertVilla(VillasCompanion villa) => into(villas).insert(villa);

  Future<bool> updateVilla(VillasCompanion villa) =>
      update(villas).replace(villa);

  Future<int> deleteVilla(String id) =>
      (delete(villas)..where((tbl) => tbl.id.equals(id))).go();

  // Income Queries
  Future<List<Income>> getAllIncomes() => select(incomes).get();

  Stream<List<Income>> watchAllIncomes() => select(incomes).watch();

  Future<List<Income>> getIncomesByVillaId(String villaId) =>
      (select(incomes)..where((tbl) => tbl.villaId.equals(villaId))).get();

  Future<List<Income>> getIncomesByMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    return (select(incomes)
          ..where((tbl) =>
              tbl.paymentDate.isBetweenValues(startOfMonth, endOfMonth)))
        .get();
  }

  Future<int> insertIncome(IncomesCompanion income) =>
      into(incomes).insert(income);

  Future<bool> updateIncome(IncomesCompanion income) =>
      update(incomes).replace(income);

  Future<int> deleteIncome(String id) =>
      (delete(incomes)..where((tbl) => tbl.id.equals(id))).go();

  // Expense Queries
  Future<List<Expense>> getAllExpenses() => select(expenses).get();

  Future<List<Expense>> getExpensesByVillaId(String villaId) =>
      (select(expenses)..where((tbl) => tbl.villaId.equals(villaId))).get();

  Future<List<Expense>> getExpensesByMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    return (select(expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBetweenValues(startOfMonth, endOfMonth)))
        .get();
  }

  Future<int> insertExpense(ExpensesCompanion expense) =>
      into(expenses).insert(expense);

  Future<bool> updateExpense(ExpensesCompanion expense) =>
      update(expenses).replace(expense);

  Future<int> deleteExpense(String id) =>
      (delete(expenses)..where((tbl) => tbl.id.equals(id))).go();

  // Dashboard Queries
  Future<double> getTotalIncomeForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    final result = await (select(incomes)
          ..where((tbl) =>
              tbl.paymentDate.isBetweenValues(startOfMonth, endOfMonth)))
        .map((r) => r.amount)
        .get();
    return result.fold<double>(0, (sum, amount) => sum + amount);
  }

  Future<double> getTotalExpenseForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    final result = await (select(expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBetweenValues(startOfMonth, endOfMonth)))
        .map((r) => r.amount)
        .get();
    return result.fold<double>(0, (sum, amount) => sum + amount);
  }

  Future<Map<String, double>> getExpensesByCategory(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    final expenseList = await (select(expenses)
          ..where((tbl) =>
              tbl.expenseDate.isBetweenValues(startOfMonth, endOfMonth)))
        .get();

    final categoryMap = <String, double>{};
    for (var expense in expenseList) {
      categoryMap.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return categoryMap;
  }

  Future<Map<String, double>> getIncomeByVillaSummary(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    final incomeList = await (select(incomes)
          ..where((tbl) =>
              tbl.paymentDate.isBetweenValues(startOfMonth, endOfMonth)))
        .get();

    final villaSummary = <String, double>{};
    for (var income in incomeList) {
      villaSummary.update(
        income.villaId,
        (value) => value + income.amount,
        ifAbsent: () => income.amount,
      );
    }
    return villaSummary;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'villabooks.db'));
    return NativeDatabase(file);
  });
}
