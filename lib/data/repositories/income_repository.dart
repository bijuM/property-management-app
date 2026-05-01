import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/income.dart';
import '../local/database.dart' as db;

class IncomeRepository {
  final db.AppDatabase database;

  IncomeRepository(this.database);

  Future<List<Income>> getAllIncomes() async {
    final rows = await database.getAllIncomes();
    return rows.map(_mapRowToIncome).toList();
  }

  Stream<List<Income>> watchAllIncomes() {
    return database.watchAllIncomes().map(
          (rows) => rows.map(_mapRowToIncome).toList(),
        );
  }

  Future<void> addIncome(Income income) async {
    final now = DateTime.now();
    final id = income.id.trim().isEmpty ? const Uuid().v4() : income.id;

    await database.insertIncome(
      db.IncomesCompanion(
        id: Value(id),
        villaId: Value(income.villaId),
        villaName: Value(income.villaName),
        incomeType: Value(income.incomeType),
        amount: Value(income.amount),
        paymentDate: Value(income.paymentDate),
        paymentMethod: Value(income.paymentMethod),
        monthCovered: Value(_monthStart(income.monthCovered)),
        notes: Value(income.notes.trim().isEmpty ? null : income.notes.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> updateIncome(Income income) async {
    await database.updateIncome(
      db.IncomesCompanion(
        id: Value(income.id),
        villaId: Value(income.villaId),
        villaName: Value(income.villaName),
        incomeType: Value(income.incomeType),
        amount: Value(income.amount),
        paymentDate: Value(income.paymentDate),
        paymentMethod: Value(income.paymentMethod),
        monthCovered: Value(_monthStart(income.monthCovered)),
        notes: Value(income.notes.trim().isEmpty ? null : income.notes.trim()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteIncome(String id) {
    return database.deleteIncome(id);
  }

  Future<List<Income>> getIncomesByVilla(String villaId) async {
    final rows = await database.getIncomesByVillaId(villaId);
    return rows.map(_mapRowToIncome).toList();
  }

  Future<double> getTotalIncomeForMonth(DateTime month) async {
    final incomes = await getIncomesForMonth(month);
    return incomes.fold<double>(0, (sum, income) => sum + income.amount);
  }

  Future<List<Income>> getIncomesForMonth(DateTime month) async {
    final rows = await database.getIncomesByMonth(month);
    return rows.map(_mapRowToIncome).toList();
  }

  Income _mapRowToIncome(db.Income row) {
    return Income(
      id: row.id,
      villaId: row.villaId,
      villaName:
          row.villaName.trim().isEmpty ? 'Villa ${row.villaId}' : row.villaName,
      incomeType: _incomeTypeLabel(row.incomeType),
      amount: row.amount,
      paymentDate: row.paymentDate,
      paymentMethod: _paymentMethodLabel(row.paymentMethod),
      monthCovered: _monthStart(row.monthCovered),
      notes: row.notes ?? '',
    );
  }

  String _incomeTypeLabel(String value) {
    switch (_normalize(value)) {
      case 'rent':
        return IncomeTypes.rent;
      case 'deposit':
        return IncomeTypes.deposit;
      case 'maintenancecharge':
        return IncomeTypes.maintenanceCharge;
      case 'penalty':
        return IncomeTypes.penalty;
      default:
        return IncomeTypes.other;
    }
  }

  String _paymentMethodLabel(String value) {
    switch (_normalize(value)) {
      case 'cash':
        return IncomePaymentMethods.cash;
      case 'banktransfer':
      case 'transfer':
        return IncomePaymentMethods.bankTransfer;
      case 'card':
      case 'online':
        return IncomePaymentMethods.card;
      case 'cheque':
      case 'check':
        return IncomePaymentMethods.cheque;
      default:
        return IncomePaymentMethods.other;
    }
  }

  static DateTime _monthStart(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static String _normalize(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }
}
