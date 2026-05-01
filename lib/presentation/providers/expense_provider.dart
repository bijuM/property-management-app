import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/enums.dart';
import '../../domain/models/expense.dart';
import '../../domain/models/expense_model.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/repositories/villa_repository.dart';
import 'repository_provider.dart';

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  final expenseRepository = ref.watch(expenseRepositoryProvider);
  final villaRepository = ref.watch(villaRepositoryProvider);
  return ExpenseNotifier(
    expenseRepository: expenseRepository,
    villaRepository: villaRepository,
  );
});

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  final ExpenseRepository _expenseRepository;
  final VillaRepository _villaRepository;

  ExpenseNotifier({
    required ExpenseRepository expenseRepository,
    required VillaRepository villaRepository,
  })  : _expenseRepository = expenseRepository,
        _villaRepository = villaRepository,
        super(const []) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final expenseModels = await _expenseRepository.getAllExpenses();
    state = await Future.wait(expenseModels.map(_toExpense));
  }

  Future<void> addExpense(Expense expense) async {
    final id = expense.id.trim().isEmpty ? const Uuid().v4() : expense.id;
    await _expenseRepository.addExpense(
      _toExpenseModel(expense.copyWith(id: id)),
    );
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _expenseRepository.updateExpense(_toExpenseModel(expense));
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await _expenseRepository.deleteExpense(id);
    await loadExpenses();
  }

  double getTotalExpensesForMonth(DateTime month) {
    return state
        .where((expense) => _isSameMonth(expense.expenseDate, month))
        .fold<double>(0, (sum, expense) => sum + expense.amount);
  }

  List<Expense> getExpensesByVilla(String villaId) {
    return state.where((expense) => expense.villaId == villaId).toList();
  }

  List<Expense> getExpensesByCategory(String category) {
    return state.where((expense) => expense.category == category).toList();
  }

  Map<String, double> getTopExpenseCategories(DateTime month) {
    final totals = <String, double>{};

    for (final expense
        in state.where((expense) => _isSameMonth(expense.expenseDate, month))) {
      totals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    final sortedEntries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEntries);
  }

  Future<Expense> _toExpense(ExpenseModel model) async {
    final villa = model.villaId == null
        ? null
        : await _villaRepository.getVillaById(model.villaId!);

    return Expense(
      id: model.id,
      villaId: model.villaId,
      villaName: villa?.villaName ?? 'General Expense',
      category: model.category.displayName,
      amount: model.amount,
      expenseDate: model.expenseDate,
      paidTo: model.paidTo,
      paymentMethod: _paymentMethodLabel(model.paymentMethod),
      notes: model.notes ?? '',
    );
  }

  ExpenseModel _toExpenseModel(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      villaId: expense.villaId,
      category: _expenseCategoryFromLabel(expense.category),
      amount: expense.amount,
      expenseDate: expense.expenseDate,
      paidTo: expense.paidTo,
      paymentMethod: _paymentMethodFromLabel(expense.paymentMethod),
      notes: expense.notes.trim().isEmpty ? null : expense.notes.trim(),
      createdAt: DateTime.now(),
    );
  }

  ExpenseCategory _expenseCategoryFromLabel(String label) {
    final normalized = _normalize(label);
    return ExpenseCategory.values.firstWhere(
      (category) => _normalize(category.displayName) == normalized,
      orElse: () => ExpenseCategory.other,
    );
  }

  PaymentMethod _paymentMethodFromLabel(String label) {
    switch (_normalize(label)) {
      case 'cash':
        return PaymentMethod.cash;
      case 'banktransfer':
      case 'transfer':
        return PaymentMethod.transfer;
      case 'card':
      case 'online':
        return PaymentMethod.online;
      case 'cheque':
      case 'check':
        return PaymentMethod.check;
      default:
        return PaymentMethod.other;
    }
  }

  String _paymentMethodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return ExpensePaymentMethods.cash;
      case PaymentMethod.transfer:
        return ExpensePaymentMethods.bankTransfer;
      case PaymentMethod.online:
        return ExpensePaymentMethods.card;
      case PaymentMethod.check:
        return ExpensePaymentMethods.cheque;
      case PaymentMethod.other:
        return ExpensePaymentMethods.other;
    }
  }

  static bool _isSameMonth(DateTime date, DateTime month) {
    return date.year == month.year && date.month == month.month;
  }

  static String _normalize(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }
}
