class Income {
  final String id;
  final String villaId;
  final String villaName;
  final String incomeType;
  final double amount;
  final DateTime paymentDate;
  final String paymentMethod;
  final DateTime monthCovered;
  final String notes;

  const Income({
    required this.id,
    required this.villaId,
    required this.villaName,
    required this.incomeType,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.monthCovered,
    required this.notes,
  });

  Income copyWith({
    String? id,
    String? villaId,
    String? villaName,
    String? incomeType,
    double? amount,
    DateTime? paymentDate,
    String? paymentMethod,
    DateTime? monthCovered,
    String? notes,
  }) {
    return Income(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      villaName: villaName ?? this.villaName,
      incomeType: incomeType ?? this.incomeType,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      monthCovered: monthCovered ?? this.monthCovered,
      notes: notes ?? this.notes,
    );
  }
}

class IncomeTypes {
  IncomeTypes._();

  static const rent = 'Rent';
  static const deposit = 'Deposit';
  static const maintenanceCharge = 'Maintenance Charge';
  static const penalty = 'Penalty';
  static const other = 'Other';

  static const values = [
    rent,
    deposit,
    maintenanceCharge,
    penalty,
    other,
  ];
}

class IncomePaymentMethods {
  IncomePaymentMethods._();

  static const cash = 'Cash';
  static const bankTransfer = 'Bank Transfer';
  static const card = 'Card';
  static const cheque = 'Cheque';
  static const other = 'Other';

  static const values = [
    cash,
    bankTransfer,
    card,
    cheque,
    other,
  ];
}
