// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'villa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VillaModel _$VillaModelFromJson(Map<String, dynamic> json) {
  return _VillaModel.fromJson(json);
}

/// @nodoc
mixin _$VillaModel {
  String get id => throw _privateConstructorUsedError;
  String get villaName => throw _privateConstructorUsedError;
  String get villaNumber => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get tenantName => throw _privateConstructorUsedError;
  String get tenantPhone => throw _privateConstructorUsedError;
  double get monthlyRent => throw _privateConstructorUsedError;
  DateTime get contractStartDate => throw _privateConstructorUsedError;
  DateTime get contractEndDate => throw _privateConstructorUsedError;
  int get paymentDueDay => throw _privateConstructorUsedError;
  VillaStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VillaModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VillaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VillaModelCopyWith<VillaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VillaModelCopyWith<$Res> {
  factory $VillaModelCopyWith(
          VillaModel value, $Res Function(VillaModel) then) =
      _$VillaModelCopyWithImpl<$Res, VillaModel>;
  @useResult
  $Res call(
      {String id,
      String villaName,
      String villaNumber,
      String location,
      String tenantName,
      String tenantPhone,
      double monthlyRent,
      DateTime contractStartDate,
      DateTime contractEndDate,
      int paymentDueDay,
      VillaStatus status,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$VillaModelCopyWithImpl<$Res, $Val extends VillaModel>
    implements $VillaModelCopyWith<$Res> {
  _$VillaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VillaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaName = null,
    Object? villaNumber = null,
    Object? location = null,
    Object? tenantName = null,
    Object? tenantPhone = null,
    Object? monthlyRent = null,
    Object? contractStartDate = null,
    Object? contractEndDate = null,
    Object? paymentDueDay = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaName: null == villaName
          ? _value.villaName
          : villaName // ignore: cast_nullable_to_non_nullable
              as String,
      villaNumber: null == villaNumber
          ? _value.villaNumber
          : villaNumber // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      tenantName: null == tenantName
          ? _value.tenantName
          : tenantName // ignore: cast_nullable_to_non_nullable
              as String,
      tenantPhone: null == tenantPhone
          ? _value.tenantPhone
          : tenantPhone // ignore: cast_nullable_to_non_nullable
              as String,
      monthlyRent: null == monthlyRent
          ? _value.monthlyRent
          : monthlyRent // ignore: cast_nullable_to_non_nullable
              as double,
      contractStartDate: null == contractStartDate
          ? _value.contractStartDate
          : contractStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contractEndDate: null == contractEndDate
          ? _value.contractEndDate
          : contractEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentDueDay: null == paymentDueDay
          ? _value.paymentDueDay
          : paymentDueDay // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VillaStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VillaModelImplCopyWith<$Res>
    implements $VillaModelCopyWith<$Res> {
  factory _$$VillaModelImplCopyWith(
          _$VillaModelImpl value, $Res Function(_$VillaModelImpl) then) =
      __$$VillaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String villaName,
      String villaNumber,
      String location,
      String tenantName,
      String tenantPhone,
      double monthlyRent,
      DateTime contractStartDate,
      DateTime contractEndDate,
      int paymentDueDay,
      VillaStatus status,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$VillaModelImplCopyWithImpl<$Res>
    extends _$VillaModelCopyWithImpl<$Res, _$VillaModelImpl>
    implements _$$VillaModelImplCopyWith<$Res> {
  __$$VillaModelImplCopyWithImpl(
      _$VillaModelImpl _value, $Res Function(_$VillaModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VillaModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaName = null,
    Object? villaNumber = null,
    Object? location = null,
    Object? tenantName = null,
    Object? tenantPhone = null,
    Object? monthlyRent = null,
    Object? contractStartDate = null,
    Object? contractEndDate = null,
    Object? paymentDueDay = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VillaModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaName: null == villaName
          ? _value.villaName
          : villaName // ignore: cast_nullable_to_non_nullable
              as String,
      villaNumber: null == villaNumber
          ? _value.villaNumber
          : villaNumber // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      tenantName: null == tenantName
          ? _value.tenantName
          : tenantName // ignore: cast_nullable_to_non_nullable
              as String,
      tenantPhone: null == tenantPhone
          ? _value.tenantPhone
          : tenantPhone // ignore: cast_nullable_to_non_nullable
              as String,
      monthlyRent: null == monthlyRent
          ? _value.monthlyRent
          : monthlyRent // ignore: cast_nullable_to_non_nullable
              as double,
      contractStartDate: null == contractStartDate
          ? _value.contractStartDate
          : contractStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contractEndDate: null == contractEndDate
          ? _value.contractEndDate
          : contractEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentDueDay: null == paymentDueDay
          ? _value.paymentDueDay
          : paymentDueDay // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VillaStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VillaModelImpl implements _VillaModel {
  const _$VillaModelImpl(
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

  factory _$VillaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VillaModelImplFromJson(json);

  @override
  final String id;
  @override
  final String villaName;
  @override
  final String villaNumber;
  @override
  final String location;
  @override
  final String tenantName;
  @override
  final String tenantPhone;
  @override
  final double monthlyRent;
  @override
  final DateTime contractStartDate;
  @override
  final DateTime contractEndDate;
  @override
  final int paymentDueDay;
  @override
  final VillaStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'VillaModel(id: $id, villaName: $villaName, villaNumber: $villaNumber, location: $location, tenantName: $tenantName, tenantPhone: $tenantPhone, monthlyRent: $monthlyRent, contractStartDate: $contractStartDate, contractEndDate: $contractEndDate, paymentDueDay: $paymentDueDay, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VillaModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.villaName, villaName) ||
                other.villaName == villaName) &&
            (identical(other.villaNumber, villaNumber) ||
                other.villaNumber == villaNumber) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.tenantName, tenantName) ||
                other.tenantName == tenantName) &&
            (identical(other.tenantPhone, tenantPhone) ||
                other.tenantPhone == tenantPhone) &&
            (identical(other.monthlyRent, monthlyRent) ||
                other.monthlyRent == monthlyRent) &&
            (identical(other.contractStartDate, contractStartDate) ||
                other.contractStartDate == contractStartDate) &&
            (identical(other.contractEndDate, contractEndDate) ||
                other.contractEndDate == contractEndDate) &&
            (identical(other.paymentDueDay, paymentDueDay) ||
                other.paymentDueDay == paymentDueDay) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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

  /// Create a copy of VillaModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VillaModelImplCopyWith<_$VillaModelImpl> get copyWith =>
      __$$VillaModelImplCopyWithImpl<_$VillaModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VillaModelImplToJson(
      this,
    );
  }
}

abstract class _VillaModel implements VillaModel {
  const factory _VillaModel(
      {required final String id,
      required final String villaName,
      required final String villaNumber,
      required final String location,
      required final String tenantName,
      required final String tenantPhone,
      required final double monthlyRent,
      required final DateTime contractStartDate,
      required final DateTime contractEndDate,
      required final int paymentDueDay,
      required final VillaStatus status,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$VillaModelImpl;

  factory _VillaModel.fromJson(Map<String, dynamic> json) =
      _$VillaModelImpl.fromJson;

  @override
  String get id;
  @override
  String get villaName;
  @override
  String get villaNumber;
  @override
  String get location;
  @override
  String get tenantName;
  @override
  String get tenantPhone;
  @override
  double get monthlyRent;
  @override
  DateTime get contractStartDate;
  @override
  DateTime get contractEndDate;
  @override
  int get paymentDueDay;
  @override
  VillaStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of VillaModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VillaModelImplCopyWith<_$VillaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
