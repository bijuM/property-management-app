// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) {
  return _IncomeModel.fromJson(json);
}

/// @nodoc
mixin _$IncomeModel {
  String get id => throw _privateConstructorUsedError;
  String get villaId => throw _privateConstructorUsedError;
  IncomeType get incomeType => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get paymentDate => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  DateTime get monthCovered => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this IncomeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncomeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncomeModelCopyWith<IncomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeModelCopyWith<$Res> {
  factory $IncomeModelCopyWith(
          IncomeModel value, $Res Function(IncomeModel) then) =
      _$IncomeModelCopyWithImpl<$Res, IncomeModel>;
  @useResult
  $Res call(
      {String id,
      String villaId,
      IncomeType incomeType,
      double amount,
      DateTime paymentDate,
      PaymentMethod paymentMethod,
      DateTime monthCovered,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$IncomeModelCopyWithImpl<$Res, $Val extends IncomeModel>
    implements $IncomeModelCopyWith<$Res> {
  _$IncomeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncomeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaId = null,
    Object? incomeType = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? monthCovered = null,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaId: null == villaId
          ? _value.villaId
          : villaId // ignore: cast_nullable_to_non_nullable
              as String,
      incomeType: null == incomeType
          ? _value.incomeType
          : incomeType // ignore: cast_nullable_to_non_nullable
              as IncomeType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      monthCovered: null == monthCovered
          ? _value.monthCovered
          : monthCovered // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncomeModelImplCopyWith<$Res>
    implements $IncomeModelCopyWith<$Res> {
  factory _$$IncomeModelImplCopyWith(
          _$IncomeModelImpl value, $Res Function(_$IncomeModelImpl) then) =
      __$$IncomeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String villaId,
      IncomeType incomeType,
      double amount,
      DateTime paymentDate,
      PaymentMethod paymentMethod,
      DateTime monthCovered,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$IncomeModelImplCopyWithImpl<$Res>
    extends _$IncomeModelCopyWithImpl<$Res, _$IncomeModelImpl>
    implements _$$IncomeModelImplCopyWith<$Res> {
  __$$IncomeModelImplCopyWithImpl(
      _$IncomeModelImpl _value, $Res Function(_$IncomeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IncomeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaId = null,
    Object? incomeType = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? monthCovered = null,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$IncomeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaId: null == villaId
          ? _value.villaId
          : villaId // ignore: cast_nullable_to_non_nullable
              as String,
      incomeType: null == incomeType
          ? _value.incomeType
          : incomeType // ignore: cast_nullable_to_non_nullable
              as IncomeType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      monthCovered: null == monthCovered
          ? _value.monthCovered
          : monthCovered // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncomeModelImpl implements _IncomeModel {
  const _$IncomeModelImpl(
      {required this.id,
      required this.villaId,
      required this.incomeType,
      required this.amount,
      required this.paymentDate,
      required this.paymentMethod,
      required this.monthCovered,
      this.notes,
      required this.createdAt});

  factory _$IncomeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncomeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String villaId;
  @override
  final IncomeType incomeType;
  @override
  final double amount;
  @override
  final DateTime paymentDate;
  @override
  final PaymentMethod paymentMethod;
  @override
  final DateTime monthCovered;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'IncomeModel(id: $id, villaId: $villaId, incomeType: $incomeType, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, monthCovered: $monthCovered, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.villaId, villaId) || other.villaId == villaId) &&
            (identical(other.incomeType, incomeType) ||
                other.incomeType == incomeType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.monthCovered, monthCovered) ||
                other.monthCovered == monthCovered) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, villaId, incomeType, amount,
      paymentDate, paymentMethod, monthCovered, notes, createdAt);

  /// Create a copy of IncomeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeModelImplCopyWith<_$IncomeModelImpl> get copyWith =>
      __$$IncomeModelImplCopyWithImpl<_$IncomeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncomeModelImplToJson(
      this,
    );
  }
}

abstract class _IncomeModel implements IncomeModel {
  const factory _IncomeModel(
      {required final String id,
      required final String villaId,
      required final IncomeType incomeType,
      required final double amount,
      required final DateTime paymentDate,
      required final PaymentMethod paymentMethod,
      required final DateTime monthCovered,
      final String? notes,
      required final DateTime createdAt}) = _$IncomeModelImpl;

  factory _IncomeModel.fromJson(Map<String, dynamic> json) =
      _$IncomeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get villaId;
  @override
  IncomeType get incomeType;
  @override
  double get amount;
  @override
  DateTime get paymentDate;
  @override
  PaymentMethod get paymentMethod;
  @override
  DateTime get monthCovered;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of IncomeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncomeModelImplCopyWith<_$IncomeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
