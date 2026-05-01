// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'villa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VillaModelImpl _$$VillaModelImplFromJson(Map<String, dynamic> json) =>
    _$VillaModelImpl(
      id: json['id'] as String,
      villaName: json['villaName'] as String,
      villaNumber: json['villaNumber'] as String,
      location: json['location'] as String,
      tenantName: json['tenantName'] as String,
      tenantPhone: json['tenantPhone'] as String,
      monthlyRent: (json['monthlyRent'] as num).toDouble(),
      contractStartDate: DateTime.parse(json['contractStartDate'] as String),
      contractEndDate: DateTime.parse(json['contractEndDate'] as String),
      paymentDueDay: (json['paymentDueDay'] as num).toInt(),
      status: $enumDecode(_$VillaStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VillaModelImplToJson(_$VillaModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'villaName': instance.villaName,
      'villaNumber': instance.villaNumber,
      'location': instance.location,
      'tenantName': instance.tenantName,
      'tenantPhone': instance.tenantPhone,
      'monthlyRent': instance.monthlyRent,
      'contractStartDate': instance.contractStartDate.toIso8601String(),
      'contractEndDate': instance.contractEndDate.toIso8601String(),
      'paymentDueDay': instance.paymentDueDay,
      'status': _$VillaStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$VillaStatusEnumMap = {
  VillaStatus.occupied: 'occupied',
  VillaStatus.vacant: 'vacant',
  VillaStatus.maintenance: 'maintenance',
};
