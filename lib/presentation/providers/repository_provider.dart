import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/villa_repository_impl.dart';
import '../../data/repositories/income_repository_impl.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/villa_repository.dart';
import '../../domain/repositories/income_repository.dart';
import '../../domain/repositories/expense_repository.dart';
import 'database_provider.dart';

final villaRepositoryProvider = Provider<VillaRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return VillaRepositoryImpl(database);
});

final incomeRepositoryProvider = Provider<IncomeRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return IncomeRepositoryImpl(database);
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ExpenseRepositoryImpl(database);
});
