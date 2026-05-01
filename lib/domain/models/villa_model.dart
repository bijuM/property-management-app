import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/enums.dart';

part 'villa_model.freezed.dart';
part 'villa_model.g.dart';

@freezed
class VillaModel with _$VillaModel {
  const factory VillaModel({
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
    required VillaStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VillaModel;

  factory VillaModel.fromJson(Map<String, dynamic> json) =>
      _$VillaModelFromJson(json);
}
