import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/app_notification.dart';

class NotificationService {
  static const _notificationsKey = 'villabooks_notifications';

  final _notificationsController =
      StreamController<List<AppNotification>>.broadcast();

  Future<void> createNotification(AppNotification notification) async {
    final notifications = await _loadNotifications();
    final updated = [notification, ...notifications];
    await _saveNotifications(updated);

    debugPrint(
      '[NotificationService] notification created id=${notification.id}',
    );
    debugPrint(
      '[NotificationService] target user ids=${notification.targetUserIds}',
    );

    _notificationsController.add(updated);

    // Local SharedPreferences makes the notification visible to users on this
    // device/profile only. Cross-device push requires Firestore plus a Firebase
    // Cloud Function or backend server using Firebase Admin SDK.
  }

  Stream<List<AppNotification>> watchNotificationsForUser(
      String userId) async* {
    debugPrint('[NotificationService] watch notifications for user=$userId');

    final initial = await _loadNotificationsForUser(userId);
    debugPrint(
      '[NotificationService] notifications loaded for user=$userId count=${initial.length}',
    );
    yield initial;

    yield* _notificationsController.stream.map((notifications) {
      final filtered = _filterForUser(notifications, userId);
      debugPrint(
        '[NotificationService] notifications loaded for user=$userId count=${filtered.length}',
      );
      return filtered;
    });
  }

  Future<void> markAsRead(String notificationId, String userId) async {
    final notifications = await _loadNotifications();
    final updated = notifications.map((notification) {
      if (notification.id != notificationId) return notification;
      return notification.copyWith(
        isReadMap: {
          ...notification.isReadMap,
          userId: true,
        },
      );
    }).toList();

    await _saveNotifications(updated);
    _notificationsController.add(updated);
  }

  Future<void> markAllAsRead(String userId) async {
    final notifications = await _loadNotifications();
    final updated = notifications.map((notification) {
      if (!notification.targetUserIds.contains(userId)) return notification;
      return notification.copyWith(
        isReadMap: {
          ...notification.isReadMap,
          userId: true,
        },
      );
    }).toList();

    await _saveNotifications(updated);
    _notificationsController.add(updated);
  }

  Future<List<AppNotification>> _loadNotificationsForUser(String userId) async {
    final notifications = await _loadNotifications();
    return _filterForUser(notifications, userId);
  }

  List<AppNotification> _filterForUser(
    List<AppNotification> notifications,
    String userId,
  ) {
    final filtered = notifications
        .where((notification) => notification.targetUserIds.contains(userId))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filtered;
  }

  Future<List<AppNotification>> _loadNotifications() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_notificationsKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => AppNotification.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveNotifications(
    List<AppNotification> notifications,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      notifications.map((notification) => notification.toJson()).toList(),
    );
    await preferences.setString(_notificationsKey, encoded);
  }
}
