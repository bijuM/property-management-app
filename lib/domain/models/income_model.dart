import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/enums.dart';

part 'income_model.freezed.dart';
part 'income_model.g.dart';

@freezed
class IncomeModel with _$IncomeModel {
  const factory IncomeModel({
    required String id,
    required String villaId,
    required IncomeType incomeType,
    required double amount,
    required DateTime paymentDate,
    required PaymentMethod paymentMethod,
    required DateTime monthCovered,
    String? notes,
    required DateTime createdAt,
  }) = _IncomeModel;

  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);
}
