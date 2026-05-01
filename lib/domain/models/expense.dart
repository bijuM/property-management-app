class Expense {
  final String id;
  final String? villaId;
  final String villaName;
  final String category;
  final double amount;
  final DateTime expenseDate;
  final String paidTo;
  final String paymentMethod;
  final String notes;

  const Expense({
    required this.id,
    required this.villaId,
    required this.villaName,
    required this.category,
    required this.amount,
    required this.expenseDate,
    required this.paidTo,
    required this.paymentMethod,
    required this.notes,
  });

  Expense copyWith({
    String? id,
    String? villaId,
    bool clearVillaId = false,
    String? villaName,
    String? category,
    double? amount,
    DateTime? expenseDate,
    String? paidTo,
    String? paymentMethod,
    String? notes,
  }) {
    return Expense(
      id: id ?? this.id,
      villaId: clearVillaId ? null : villaId ?? this.villaId,
      villaName: villaName ?? this.villaName,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      expenseDate: expenseDate ?? this.expenseDate,
      paidTo: paidTo ?? this.paidTo,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
    );
  }
}

class ExpenseCategories {
  ExpenseCategories._();

  static const maintenance = 'Maintenance';
  static const repair = 'Repair';
  static const electricity = 'Electricity';
  static const water = 'Water';
  static const cleaning = 'Cleaning';
  static const commission = 'Commission';
  static const insurance = 'Insurance';
  static const governmentFee = 'Government Fee';
  static const loan = 'Loan';
  static const other = 'Other';

  static const values = [
    maintenance,
    repair,
    electricity,
    water,
    cleaning,
    commission,
    insurance,
    governmentFee,
    loan,
    other,
  ];
}

class ExpensePaymentMethods {
  ExpensePaymentMethods._();

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
