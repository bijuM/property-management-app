class AppNotification {
  final String id;
  final String title;
  final String body;
  final String type;
  final String createdByUserId;
  final String createdByUsername;
  final List<String> targetUserIds;
  final String? targetRole;
  final DateTime createdAt;
  final Map<String, bool> isReadMap;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdByUserId,
    required this.createdByUsername,
    required this.targetUserIds,
    required this.targetRole,
    required this.createdAt,
    required this.isReadMap,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      createdByUserId: json['createdByUserId'] as String,
      createdByUsername: json['createdByUsername'] as String,
      targetUserIds: _stringListFromJson(json['targetUserIds']),
      targetRole: json['targetRole'] as String?,
      createdAt: _dateTimeFromJson(json['createdAt']),
      isReadMap: _boolMapFromJson(json['isReadMap']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'createdByUserId': createdByUserId,
      'createdByUsername': createdByUsername,
      'targetUserIds': targetUserIds,
      'targetRole': targetRole,
      'createdAt': createdAt.toIso8601String(),
      'isReadMap': isReadMap,
    };
  }

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    String? createdByUserId,
    String? createdByUsername,
    List<String>? targetUserIds,
    String? targetRole,
    bool clearTargetRole = false,
    DateTime? createdAt,
    Map<String, bool>? isReadMap,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdByUsername: createdByUsername ?? this.createdByUsername,
      targetUserIds: targetUserIds ?? this.targetUserIds,
      targetRole: clearTargetRole ? null : targetRole ?? this.targetRole,
      createdAt: createdAt ?? this.createdAt,
      isReadMap: isReadMap ?? this.isReadMap,
    );
  }

  bool isReadBy(String userId) {
    return isReadMap[userId] ?? false;
  }
}

class NotificationTypes {
  NotificationTypes._();

  static const incomeAdded = 'income_added';
  static const expenseAdded = 'expense_added';
  static const villaAdded = 'villa_added';
  static const villaVacant = 'villa_vacant';
  static const highExpense = 'high_expense';
  static const rentDue = 'rent_due';
  static const pendingRent = 'pending_rent';
  static const leaseExpiry = 'lease_expiry';

  static const values = [
    incomeAdded,
    expenseAdded,
    villaAdded,
    villaVacant,
    highExpense,
    rentDue,
    pendingRent,
    leaseExpiry,
  ];
}

List<String> _stringListFromJson(Object? value) {
  if (value is List) {
    return value.map((item) => item.toString()).toList();
  }
  return const [];
}

Map<String, bool> _boolMapFromJson(Object? value) {
  if (value is Map) {
    return value.map(
      (key, item) => MapEntry(key.toString(), item == true),
    );
  }
  return const {};
}

DateTime _dateTimeFromJson(Object? value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.parse(value);

  final dynamic timestamp = value;
  final dynamic date = timestamp?.toDate();
  if (date is DateTime) return date;

  throw FormatException('Invalid notification createdAt value: $value');
}
