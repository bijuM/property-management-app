import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/notification_service.dart';
import '../../domain/models/app_notification.dart';
import 'auth_provider.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final userNotificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  final currentUser = ref.watch(authProvider).currentUser;
  if (currentUser == null) return const Stream.empty();

  final service = ref.watch(notificationServiceProvider);

  // Firestore version should use:
  // FirebaseFirestore.instance
  //   .collection('notifications')
  //   .where('targetUserIds', arrayContains: currentUser.id)
  //   .snapshots()
  return service.watchNotificationsForUser(currentUser.id);
});

final unreadNotificationCountProvider = Provider<AsyncValue<int>>((ref) {
  final currentUser = ref.watch(authProvider).currentUser;
  if (currentUser == null) return const AsyncData(0);

  final notificationsAsync = ref.watch(userNotificationsProvider);
  return notificationsAsync.whenData((notifications) {
    return notifications
        .where((notification) => !notification.isReadBy(currentUser.id))
        .length;
  });
});

final notificationControllerProvider = Provider<NotificationController>((ref) {
  return NotificationController(ref);
});

class NotificationController {
  final Ref _ref;

  const NotificationController(this._ref);

  Future<void> createNotification(AppNotification notification) async {
    await _ref
        .read(notificationServiceProvider)
        .createNotification(notification);
    _ref.invalidate(userNotificationsProvider);
  }

  Future<void> markAsRead(String notificationId) async {
    final currentUser = _ref.read(authProvider).currentUser;
    if (currentUser == null) return;

    await _ref
        .read(notificationServiceProvider)
        .markAsRead(notificationId, currentUser.id);
    _ref.invalidate(userNotificationsProvider);
  }

  Future<void> markAllAsRead() async {
    final currentUser = _ref.read(authProvider).currentUser;
    if (currentUser == null) return;

    await _ref.read(notificationServiceProvider).markAllAsRead(currentUser.id);
    _ref.invalidate(userNotificationsProvider);
  }
}
