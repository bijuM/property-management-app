import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/income_repository.dart';
import '../../domain/models/income.dart';
import 'auth_provider.dart';
import 'database_provider.dart';
import 'sync_provider.dart';

final incomeRepositoryProvider = Provider<IncomeRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return IncomeRepository(database);
});

final incomeListProvider = StreamProvider<List<Income>>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return repository.watchAllIncomes();
});

final incomeControllerProvider =
    StateNotifierProvider<IncomeController, AsyncValue<void>>((ref) {
  final repository = ref.watch(incomeRepositoryProvider);
  return IncomeController(repository, ref);
});

final totalIncomeForMonthProvider =
    Provider.family<AsyncValue<double>, DateTime>((ref, month) {
  final incomesAsync = ref.watch(incomeListProvider);

  return incomesAsync.whenData((incomes) {
    return incomes
        .where((income) => _isSameMonth(income.paymentDate, month))
        .fold<double>(0, (sum, income) => sum + income.amount);
  });
});

final incomeVillaSummaryProvider =
    Provider.family<AsyncValue<Map<String, double>>, DateTime>((ref, month) {
  final incomesAsync = ref.watch(incomeListProvider);

  return incomesAsync.whenData((incomes) {
    final summary = <String, double>{};

    for (final income in incomes.where(
      (income) =>
          income.incomeType.toLowerCase() == IncomeTypes.rent.toLowerCase() &&
          _isSameMonth(income.monthCovered, month),
    )) {
      summary.update(
        income.villaId,
        (value) => value + income.amount,
        ifAbsent: () => income.amount,
      );
    }

    return summary;
  });
});

class IncomeController extends StateNotifier<AsyncValue<void>> {
  final IncomeRepository _repository;
  final Ref _ref;

  IncomeController(this._repository, this._ref) : super(const AsyncData(null));

  Future<void> addIncome(Income income) async {
    await _run(() async {
      await _repository.addIncome(income);
      await _queueIncomeSync(income);
    });
  }

  Future<void> updateIncome(Income income) async {
    await _run(() async {
      await _repository.updateIncome(income);
      await _queueIncomeSync(income);
    });
  }

  Future<void> deleteIncome(String id) async {
    await _run(() async {
      await _repository.deleteIncome(id);
      final currentUser = _ref.read(authProvider).currentUser;
      if (currentUser == null) return;
      await _ref.read(firebaseSyncServiceProvider).queueDelete(
            collection: 'incomes',
            id: id,
            userId: currentUser.id,
          );
      _ref.read(syncRefreshProvider.notifier).state++;
    });
  }

  Future<double> getTotalIncomeForMonth(DateTime month) {
    return _repository.getTotalIncomeForMonth(month);
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> _queueIncomeSync(Income income) async {
    final currentUser = _ref.read(authProvider).currentUser;
    if (currentUser == null) return;

    await _ref.read(firebaseSyncServiceProvider).queueIncome(
          income: income,
          userId: currentUser.id,
        );
    _ref.read(syncRefreshProvider.notifier).state++;
  }
}

bool _isSameMonth(DateTime date, DateTime month) {
  return date.year == month.year && date.month == month.month;
}
