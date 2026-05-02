import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, debugPrint, defaultTargetPlatform, kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/enums.dart';
import '../../domain/models/app_notification.dart';
import '../../domain/models/app_user.dart';
import '../../domain/models/expense.dart';
import '../../domain/models/income.dart';
import '../../domain/models/villa_model.dart';
import 'connectivity_service.dart';

class FirebaseSyncService {
  static const _pendingSyncKey = 'villabooks_pending_sync_queue';
  static const _lastSyncedAtKey = 'villabooks_last_synced_at';

  final FirebaseFirestore _firestore;
  final ConnectivityService _connectivityService;
  StreamSubscription<bool>? _connectivitySubscription;

  FirebaseSyncService({
    FirebaseFirestore? firestore,
    ConnectivityService? connectivityService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _connectivityService = connectivityService ?? ConnectivityService();

  void startAutoSync() {
    if (!_isFirestoreEnabled) {
      debugPrint(
        '[FirebaseSync] Firestore sync disabled on $defaultTargetPlatform. '
        'Run flutterfire configure for this platform before enabling cloud sync.',
      );
      return;
    }

    _connectivitySubscription ??=
        _connectivityService.onlineStatus.listen((isOnline) {
      if (isOnline) {
        unawaited(syncAllPendingData());
      }
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  Future<void> queueVilla({
    required VillaModel villa,
    required String userId,
    bool isDeleted = false,
  }) {
    return _queueRecord(
      collection: 'villas',
      id: villa.id,
      data: _villaToJson(villa),
      userId: userId,
      isDeleted: isDeleted,
    );
  }

  Future<void> queueIncome({
    required Income income,
    required String userId,
    bool isDeleted = false,
  }) {
    return _queueRecord(
      collection: 'incomes',
      id: income.id,
      data: _incomeToJson(income),
      userId: userId,
      isDeleted: isDeleted,
    );
  }

  Future<void> queueExpense({
    required Expense expense,
    required String userId,
    bool isDeleted = false,
  }) {
    return _queueRecord(
      collection: 'expenses',
      id: expense.id,
      data: _expenseToJson(expense),
      userId: userId,
      isDeleted: isDeleted,
    );
  }

  Future<void> queueUser({
    required AppUser user,
    required String userId,
    bool isDeleted = false,
  }) {
    return _queueRecord(
      collection: 'users',
      id: user.id,
      data: _appUserToJson(user),
      userId: userId,
      isDeleted: isDeleted,
    );
  }

  Future<void> queueNotification({
    required AppNotification notification,
    required String userId,
    bool isDeleted = false,
  }) {
    return _queueRecord(
      collection: 'notifications',
      id: notification.id,
      data: notification.toJson(),
      userId: userId,
      isDeleted: isDeleted,
    );
  }

  Future<void> queueDelete({
    required String collection,
    required String id,
    required String userId,
  }) {
    return _queueRecord(
      collection: collection,
      id: id,
      data: const {},
      userId: userId,
      isDeleted: true,
    );
  }

  Future<void> syncPendingVillas() => _syncCollection('villas');
  Future<void> syncPendingIncomes() => _syncCollection('incomes');
  Future<void> syncPendingExpenses() => _syncCollection('expenses');
  Future<void> syncPendingUsers() => _syncCollection('users');
  Future<void> syncPendingNotifications() => _syncCollection('notifications');

  Future<void> syncAllPendingData() async {
    if (!_isFirestoreEnabled) return;
    if (!await _connectivityService.isOnline) return;

    await syncPendingVillas();
    await syncPendingIncomes();
    await syncPendingExpenses();
    await syncPendingUsers();
    await syncPendingNotifications();

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _lastSyncedAtKey,
      DateTime.now().toIso8601String(),
    );
  }

  Stream<List<VillaModel>> watchCloudVillas() {
    if (!_isFirestoreEnabled) {
      debugPrint('[FirebaseSync] cloud villa stream disabled on desktop.');
      return Stream.value(const []);
    }

    return _firestore.collection('villas').snapshots().map((snapshot) {
      final activeDocs = snapshot.docs
          .where((doc) => doc.data()['isDeleted'] != true)
          .toList();
      debugPrint(
        '[FirebaseSync] cloud villas snapshot raw=${snapshot.docs.length}, active=${activeDocs.length}',
      );
      return activeDocs.map((doc) => _villaFromJson(doc.data())).toList();
    });
  }

  Stream<List<Income>> watchCloudIncomes() {
    if (!_isFirestoreEnabled) {
      debugPrint('[FirebaseSync] cloud income stream disabled on desktop.');
      return Stream.value(const []);
    }

    return _firestore.collection('incomes').snapshots().map((snapshot) {
      final activeDocs = snapshot.docs
          .where((doc) => doc.data()['isDeleted'] != true)
          .toList();
      debugPrint(
        '[FirebaseSync] cloud incomes snapshot raw=${snapshot.docs.length}, active=${activeDocs.length}',
      );
      return activeDocs.map((doc) => _incomeFromJson(doc.data())).toList();
    });
  }

  Stream<List<Expense>> watchCloudExpenses() {
    if (!_isFirestoreEnabled) {
      debugPrint('[FirebaseSync] cloud expense stream disabled on desktop.');
      return Stream.value(const []);
    }

    return _firestore.collection('expenses').snapshots().map((snapshot) {
      final activeDocs = snapshot.docs
          .where((doc) => doc.data()['isDeleted'] != true)
          .toList();
      debugPrint(
        '[FirebaseSync] cloud expenses snapshot raw=${snapshot.docs.length}, active=${activeDocs.length}',
      );
      return activeDocs.map((doc) => _expenseFromJson(doc.data())).toList();
    });
  }

  Future<void> pullCloudDataToLocal() async {
    // Local upsert wiring belongs in repository-specific code so Drift remains
    // the offline source of truth. This method is intentionally a sync boundary
    // for the next step, where cloud rows are compared with local rows.
    debugPrint('[FirebaseSync] pullCloudDataToLocal is not wired yet.');
  }

  Map<String, dynamic> resolveConflict({
    required Map<String, dynamic> local,
    required Map<String, dynamic> cloud,
  }) {
    final localUpdatedAt = _readDateTime(local['updatedAt']);
    final cloudUpdatedAt = _readDateTime(cloud['updatedAt']);
    if (cloudUpdatedAt.isAfter(localUpdatedAt)) return cloud;
    return local;
  }

  Future<int> getPendingSyncCount() async {
    final queue = await _loadQueue();
    return queue.length;
  }

  Future<DateTime?> getLastSyncedAt() async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString(_lastSyncedAtKey);
    return value == null ? null : DateTime.tryParse(value);
  }

  Future<void> _queueRecord({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
    required String userId,
    required bool isDeleted,
  }) async {
    final now = DateTime.now();
    final queue = await _loadQueue();
    final record = _SyncRecord(
      collection: collection,
      id: id,
      data: {
        ...data,
        'id': id,
        'updatedBy': userId,
        'updatedAt': now.toIso8601String(),
        'isDeleted': isDeleted,
        'syncStatus': 'pending',
        'lastSyncedAt': null,
        if (!data.containsKey('createdBy')) 'createdBy': userId,
        if (!data.containsKey('createdAt')) 'createdAt': now.toIso8601String(),
      },
      queuedAt: now,
    );

    queue.removeWhere(
      (item) => item.collection == collection && item.id == id,
    );
    queue.add(record);
    await _saveQueue(queue);
    debugPrint('[FirebaseSync] queued $collection/$id');

    if (await _connectivityService.isOnline) {
      await _syncCollection(collection);
    }
  }

  Future<void> _syncCollection(String collection) async {
    if (!_isFirestoreEnabled) return;
    if (!await _connectivityService.isOnline) return;

    final queue = await _loadQueue();
    final remaining = <_SyncRecord>[];

    for (final record in queue) {
      if (record.collection != collection) {
        remaining.add(record);
        continue;
      }

      try {
        final now = DateTime.now();
        final payload = {
          ...record.data,
          'syncStatus': 'synced',
          'lastSyncedAt': now.toIso8601String(),
        };
        await _firestore
            .collection(record.collection)
            .doc(record.id)
            .set(payload, SetOptions(merge: true));
        debugPrint(
          '[FirebaseSync] synced ${record.collection}/${record.id}',
        );
      } catch (error) {
        debugPrint(
          '[FirebaseSync] failed ${record.collection}/${record.id}: $error',
        );
        remaining.add(record);
      }
    }

    await _saveQueue(remaining);
  }

  Future<List<_SyncRecord>> _loadQueue() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_pendingSyncKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => _SyncRecord.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveQueue(List<_SyncRecord> queue) async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = jsonEncode(queue.map((item) => item.toJson()).toList());
    await preferences.setString(_pendingSyncKey, encoded);
  }

  Map<String, dynamic> _villaToJson(VillaModel villa) {
    return {
      'id': villa.id,
      'villaName': villa.villaName,
      'villaNumber': villa.villaNumber,
      'location': villa.location,
      'tenantName': villa.tenantName,
      'tenantPhone': villa.tenantPhone,
      'monthlyRent': villa.monthlyRent,
      'contractStartDate': villa.contractStartDate.toIso8601String(),
      'contractEndDate': villa.contractEndDate.toIso8601String(),
      'paymentDueDay': villa.paymentDueDay,
      'status': villa.status.name,
      'createdAt': villa.createdAt.toIso8601String(),
      'updatedAt': villa.updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _incomeToJson(Income income) {
    return {
      'id': income.id,
      'villaId': income.villaId,
      'villaName': income.villaName,
      'incomeType': income.incomeType,
      'amount': income.amount,
      'paymentDate': income.paymentDate.toIso8601String(),
      'paymentMethod': income.paymentMethod,
      'monthCovered': income.monthCovered.toIso8601String(),
      'notes': income.notes,
    };
  }

  Map<String, dynamic> _expenseToJson(Expense expense) {
    return {
      'id': expense.id,
      'villaId': expense.villaId,
      'villaName': expense.villaName,
      'category': expense.category,
      'amount': expense.amount,
      'expenseDate': expense.expenseDate.toIso8601String(),
      'paidTo': expense.paidTo,
      'paymentMethod': expense.paymentMethod,
      'notes': expense.notes,
    };
  }

  Map<String, dynamic> _appUserToJson(AppUser user) {
    return {
      'id': user.id,
      'username': user.username,
      'role': user.role,
      'isActive': true,
      'createdAt': user.createdAt.toIso8601String(),
      'updatedAt': user.updatedAt?.toIso8601String(),
    };
  }

  VillaModel _villaFromJson(Map<String, dynamic> json) {
    return VillaModel(
      id: json['id'] as String,
      villaName: json['villaName'] as String? ?? '',
      villaNumber: json['villaNumber'] as String? ?? '',
      location: json['location'] as String? ?? '',
      tenantName: json['tenantName'] as String? ?? '',
      tenantPhone: json['tenantPhone'] as String? ?? '',
      monthlyRent: (json['monthlyRent'] as num?)?.toDouble() ?? 0,
      contractStartDate: _readDateTime(json['contractStartDate']),
      contractEndDate: _readDateTime(json['contractEndDate']),
      paymentDueDay: (json['paymentDueDay'] as num?)?.toInt() ?? 1,
      status: VillaStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => VillaStatus.vacant,
      ),
      createdAt: _readDateTime(json['createdAt']),
      updatedAt: _readDateTime(json['updatedAt']),
    );
  }

  Income _incomeFromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'] as String,
      villaId: json['villaId'] as String? ?? '',
      villaName: json['villaName'] as String? ?? '',
      incomeType: json['incomeType'] as String? ?? IncomeTypes.other,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      paymentDate: _readDateTime(json['paymentDate']),
      paymentMethod:
          json['paymentMethod'] as String? ?? IncomePaymentMethods.other,
      monthCovered: _readDateTime(json['monthCovered']),
      notes: json['notes'] as String? ?? '',
    );
  }

  Expense _expenseFromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      villaId: json['villaId'] as String?,
      villaName: json['villaName'] as String? ?? 'General Expense',
      category: json['category'] as String? ?? ExpenseCategories.other,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      expenseDate: _readDateTime(json['expenseDate']),
      paidTo: json['paidTo'] as String? ?? '',
      paymentMethod:
          json['paymentMethod'] as String? ?? ExpensePaymentMethods.other,
      notes: json['notes'] as String? ?? '',
    );
  }

  DateTime _readDateTime(Object? value) {
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  bool get _isFirestoreEnabled {
    if (kIsWeb) return true;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

class _SyncRecord {
  final String collection;
  final String id;
  final Map<String, dynamic> data;
  final DateTime queuedAt;

  const _SyncRecord({
    required this.collection,
    required this.id,
    required this.data,
    required this.queuedAt,
  });

  factory _SyncRecord.fromJson(Map<String, dynamic> json) {
    return _SyncRecord(
      collection: json['collection'] as String,
      id: json['id'] as String,
      data: Map<String, dynamic>.from(json['data'] as Map),
      queuedAt: DateTime.parse(json['queuedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collection': collection,
      'id': id,
      'data': data,
      'queuedAt': queuedAt.toIso8601String(),
    };
  }
}
