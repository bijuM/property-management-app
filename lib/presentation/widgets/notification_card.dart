import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/app_notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final String currentUserId;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.currentUserId,
    required this.onTap,
  });

  static final DateFormat _dateFormat = DateFormat('MMM d, h:mm a');

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isReadBy(currentUserId);
    final accent = _accentForType(notification.type);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : const Color(0xFFF6F8FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRead ? const Color(0xFFE5E7EF) : const Color(0xFFC7D2FE),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _iconForType(notification.type),
                color: accent,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF060B26),
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF596070),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _dateFormat.format(notification.createdAt),
                    style: const TextStyle(
                      color: Color(0xFF89909E),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case NotificationTypes.incomeAdded:
        return Icons.payments_outlined;
      case NotificationTypes.expenseAdded:
      case NotificationTypes.highExpense:
        return Icons.receipt_long_outlined;
      case NotificationTypes.villaAdded:
      case NotificationTypes.villaVacant:
        return Icons.home_work_outlined;
      case NotificationTypes.rentDue:
      case NotificationTypes.pendingRent:
        return Icons.event_available_outlined;
      case NotificationTypes.leaseExpiry:
        return Icons.description_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _accentForType(String type) {
    switch (type) {
      case NotificationTypes.incomeAdded:
        return const Color(0xFF2EA043);
      case NotificationTypes.expenseAdded:
      case NotificationTypes.highExpense:
        return const Color(0xFFF04438);
      case NotificationTypes.villaAdded:
        return const Color(0xFF2563EB);
      case NotificationTypes.villaVacant:
      case NotificationTypes.pendingRent:
      case NotificationTypes.rentDue:
        return const Color(0xFFF59E0B);
      case NotificationTypes.leaseExpiry:
        return const Color(0xFF5549DE);
      default:
        return const Color(0xFF596070);
    }
  }
}
