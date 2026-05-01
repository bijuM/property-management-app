// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VillasTable extends Villas with TableInfo<$VillasTable, Villa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VillasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _villaNameMeta =
      const VerificationMeta('villaName');
  @override
  late final GeneratedColumn<String> villaName = GeneratedColumn<String>(
      'villa_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _villaNumberMeta =
      const VerificationMeta('villaNumber');
  @override
  late final GeneratedColumn<String> villaNumber = GeneratedColumn<String>(
      'villa_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantNameMeta =
      const VerificationMeta('tenantName');
  @override
  late final GeneratedColumn<String> tenantName = GeneratedColumn<String>(
      'tenant_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantPhoneMeta =
      const VerificationMeta('tenantPhone');
  @override
  late final GeneratedColumn<String> tenantPhone = GeneratedColumn<String>(
      'tenant_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthlyRentMeta =
      const VerificationMeta('monthlyRent');
  @override
  late final GeneratedColumn<double> monthlyRent = GeneratedColumn<double>(
      'monthly_rent', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _contractStartDateMeta =
      const VerificationMeta('contractStartDate');
  @override
  late final GeneratedColumn<DateTime> contractStartDate =
      GeneratedColumn<DateTime>('contract_start_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _contractEndDateMeta =
      const VerificationMeta('contractEndDate');
  @override
  late final GeneratedColumn<DateTime> contractEndDate =
      GeneratedColumn<DateTime>('contract_end_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paymentDueDayMeta =
      const VerificationMeta('paymentDueDay');
  @override
  late final GeneratedColumn<int> paymentDueDay = GeneratedColumn<int>(
      'payment_due_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        villaName,
        villaNumber,
        location,
        tenantName,
        tenantPhone,
        monthlyRent,
        contractStartDate,
        contractEndDate,
        paymentDueDay,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'villas';
  @override
  VerificationContext validateIntegrity(Insertable<Villa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_name')) {
      context.handle(_villaNameMeta,
          villaName.isAcceptableOrUnknown(data['villa_name']!, _villaNameMeta));
    } else if (isInserting) {
      context.missing(_villaNameMeta);
    }
    if (data.containsKey('villa_number')) {
      context.handle(
          _villaNumberMeta,
          villaNumber.isAcceptableOrUnknown(
              data['villa_number']!, _villaNumberMeta));
    } else if (isInserting) {
      context.missing(_villaNumberMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('tenant_name')) {
      context.handle(
          _tenantNameMeta,
          tenantName.isAcceptableOrUnknown(
              data['tenant_name']!, _tenantNameMeta));
    } else if (isInserting) {
      context.missing(_tenantNameMeta);
    }
    if (data.containsKey('tenant_phone')) {
      context.handle(
          _tenantPhoneMeta,
          tenantPhone.isAcceptableOrUnknown(
              data['tenant_phone']!, _tenantPhoneMeta));
    } else if (isInserting) {
      context.missing(_tenantPhoneMeta);
    }
    if (data.containsKey('monthly_rent')) {
      context.handle(
          _monthlyRentMeta,
          monthlyRent.isAcceptableOrUnknown(
              data['monthly_rent']!, _monthlyRentMeta));
    } else if (isInserting) {
      context.missing(_monthlyRentMeta);
    }
    if (data.containsKey('contract_start_date')) {
      context.handle(
          _contractStartDateMeta,
          contractStartDate.isAcceptableOrUnknown(
              data['contract_start_date']!, _contractStartDateMeta));
    } else if (isInserting) {
      context.missing(_contractStartDateMeta);
    }
    if (data.containsKey('contract_end_date')) {
      context.handle(
          _contractEndDateMeta,
          contractEndDate.isAcceptableOrUnknown(
              data['contract_end_date']!, _contractEndDateMeta));
    } else if (isInserting) {
      context.missing(_contractEndDateMeta);
    }
    if (data.containsKey('payment_due_day')) {
      context.handle(
          _paymentDueDayMeta,
          paymentDueDay.isAcceptableOrUnknown(
              data['payment_due_day']!, _paymentDueDayMeta));
    } else if (isInserting) {
      context.missing(_paymentDueDayMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Villa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Villa(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      villaName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}villa_name'])!,
      villaNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}villa_number'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      tenantName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_name'])!,
      tenantPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_phone'])!,
      monthlyRent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monthly_rent'])!,
      contractStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}contract_start_date'])!,
      contractEndDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}contract_end_date'])!,
      paymentDueDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_due_day'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $VillasTable createAlias(String alias) {
    return $VillasTable(attachedDatabase, alias);
  }
}

class Villa extends DataClass implements Insertable<Villa> {
  final String id;
  final String villaName;
  final String villaNumber;
  final String location;
  final String tenantName;
  final String tenantPhone;
  final double monthlyRent;
  final DateTime contractStartDate;
  final DateTime contractEndDate;
  final int paymentDueDay;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Villa(
      {required this.id,
      required this.villaName,
      required this.villaNumber,
      required this.location,
      required this.tenantName,
      required this.tenantPhone,
      required this.monthlyRent,
      required this.contractStartDate,
      required this.contractEndDate,
      required this.paymentDueDay,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['villa_name'] = Variable<String>(villaName);
    map['villa_number'] = Variable<String>(villaNumber);
    map['location'] = Variable<String>(location);
    map['tenant_name'] = Variable<String>(tenantName);
    map['tenant_phone'] = Variable<String>(tenantPhone);
    map['monthly_rent'] = Variable<double>(monthlyRent);
    map['contract_start_date'] = Variable<DateTime>(contractStartDate);
    map['contract_end_date'] = Variable<DateTime>(contractEndDate);
    map['payment_due_day'] = Variable<int>(paymentDueDay);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VillasCompanion toCompanion(bool nullToAbsent) {
    return VillasCompanion(
      id: Value(id),
      villaName: Value(villaName),
      villaNumber: Value(villaNumber),
      location: Value(location),
      tenantName: Value(tenantName),
      tenantPhone: Value(tenantPhone),
      monthlyRent: Value(monthlyRent),
      contractStartDate: Value(contractStartDate),
      contractEndDate: Value(contractEndDate),
      paymentDueDay: Value(paymentDueDay),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Villa.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Villa(
      id: serializer.fromJson<String>(json['id']),
      villaName: serializer.fromJson<String>(json['villaName']),
      villaNumber: serializer.fromJson<String>(json['villaNumber']),
      location: serializer.fromJson<String>(json['location']),
      tenantName: serializer.fromJson<String>(json['tenantName']),
      tenantPhone: serializer.fromJson<String>(json['tenantPhone']),
      monthlyRent: serializer.fromJson<double>(json['monthlyRent']),
      contractStartDate:
          serializer.fromJson<DateTime>(json['contractStartDate']),
      contractEndDate: serializer.fromJson<DateTime>(json['contractEndDate']),
      paymentDueDay: serializer.fromJson<int>(json['paymentDueDay']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaName': serializer.toJson<String>(villaName),
      'villaNumber': serializer.toJson<String>(villaNumber),
      'location': serializer.toJson<String>(location),
      'tenantName': serializer.toJson<String>(tenantName),
      'tenantPhone': serializer.toJson<String>(tenantPhone),
      'monthlyRent': serializer.toJson<double>(monthlyRent),
      'contractStartDate': serializer.toJson<DateTime>(contractStartDate),
      'contractEndDate': serializer.toJson<DateTime>(contractEndDate),
      'paymentDueDay': serializer.toJson<int>(paymentDueDay),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Villa copyWith(
          {String? id,
          String? villaName,
          String? villaNumber,
          String? location,
          String? tenantName,
          String? tenantPhone,
          double? monthlyRent,
          DateTime? contractStartDate,
          DateTime? contractEndDate,
          int? paymentDueDay,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Villa(
        id: id ?? this.id,
        villaName: villaName ?? this.villaName,
        villaNumber: villaNumber ?? this.villaNumber,
        location: location ?? this.location,
        tenantName: tenantName ?? this.tenantName,
        tenantPhone: tenantPhone ?? this.tenantPhone,
        monthlyRent: monthlyRent ?? this.monthlyRent,
        contractStartDate: contractStartDate ?? this.contractStartDate,
        contractEndDate: contractEndDate ?? this.contractEndDate,
        paymentDueDay: paymentDueDay ?? this.paymentDueDay,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Villa copyWithCompanion(VillasCompanion data) {
    return Villa(
      id: data.id.present ? data.id.value : this.id,
      villaName: data.villaName.present ? data.villaName.value : this.villaName,
      villaNumber:
          data.villaNumber.present ? data.villaNumber.value : this.villaNumber,
      location: data.location.present ? data.location.value : this.location,
      tenantName:
          data.tenantName.present ? data.tenantName.value : this.tenantName,
      tenantPhone:
          data.tenantPhone.present ? data.tenantPhone.value : this.tenantPhone,
      monthlyRent:
          data.monthlyRent.present ? data.monthlyRent.value : this.monthlyRent,
      contractStartDate: data.contractStartDate.present
          ? data.contractStartDate.value
          : this.contractStartDate,
      contractEndDate: data.contractEndDate.present
          ? data.contractEndDate.value
          : this.contractEndDate,
      paymentDueDay: data.paymentDueDay.present
          ? data.paymentDueDay.value
          : this.paymentDueDay,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Villa(')
          ..write('id: $id, ')
          ..write('villaName: $villaName, ')
          ..write('villaNumber: $villaNumber, ')
          ..write('location: $location, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantPhone: $tenantPhone, ')
          ..write('monthlyRent: $monthlyRent, ')
          ..write('contractStartDate: $contractStartDate, ')
          ..write('contractEndDate: $contractEndDate, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      villaName,
      villaNumber,
      location,
      tenantName,
      tenantPhone,
      monthlyRent,
      contractStartDate,
      contractEndDate,
      paymentDueDay,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Villa &&
          other.id == this.id &&
          other.villaName == this.villaName &&
          other.villaNumber == this.villaNumber &&
          other.location == this.location &&
          other.tenantName == this.tenantName &&
          other.tenantPhone == this.tenantPhone &&
          other.monthlyRent == this.monthlyRent &&
          other.contractStartDate == this.contractStartDate &&
          other.contractEndDate == this.contractEndDate &&
          other.paymentDueDay == this.paymentDueDay &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VillasCompanion extends UpdateCompanion<Villa> {
  final Value<String> id;
  final Value<String> villaName;
  final Value<String> villaNumber;
  final Value<String> location;
  final Value<String> tenantName;
  final Value<String> tenantPhone;
  final Value<double> monthlyRent;
  final Value<DateTime> contractStartDate;
  final Value<DateTime> contractEndDate;
  final Value<int> paymentDueDay;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VillasCompanion({
    this.id = const Value.absent(),
    this.villaName = const Value.absent(),
    this.villaNumber = const Value.absent(),
    this.location = const Value.absent(),
    this.tenantName = const Value.absent(),
    this.tenantPhone = const Value.absent(),
    this.monthlyRent = const Value.absent(),
    this.contractStartDate = const Value.absent(),
    this.contractEndDate = const Value.absent(),
    this.paymentDueDay = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VillasCompanion.insert({
    required String id,
    required String villaName,
    required String villaNumber,
    required String location,
    required String tenantName,
    required String tenantPhone,
    required double monthlyRent,
    required DateTime contractStartDate,
    required DateTime contractEndDate,
    required int paymentDueDay,
    required String status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        villaName = Value(villaName),
        villaNumber = Value(villaNumber),
        location = Value(location),
        tenantName = Value(tenantName),
        tenantPhone = Value(tenantPhone),
        monthlyRent = Value(monthlyRent),
        contractStartDate = Value(contractStartDate),
        contractEndDate = Value(contractEndDate),
        paymentDueDay = Value(paymentDueDay),
        status = Value(status);
  static Insertable<Villa> custom({
    Expression<String>? id,
    Expression<String>? villaName,
    Expression<String>? villaNumber,
    Expression<String>? location,
    Expression<String>? tenantName,
    Expression<String>? tenantPhone,
    Expression<double>? monthlyRent,
    Expression<DateTime>? contractStartDate,
    Expression<DateTime>? contractEndDate,
    Expression<int>? paymentDueDay,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaName != null) 'villa_name': villaName,
      if (villaNumber != null) 'villa_number': villaNumber,
      if (location != null) 'location': location,
      if (tenantName != null) 'tenant_name': tenantName,
      if (tenantPhone != null) 'tenant_phone': tenantPhone,
      if (monthlyRent != null) 'monthly_rent': monthlyRent,
      if (contractStartDate != null) 'contract_start_date': contractStartDate,
      if (contractEndDate != null) 'contract_end_date': contractEndDate,
      if (paymentDueDay != null) 'payment_due_day': paymentDueDay,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VillasCompanion copyWith(
      {Value<String>? id,
      Value<String>? villaName,
      Value<String>? villaNumber,
      Value<String>? location,
      Value<String>? tenantName,
      Value<String>? tenantPhone,
      Value<double>? monthlyRent,
      Value<DateTime>? contractStartDate,
      Value<DateTime>? contractEndDate,
      Value<int>? paymentDueDay,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return VillasCompanion(
      id: id ?? this.id,
      villaName: villaName ?? this.villaName,
      villaNumber: villaNumber ?? this.villaNumber,
      location: location ?? this.location,
      tenantName: tenantName ?? this.tenantName,
      tenantPhone: tenantPhone ?? this.tenantPhone,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      paymentDueDay: paymentDueDay ?? this.paymentDueDay,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaName.present) {
      map['villa_name'] = Variable<String>(villaName.value);
    }
    if (villaNumber.present) {
      map['villa_number'] = Variable<String>(villaNumber.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (tenantName.present) {
      map['tenant_name'] = Variable<String>(tenantName.value);
    }
    if (tenantPhone.present) {
      map['tenant_phone'] = Variable<String>(tenantPhone.value);
    }
    if (monthlyRent.present) {
      map['monthly_rent'] = Variable<double>(monthlyRent.value);
    }
    if (contractStartDate.present) {
      map['contract_start_date'] = Variable<DateTime>(contractStartDate.value);
    }
    if (contractEndDate.present) {
      map['contract_end_date'] = Variable<DateTime>(contractEndDate.value);
    }
    if (paymentDueDay.present) {
      map['payment_due_day'] = Variable<int>(paymentDueDay.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillasCompanion(')
          ..write('id: $id, ')
          ..write('villaName: $villaName, ')
          ..write('villaNumber: $villaNumber, ')
          ..write('location: $location, ')
          ..write('tenantName: $tenantName, ')
          ..write('tenantPhone: $tenantPhone, ')
          ..write('monthlyRent: $monthlyRent, ')
          ..write('contractStartDate: $contractStartDate, ')
          ..write('contractEndDate: $contractEndDate, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _villaIdMeta =
      const VerificationMeta('villaId');
  @override
  late final GeneratedColumn<String> villaId = GeneratedColumn<String>(
      'villa_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES villas (id)'));
  static const VerificationMeta _villaNameMeta =
      const VerificationMeta('villaName');
  @override
  late final GeneratedColumn<String> villaName = GeneratedColumn<String>(
      'villa_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _incomeTypeMeta =
      const VerificationMeta('incomeType');
  @override
  late final GeneratedColumn<String> incomeType = GeneratedColumn<String>(
      'income_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthCoveredMeta =
      const VerificationMeta('monthCovered');
  @override
  late final GeneratedColumn<DateTime> monthCovered = GeneratedColumn<DateTime>(
      'month_covered', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        villaId,
        villaName,
        incomeType,
        amount,
        paymentDate,
        paymentMethod,
        monthCovered,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes';
  @override
  VerificationContext validateIntegrity(Insertable<Income> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_id')) {
      context.handle(_villaIdMeta,
          villaId.isAcceptableOrUnknown(data['villa_id']!, _villaIdMeta));
    } else if (isInserting) {
      context.missing(_villaIdMeta);
    }
    if (data.containsKey('villa_name')) {
      context.handle(_villaNameMeta,
          villaName.isAcceptableOrUnknown(data['villa_name']!, _villaNameMeta));
    }
    if (data.containsKey('income_type')) {
      context.handle(
          _incomeTypeMeta,
          incomeType.isAcceptableOrUnknown(
              data['income_type']!, _incomeTypeMeta));
    } else if (isInserting) {
      context.missing(_incomeTypeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('month_covered')) {
      context.handle(
          _monthCoveredMeta,
          monthCovered.isAcceptableOrUnknown(
              data['month_covered']!, _monthCoveredMeta));
    } else if (isInserting) {
      context.missing(_monthCoveredMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      villaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}villa_id'])!,
      villaName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}villa_name'])!,
      incomeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}income_type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      monthCovered: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}month_covered'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }
}

class Income extends DataClass implements Insertable<Income> {
  final String id;
  final String villaId;
  final String villaName;
  final String incomeType;
  final double amount;
  final DateTime paymentDate;
  final String paymentMethod;
  final DateTime monthCovered;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Income(
      {required this.id,
      required this.villaId,
      required this.villaName,
      required this.incomeType,
      required this.amount,
      required this.paymentDate,
      required this.paymentMethod,
      required this.monthCovered,
      this.notes,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['villa_id'] = Variable<String>(villaId);
    map['villa_name'] = Variable<String>(villaName);
    map['income_type'] = Variable<String>(incomeType);
    map['amount'] = Variable<double>(amount);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['month_covered'] = Variable<DateTime>(monthCovered);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  IncomesCompanion toCompanion(bool nullToAbsent) {
    return IncomesCompanion(
      id: Value(id),
      villaId: Value(villaId),
      villaName: Value(villaName),
      incomeType: Value(incomeType),
      amount: Value(amount),
      paymentDate: Value(paymentDate),
      paymentMethod: Value(paymentMethod),
      monthCovered: Value(monthCovered),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Income.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Income(
      id: serializer.fromJson<String>(json['id']),
      villaId: serializer.fromJson<String>(json['villaId']),
      villaName: serializer.fromJson<String>(json['villaName']),
      incomeType: serializer.fromJson<String>(json['incomeType']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      monthCovered: serializer.fromJson<DateTime>(json['monthCovered']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaId': serializer.toJson<String>(villaId),
      'villaName': serializer.toJson<String>(villaName),
      'incomeType': serializer.toJson<String>(incomeType),
      'amount': serializer.toJson<double>(amount),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'monthCovered': serializer.toJson<DateTime>(monthCovered),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Income copyWith(
          {String? id,
          String? villaId,
          String? villaName,
          String? incomeType,
          double? amount,
          DateTime? paymentDate,
          String? paymentMethod,
          DateTime? monthCovered,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Income(
        id: id ?? this.id,
        villaId: villaId ?? this.villaId,
        villaName: villaName ?? this.villaName,
        incomeType: incomeType ?? this.incomeType,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        monthCovered: monthCovered ?? this.monthCovered,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Income copyWithCompanion(IncomesCompanion data) {
    return Income(
      id: data.id.present ? data.id.value : this.id,
      villaId: data.villaId.present ? data.villaId.value : this.villaId,
      villaName: data.villaName.present ? data.villaName.value : this.villaName,
      incomeType:
          data.incomeType.present ? data.incomeType.value : this.incomeType,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      monthCovered: data.monthCovered.present
          ? data.monthCovered.value
          : this.monthCovered,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Income(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('villaName: $villaName, ')
          ..write('incomeType: $incomeType, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('monthCovered: $monthCovered, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, villaId, villaName, incomeType, amount,
      paymentDate, paymentMethod, monthCovered, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Income &&
          other.id == this.id &&
          other.villaId == this.villaId &&
          other.villaName == this.villaName &&
          other.incomeType == this.incomeType &&
          other.amount == this.amount &&
          other.paymentDate == this.paymentDate &&
          other.paymentMethod == this.paymentMethod &&
          other.monthCovered == this.monthCovered &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IncomesCompanion extends UpdateCompanion<Income> {
  final Value<String> id;
  final Value<String> villaId;
  final Value<String> villaName;
  final Value<String> incomeType;
  final Value<double> amount;
  final Value<DateTime> paymentDate;
  final Value<String> paymentMethod;
  final Value<DateTime> monthCovered;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const IncomesCompanion({
    this.id = const Value.absent(),
    this.villaId = const Value.absent(),
    this.villaName = const Value.absent(),
    this.incomeType = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.monthCovered = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesCompanion.insert({
    required String id,
    required String villaId,
    this.villaName = const Value.absent(),
    required String incomeType,
    required double amount,
    required DateTime paymentDate,
    required String paymentMethod,
    required DateTime monthCovered,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        villaId = Value(villaId),
        incomeType = Value(incomeType),
        amount = Value(amount),
        paymentDate = Value(paymentDate),
        paymentMethod = Value(paymentMethod),
        monthCovered = Value(monthCovered);
  static Insertable<Income> custom({
    Expression<String>? id,
    Expression<String>? villaId,
    Expression<String>? villaName,
    Expression<String>? incomeType,
    Expression<double>? amount,
    Expression<DateTime>? paymentDate,
    Expression<String>? paymentMethod,
    Expression<DateTime>? monthCovered,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaId != null) 'villa_id': villaId,
      if (villaName != null) 'villa_name': villaName,
      if (incomeType != null) 'income_type': incomeType,
      if (amount != null) 'amount': amount,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (monthCovered != null) 'month_covered': monthCovered,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesCompanion copyWith(
      {Value<String>? id,
      Value<String>? villaId,
      Value<String>? villaName,
      Value<String>? incomeType,
      Value<double>? amount,
      Value<DateTime>? paymentDate,
      Value<String>? paymentMethod,
      Value<DateTime>? monthCovered,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return IncomesCompanion(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      villaName: villaName ?? this.villaName,
      incomeType: incomeType ?? this.incomeType,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      monthCovered: monthCovered ?? this.monthCovered,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaId.present) {
      map['villa_id'] = Variable<String>(villaId.value);
    }
    if (villaName.present) {
      map['villa_name'] = Variable<String>(villaName.value);
    }
    if (incomeType.present) {
      map['income_type'] = Variable<String>(incomeType.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (monthCovered.present) {
      map['month_covered'] = Variable<DateTime>(monthCovered.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCompanion(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('villaName: $villaName, ')
          ..write('incomeType: $incomeType, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('monthCovered: $monthCovered, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _villaIdMeta =
      const VerificationMeta('villaId');
  @override
  late final GeneratedColumn<String> villaId = GeneratedColumn<String>(
      'villa_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES villas (id)'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _expenseDateMeta =
      const VerificationMeta('expenseDate');
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
      'expense_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _paidToMeta = const VerificationMeta('paidTo');
  @override
  late final GeneratedColumn<String> paidTo = GeneratedColumn<String>(
      'paid_to', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        villaId,
        category,
        amount,
        expenseDate,
        paidTo,
        paymentMethod,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_id')) {
      context.handle(_villaIdMeta,
          villaId.isAcceptableOrUnknown(data['villa_id']!, _villaIdMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('expense_date')) {
      context.handle(
          _expenseDateMeta,
          expenseDate.isAcceptableOrUnknown(
              data['expense_date']!, _expenseDateMeta));
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('paid_to')) {
      context.handle(_paidToMeta,
          paidTo.isAcceptableOrUnknown(data['paid_to']!, _paidToMeta));
    } else if (isInserting) {
      context.missing(_paidToMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      villaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}villa_id']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      expenseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expense_date'])!,
      paidTo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}paid_to'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String? villaId;
  final String category;
  final double amount;
  final DateTime expenseDate;
  final String paidTo;
  final String paymentMethod;
  final String? notes;
  final DateTime createdAt;
  const Expense(
      {required this.id,
      this.villaId,
      required this.category,
      required this.amount,
      required this.expenseDate,
      required this.paidTo,
      required this.paymentMethod,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || villaId != null) {
      map['villa_id'] = Variable<String>(villaId);
    }
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    map['paid_to'] = Variable<String>(paidTo);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      villaId: villaId == null && nullToAbsent
          ? const Value.absent()
          : Value(villaId),
      category: Value(category),
      amount: Value(amount),
      expenseDate: Value(expenseDate),
      paidTo: Value(paidTo),
      paymentMethod: Value(paymentMethod),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      villaId: serializer.fromJson<String?>(json['villaId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      paidTo: serializer.fromJson<String>(json['paidTo']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaId': serializer.toJson<String?>(villaId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'paidTo': serializer.toJson<String>(paidTo),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith(
          {String? id,
          Value<String?> villaId = const Value.absent(),
          String? category,
          double? amount,
          DateTime? expenseDate,
          String? paidTo,
          String? paymentMethod,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Expense(
        id: id ?? this.id,
        villaId: villaId.present ? villaId.value : this.villaId,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        expenseDate: expenseDate ?? this.expenseDate,
        paidTo: paidTo ?? this.paidTo,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      villaId: data.villaId.present ? data.villaId.value : this.villaId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      expenseDate:
          data.expenseDate.present ? data.expenseDate.value : this.expenseDate,
      paidTo: data.paidTo.present ? data.paidTo.value : this.paidTo,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('paidTo: $paidTo, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, villaId, category, amount, expenseDate,
      paidTo, paymentMethod, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.villaId == this.villaId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.expenseDate == this.expenseDate &&
          other.paidTo == this.paidTo &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String?> villaId;
  final Value<String> category;
  final Value<double> amount;
  final Value<DateTime> expenseDate;
  final Value<String> paidTo;
  final Value<String> paymentMethod;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.villaId = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.paidTo = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    this.villaId = const Value.absent(),
    required String category,
    required double amount,
    required DateTime expenseDate,
    required String paidTo,
    required String paymentMethod,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        amount = Value(amount),
        expenseDate = Value(expenseDate),
        paidTo = Value(paidTo),
        paymentMethod = Value(paymentMethod);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? villaId,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<DateTime>? expenseDate,
    Expression<String>? paidTo,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaId != null) 'villa_id': villaId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (paidTo != null) 'paid_to': paidTo,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? villaId,
      Value<String>? category,
      Value<double>? amount,
      Value<DateTime>? expenseDate,
      Value<String>? paidTo,
      Value<String>? paymentMethod,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      expenseDate: expenseDate ?? this.expenseDate,
      paidTo: paidTo ?? this.paidTo,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaId.present) {
      map['villa_id'] = Variable<String>(villaId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (paidTo.present) {
      map['paid_to'] = Variable<String>(paidTo.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('paidTo: $paidTo, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VillasTable villas = $VillasTable(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [villas, incomes, expenses];
}

typedef $$VillasTableCreateCompanionBuilder = VillasCompanion Function({
  required String id,
  required String villaName,
  required String villaNumber,
  required String location,
  required String tenantName,
  required String tenantPhone,
  required double monthlyRent,
  required DateTime contractStartDate,
  required DateTime contractEndDate,
  required int paymentDueDay,
  required String status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$VillasTableUpdateCompanionBuilder = VillasCompanion Function({
  Value<String> id,
  Value<String> villaName,
  Value<String> villaNumber,
  Value<String> location,
  Value<String> tenantName,
  Value<String> tenantPhone,
  Value<double> monthlyRent,
  Value<DateTime> contractStartDate,
  Value<DateTime> contractEndDate,
  Value<int> paymentDueDay,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$VillasTableReferences
    extends BaseReferences<_$AppDatabase, $VillasTable, Villa> {
  $$VillasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IncomesTable, List<Income>> _incomesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.incomes,
          aliasName: $_aliasNameGenerator(db.villas.id, db.incomes.villaId));

  $$IncomesTableProcessedTableManager get incomesRefs {
    final manager = $$IncomesTableTableManager($_db, $_db.incomes)
        .filter((f) => f.villaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_incomesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenses,
          aliasName: $_aliasNameGenerator(db.villas.id, db.expenses.villaId));

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.villaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VillasTableFilterComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get villaName => $composableBuilder(
      column: $table.villaName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get villaNumber => $composableBuilder(
      column: $table.villaNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantPhone => $composableBuilder(
      column: $table.tenantPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get contractStartDate => $composableBuilder(
      column: $table.contractStartDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get contractEndDate => $composableBuilder(
      column: $table.contractEndDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> incomesRefs(
      Expression<bool> Function($$IncomesTableFilterComposer f) f) {
    final $$IncomesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomes,
        getReferencedColumn: (t) => t.villaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomesTableFilterComposer(
              $db: $db,
              $table: $db.incomes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> expensesRefs(
      Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.villaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VillasTableOrderingComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get villaName => $composableBuilder(
      column: $table.villaName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get villaNumber => $composableBuilder(
      column: $table.villaNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantPhone => $composableBuilder(
      column: $table.tenantPhone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get contractStartDate => $composableBuilder(
      column: $table.contractStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get contractEndDate => $composableBuilder(
      column: $table.contractEndDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$VillasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get villaName =>
      $composableBuilder(column: $table.villaName, builder: (column) => column);

  GeneratedColumn<String> get villaNumber => $composableBuilder(
      column: $table.villaNumber, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => column);

  GeneratedColumn<String> get tenantPhone => $composableBuilder(
      column: $table.tenantPhone, builder: (column) => column);

  GeneratedColumn<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => column);

  GeneratedColumn<DateTime> get contractStartDate => $composableBuilder(
      column: $table.contractStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get contractEndDate => $composableBuilder(
      column: $table.contractEndDate, builder: (column) => column);

  GeneratedColumn<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> incomesRefs<T extends Object>(
      Expression<T> Function($$IncomesTableAnnotationComposer a) f) {
    final $$IncomesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.incomes,
        getReferencedColumn: (t) => t.villaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IncomesTableAnnotationComposer(
              $db: $db,
              $table: $db.incomes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
      Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.villaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VillasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VillasTable,
    Villa,
    $$VillasTableFilterComposer,
    $$VillasTableOrderingComposer,
    $$VillasTableAnnotationComposer,
    $$VillasTableCreateCompanionBuilder,
    $$VillasTableUpdateCompanionBuilder,
    (Villa, $$VillasTableReferences),
    Villa,
    PrefetchHooks Function({bool incomesRefs, bool expensesRefs})> {
  $$VillasTableTableManager(_$AppDatabase db, $VillasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VillasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VillasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VillasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> villaName = const Value.absent(),
            Value<String> villaNumber = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> tenantName = const Value.absent(),
            Value<String> tenantPhone = const Value.absent(),
            Value<double> monthlyRent = const Value.absent(),
            Value<DateTime> contractStartDate = const Value.absent(),
            Value<DateTime> contractEndDate = const Value.absent(),
            Value<int> paymentDueDay = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VillasCompanion(
            id: id,
            villaName: villaName,
            villaNumber: villaNumber,
            location: location,
            tenantName: tenantName,
            tenantPhone: tenantPhone,
            monthlyRent: monthlyRent,
            contractStartDate: contractStartDate,
            contractEndDate: contractEndDate,
            paymentDueDay: paymentDueDay,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String villaName,
            required String villaNumber,
            required String location,
            required String tenantName,
            required String tenantPhone,
            required double monthlyRent,
            required DateTime contractStartDate,
            required DateTime contractEndDate,
            required int paymentDueDay,
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VillasCompanion.insert(
            id: id,
            villaName: villaName,
            villaNumber: villaNumber,
            location: location,
            tenantName: tenantName,
            tenantPhone: tenantPhone,
            monthlyRent: monthlyRent,
            contractStartDate: contractStartDate,
            contractEndDate: contractEndDate,
            paymentDueDay: paymentDueDay,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VillasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({incomesRefs = false, expensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (incomesRefs) db.incomes,
                if (expensesRefs) db.expenses
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (incomesRefs)
                    await $_getPrefetchedData<Villa, $VillasTable, Income>(
                        currentTable: table,
                        referencedTable:
                            $$VillasTableReferences._incomesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VillasTableReferences(db, table, p0).incomesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.villaId == item.id),
                        typedResults: items),
                  if (expensesRefs)
                    await $_getPrefetchedData<Villa, $VillasTable, Expense>(
                        currentTable: table,
                        referencedTable:
                            $$VillasTableReferences._expensesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VillasTableReferences(db, table, p0).expensesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.villaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VillasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VillasTable,
    Villa,
    $$VillasTableFilterComposer,
    $$VillasTableOrderingComposer,
    $$VillasTableAnnotationComposer,
    $$VillasTableCreateCompanionBuilder,
    $$VillasTableUpdateCompanionBuilder,
    (Villa, $$VillasTableReferences),
    Villa,
    PrefetchHooks Function({bool incomesRefs, bool expensesRefs})>;
typedef $$IncomesTableCreateCompanionBuilder = IncomesCompanion Function({
  required String id,
  required String villaId,
  Value<String> villaName,
  required String incomeType,
  required double amount,
  required DateTime paymentDate,
  required String paymentMethod,
  required DateTime monthCovered,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$IncomesTableUpdateCompanionBuilder = IncomesCompanion Function({
  Value<String> id,
  Value<String> villaId,
  Value<String> villaName,
  Value<String> incomeType,
  Value<double> amount,
  Value<DateTime> paymentDate,
  Value<String> paymentMethod,
  Value<DateTime> monthCovered,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$IncomesTableReferences
    extends BaseReferences<_$AppDatabase, $IncomesTable, Income> {
  $$IncomesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VillasTable _villaIdTable(_$AppDatabase db) => db.villas
      .createAlias($_aliasNameGenerator(db.incomes.villaId, db.villas.id));

  $$VillasTableProcessedTableManager get villaId {
    final $_column = $_itemColumn<String>('villa_id')!;

    final manager = $$VillasTableTableManager($_db, $_db.villas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IncomesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get villaName => $composableBuilder(
      column: $table.villaName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get incomeType => $composableBuilder(
      column: $table.incomeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get monthCovered => $composableBuilder(
      column: $table.monthCovered, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$VillasTableFilterComposer get villaId {
    final $$VillasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableFilterComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get villaName => $composableBuilder(
      column: $table.villaName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get incomeType => $composableBuilder(
      column: $table.incomeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get monthCovered => $composableBuilder(
      column: $table.monthCovered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$VillasTableOrderingComposer get villaId {
    final $$VillasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableOrderingComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get villaName =>
      $composableBuilder(column: $table.villaName, builder: (column) => column);

  GeneratedColumn<String> get incomeType => $composableBuilder(
      column: $table.incomeType, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<DateTime> get monthCovered => $composableBuilder(
      column: $table.monthCovered, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VillasTableAnnotationComposer get villaId {
    final $$VillasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableAnnotationComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IncomesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IncomesTable,
    Income,
    $$IncomesTableFilterComposer,
    $$IncomesTableOrderingComposer,
    $$IncomesTableAnnotationComposer,
    $$IncomesTableCreateCompanionBuilder,
    $$IncomesTableUpdateCompanionBuilder,
    (Income, $$IncomesTableReferences),
    Income,
    PrefetchHooks Function({bool villaId})> {
  $$IncomesTableTableManager(_$AppDatabase db, $IncomesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> villaId = const Value.absent(),
            Value<String> villaName = const Value.absent(),
            Value<String> incomeType = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<DateTime> monthCovered = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IncomesCompanion(
            id: id,
            villaId: villaId,
            villaName: villaName,
            incomeType: incomeType,
            amount: amount,
            paymentDate: paymentDate,
            paymentMethod: paymentMethod,
            monthCovered: monthCovered,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String villaId,
            Value<String> villaName = const Value.absent(),
            required String incomeType,
            required double amount,
            required DateTime paymentDate,
            required String paymentMethod,
            required DateTime monthCovered,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IncomesCompanion.insert(
            id: id,
            villaId: villaId,
            villaName: villaName,
            incomeType: incomeType,
            amount: amount,
            paymentDate: paymentDate,
            paymentMethod: paymentMethod,
            monthCovered: monthCovered,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$IncomesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({villaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (villaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.villaId,
                    referencedTable: $$IncomesTableReferences._villaIdTable(db),
                    referencedColumn:
                        $$IncomesTableReferences._villaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IncomesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IncomesTable,
    Income,
    $$IncomesTableFilterComposer,
    $$IncomesTableOrderingComposer,
    $$IncomesTableAnnotationComposer,
    $$IncomesTableCreateCompanionBuilder,
    $$IncomesTableUpdateCompanionBuilder,
    (Income, $$IncomesTableReferences),
    Income,
    PrefetchHooks Function({bool villaId})>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  Value<String?> villaId,
  required String category,
  required double amount,
  required DateTime expenseDate,
  required String paidTo,
  required String paymentMethod,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<String?> villaId,
  Value<String> category,
  Value<double> amount,
  Value<DateTime> expenseDate,
  Value<String> paidTo,
  Value<String> paymentMethod,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VillasTable _villaIdTable(_$AppDatabase db) => db.villas
      .createAlias($_aliasNameGenerator(db.expenses.villaId, db.villas.id));

  $$VillasTableProcessedTableManager? get villaId {
    final $_column = $_itemColumn<String>('villa_id');
    if ($_column == null) return null;
    final manager = $$VillasTableTableManager($_db, $_db.villas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paidTo => $composableBuilder(
      column: $table.paidTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$VillasTableFilterComposer get villaId {
    final $$VillasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableFilterComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paidTo => $composableBuilder(
      column: $table.paidTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$VillasTableOrderingComposer get villaId {
    final $$VillasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableOrderingComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => column);

  GeneratedColumn<String> get paidTo =>
      $composableBuilder(column: $table.paidTo, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VillasTableAnnotationComposer get villaId {
    final $$VillasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.villaId,
        referencedTable: $db.villas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VillasTableAnnotationComposer(
              $db: $db,
              $table: $db.villas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool villaId})> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> villaId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> expenseDate = const Value.absent(),
            Value<String> paidTo = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            villaId: villaId,
            category: category,
            amount: amount,
            expenseDate: expenseDate,
            paidTo: paidTo,
            paymentMethod: paymentMethod,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> villaId = const Value.absent(),
            required String category,
            required double amount,
            required DateTime expenseDate,
            required String paidTo,
            required String paymentMethod,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            villaId: villaId,
            category: category,
            amount: amount,
            expenseDate: expenseDate,
            paidTo: paidTo,
            paymentMethod: paymentMethod,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({villaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (villaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.villaId,
                    referencedTable:
                        $$ExpensesTableReferences._villaIdTable(db),
                    referencedColumn:
                        $$ExpensesTableReferences._villaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool villaId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VillasTableTableManager get villas =>
      $$VillasTableTableManager(_db, _db.villas);
  $$IncomesTableTableManager get incomes =>
      $$IncomesTableTableManager(_db, _db.incomes);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
}
