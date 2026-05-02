import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/startup/startup_status.dart';
import '../../data/services/connectivity_service.dart';
import '../../data/services/firebase_sync_service.dart';
import 'expense_provider.dart';
import 'auth_provider.dart';
import 'income_provider.dart';
import 'villa_provider.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onlineStatus;
});

final firebaseSyncServiceProvider = Provider<FirebaseSyncService>((ref) {
  final startupStatus = ref.watch(startupStatusProvider);
  final service = FirebaseSyncService(
    connectivityService: ref.watch(connectivityServiceProvider),
    firebaseEnabled: startupStatus.firebaseInitialized,
  );
  service.startAutoSync();
  ref.onDispose(service.dispose);
  return service;
});

final pendingSyncCountProvider = FutureProvider<int>((ref) {
  ref.watch(syncRefreshProvider);
  return ref.watch(firebaseSyncServiceProvider).getPendingSyncCount();
});

final lastSyncedAtProvider = FutureProvider<DateTime?>((ref) {
  ref.watch(syncRefreshProvider);
  return ref.watch(firebaseSyncServiceProvider).getLastSyncedAt();
});

final syncRefreshProvider = StateProvider<int>((ref) => 0);

final syncControllerProvider = Provider<SyncController>((ref) {
  return SyncController(ref);
});

class SyncController {
  final Ref _ref;

  const SyncController(this._ref);

  Future<void> syncNow() async {
    await queueAllLocalData();
    await _ref.read(firebaseSyncServiceProvider).syncAllPendingData();
    _refresh();
  }

  Future<void> queueAllLocalData() async {
    final currentUser = _ref.read(authProvider).currentUser;
    if (currentUser == null) return;

    final syncService = _ref.read(firebaseSyncServiceProvider);
    final villas = await _ref.read(villasProvider.future);
    final incomes = _ref.read(incomeListProvider).valueOrNull ?? const [];
    final expenses = _ref.read(expenseProvider);

    for (final villa in villas) {
      await syncService.queueVilla(villa: villa, userId: currentUser.id);
    }
    for (final income in incomes) {
      await syncService.queueIncome(income: income, userId: currentUser.id);
    }
    for (final expense in expenses) {
      await syncService.queueExpense(expense: expense, userId: currentUser.id);
    }
    await syncService.queueUser(user: currentUser, userId: currentUser.id);
    _refresh();
  }

  Future<void> queueCurrentUser() async {
    final currentUser = _ref.read(authProvider).currentUser;
    if (currentUser == null) return;

    await _ref.read(firebaseSyncServiceProvider).queueUser(
          user: currentUser,
          userId: currentUser.id,
        );
    _refresh();
  }

  void _refresh() {
    _ref.read(syncRefreshProvider.notifier).state++;
  }
}
