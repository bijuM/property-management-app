import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_notification.dart';
import 'auth_provider.dart';

final userNotificationsProvider = Provider<List<AppNotification>>((ref) {
  final currentUser = ref.watch(authProvider).currentUser;
  if (currentUser == null) return const [];

  // Firestore-backed notification streaming will replace this placeholder in
  // NotificationService. Push delivery to other devices requires a Firebase
  // Cloud Function or backend using Firebase Admin SDK.
  return const [];
});

final unreadNotificationCountProvider = Provider<int>((ref) {
  final currentUser = ref.watch(authProvider).currentUser;
  if (currentUser == null) return 0;

  final notifications = ref.watch(userNotificationsProvider);
  return notifications.where((item) => !item.isReadBy(currentUser.id)).length;
});

final notificationControllerProvider = Provider<NotificationController>((ref) {
  return NotificationController(ref);
});

class NotificationController {
  final Ref _ref;

  const NotificationController(this._ref);

  Future<void> markAsRead(String notificationId) async {
    _ref.read(authProvider).currentUser;
    // TODO: Update notifications/{notificationId}.isReadMap[userId] in
    // Firestore when NotificationService is added.
  }

  Future<void> markAllAsRead() async {
    _ref.read(authProvider).currentUser;
    // TODO: Batch update visible notification documents in Firestore when
    // NotificationService is added.
  }
}
