import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/notification_card.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider).currentUser;
    final notifications = ref.watch(userNotificationsProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final controller = ref.watch(notificationControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: Text(
          unreadCount == 0 ? 'Notifications' : 'Notifications ($unreadCount)',
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: controller.markAllAsRead,
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: currentUser == null || notifications.isEmpty
          ? const _EmptyNotifications()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(
                  notification: notification,
                  currentUserId: currentUser.id,
                  onTap: () => controller.markAsRead(notification.id),
                );
              },
            ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF89909E),
              size: 44,
            ),
            SizedBox(height: 12),
            Text(
              'No notifications yet',
              style: TextStyle(
                color: Color(0xFF060B26),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Updates from income, expenses, villas, rent, and leases will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF596070),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
