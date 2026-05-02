import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/connectivity_service.dart';
import '../../data/services/firebase_sync_service.dart';
import 'auth_provider.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onlineStatus;
});

final firebaseSyncServiceProvider = Provider<FirebaseSyncService>((ref) {
  final service = FirebaseSyncService(
    connectivityService: ref.watch(connectivityServiceProvider),
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
    await _ref.read(firebaseSyncServiceProvider).syncAllPendingData();
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
