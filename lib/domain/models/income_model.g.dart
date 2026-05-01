// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomeModelImpl _$$IncomeModelImplFromJson(Map<String, dynamic> json) =>
    _$IncomeModelImpl(
      id: json['id'] as String,
      villaId: json['villaId'] as String,
      incomeType: $enumDecode(_$IncomeTypeEnumMap, json['incomeType']),
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      monthCovered: DateTime.parse(json['monthCovered'] as String),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$IncomeModelImplToJson(_$IncomeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'villaId': instance.villaId,
      'incomeType': _$IncomeTypeEnumMap[instance.incomeType]!,
      'amount': instance.amount,
      'paymentDate': instance.paymentDate.toIso8601String(),
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'monthCovered': instance.monthCovered.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$IncomeTypeEnumMap = {
  IncomeType.rent: 'rent',
  IncomeType.deposit: 'deposit',
  IncomeType.maintenanceCharge: 'maintenanceCharge',
  IncomeType.penalty: 'penalty',
  IncomeType.other: 'other',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.check: 'check',
  PaymentMethod.transfer: 'transfer',
  PaymentMethod.online: 'online',
  PaymentMethod.other: 'other',
};
