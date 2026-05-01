import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/enums.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    String? villaId,
    required ExpenseCategory category,
    required double amount,
    required DateTime expenseDate,
    required String paidTo,
    required PaymentMethod paymentMethod,
    String? notes,
    required DateTime createdAt,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
