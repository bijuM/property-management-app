// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) {
  return _ExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseModel {
  String get id => throw _privateConstructorUsedError;
  String? get villaId => throw _privateConstructorUsedError;
  ExpenseCategory get category => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get expenseDate => throw _privateConstructorUsedError;
  String get paidTo => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ExpenseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res, ExpenseModel>;
  @useResult
  $Res call(
      {String id,
      String? villaId,
      ExpenseCategory category,
      double amount,
      DateTime expenseDate,
      String paidTo,
      PaymentMethod paymentMethod,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res, $Val extends ExpenseModel>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaId = freezed,
    Object? category = null,
    Object? amount = null,
    Object? expenseDate = null,
    Object? paidTo = null,
    Object? paymentMethod = null,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaId: freezed == villaId
          ? _value.villaId
          : villaId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ExpenseCategory,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      expenseDate: null == expenseDate
          ? _value.expenseDate
          : expenseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidTo: null == paidTo
          ? _value.paidTo
          : paidTo // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
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
abstract class _$$ExpenseModelImplCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$ExpenseModelImplCopyWith(
          _$ExpenseModelImpl value, $Res Function(_$ExpenseModelImpl) then) =
      __$$ExpenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? villaId,
      ExpenseCategory category,
      double amount,
      DateTime expenseDate,
      String paidTo,
      PaymentMethod paymentMethod,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$ExpenseModelImplCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res, _$ExpenseModelImpl>
    implements _$$ExpenseModelImplCopyWith<$Res> {
  __$$ExpenseModelImplCopyWithImpl(
      _$ExpenseModelImpl _value, $Res Function(_$ExpenseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? villaId = freezed,
    Object? category = null,
    Object? amount = null,
    Object? expenseDate = null,
    Object? paidTo = null,
    Object? paymentMethod = null,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$ExpenseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      villaId: freezed == villaId
          ? _value.villaId
          : villaId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ExpenseCategory,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      expenseDate: null == expenseDate
          ? _value.expenseDate
          : expenseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidTo: null == paidTo
          ? _value.paidTo
          : paidTo // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
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
class _$ExpenseModelImpl implements _ExpenseModel {
  const _$ExpenseModelImpl(
      {required this.id,
      this.villaId,
      required this.category,
      required this.amount,
      required this.expenseDate,
      required this.paidTo,
      required this.paymentMethod,
      this.notes,
      required this.createdAt});

  factory _$ExpenseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? villaId;
  @override
  final ExpenseCategory category;
  @override
  final double amount;
  @override
  final DateTime expenseDate;
  @override
  final String paidTo;
  @override
  final PaymentMethod paymentMethod;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ExpenseModel(id: $id, villaId: $villaId, category: $category, amount: $amount, expenseDate: $expenseDate, paidTo: $paidTo, paymentMethod: $paymentMethod, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.villaId, villaId) || other.villaId == villaId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.expenseDate, expenseDate) ||
                other.expenseDate == expenseDate) &&
            (identical(other.paidTo, paidTo) || other.paidTo == paidTo) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, villaId, category, amount,
      expenseDate, paidTo, paymentMethod, notes, createdAt);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      __$$ExpenseModelImplCopyWithImpl<_$ExpenseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseModelImplToJson(
      this,
    );
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  const factory _ExpenseModel(
      {required final String id,
      final String? villaId,
      required final ExpenseCategory category,
      required final double amount,
      required final DateTime expenseDate,
      required final String paidTo,
      required final PaymentMethod paymentMethod,
      final String? notes,
      required final DateTime createdAt}) = _$ExpenseModelImpl;

  factory _ExpenseModel.fromJson(Map<String, dynamic> json) =
      _$ExpenseModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get villaId;
  @override
  ExpenseCategory get category;
  @override
  double get amount;
  @override
  DateTime get expenseDate;
  @override
  String get paidTo;
  @override
  PaymentMethod get paymentMethod;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
