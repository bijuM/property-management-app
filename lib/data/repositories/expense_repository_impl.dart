import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../domain/models/expense_model.dart';
import '../../domain/repositories/expense_repository.dart';
import '../local/database.dart';
import '../../core/constants/enums.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final AppDatabase database;

  ExpenseRepositoryImpl(this.database);

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    final expenses = await database.getAllExpenses();
    return expenses.map((expense) => _mapToModel(expense)).toList();
  }

  @override
  Future<List<ExpenseModel>> getExpensesByVillaId(String villaId) async {
    final expenses = await database.getExpensesByVillaId(villaId);
    return expenses.map((expense) => _mapToModel(expense)).toList();
  }

  @override
  Future<List<ExpenseModel>> getExpensesByMonth(DateTime month) async {
    final expenses = await database.getExpensesByMonth(month);
    return expenses.map((expense) => _mapToModel(expense)).toList();
  }

  @override
  Future<String> addExpense(ExpenseModel expense) async {
    final id = expense.id.isEmpty ? const Uuid().v4() : expense.id;
    final now = DateTime.now();
    await database.insertExpense(
      ExpensesCompanion(
        id: Value(id),
        villaId: Value(expense.villaId),
        category: Value(expense.category.name),
        amount: Value(expense.amount),
        expenseDate: Value(expense.expenseDate),
        paidTo: Value(expense.paidTo),
        paymentMethod: Value(expense.paymentMethod.name),
        notes: Value(expense.notes),
        createdAt: Value(now),
      ),
    );
    return id;
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    await database.updateExpense(
      ExpensesCompanion(
        id: Value(expense.id),
        villaId: Value(expense.villaId),
        category: Value(expense.category.name),
        amount: Value(expense.amount),
        expenseDate: Value(expense.expenseDate),
        paidTo: Value(expense.paidTo),
        paymentMethod: Value(expense.paymentMethod.name),
        notes: Value(expense.notes),
      ),
    );
  }

  @override
  Future<void> deleteExpense(String id) async {
    await database.deleteExpense(id);
  }

  @override
  Future<double> getTotalExpenseForMonth(DateTime month) {
    return database.getTotalExpenseForMonth(month);
  }

  @override
  Future<Map<String, double>> getExpensesByCategory(DateTime month) {
    return database.getExpensesByCategory(month);
  }

  ExpenseModel _mapToModel(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      villaId: expense.villaId,
      category: _parseExpenseCategory(expense.category),
      amount: expense.amount,
      expenseDate: expense.expenseDate,
      paidTo: expense.paidTo,
      paymentMethod: _parsePaymentMethod(expense.paymentMethod),
      notes: expense.notes,
      createdAt: expense.createdAt,
    );
  }

  ExpenseCategory _parseExpenseCategory(String category) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.name == category,
      orElse: () => ExpenseCategory.other,
    );
  }

  PaymentMethod _parsePaymentMethod(String method) {
    return PaymentMethod.values.firstWhere(
      (e) => e.name == method,
      orElse: () => PaymentMethod.other,
    );
  }
}
