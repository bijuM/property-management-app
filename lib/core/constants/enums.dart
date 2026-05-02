enum VillaStatus {
  occupied,
  vacant,
}

enum IncomeType {
  rent,
  deposit,
  maintenanceCharge,
  penalty,
  other,
}

enum ExpenseCategory {
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
}

enum PaymentMethod {
  cash,
  check,
  transfer,
  online,
  other,
}

extension VillaStatusExt on VillaStatus {
  String get displayName {
    switch (this) {
      case VillaStatus.occupied:
        return 'Occupied';
      case VillaStatus.vacant:
        return 'Vacant';
    }
  }
}

extension IncomeTypeExt on IncomeType {
  String get displayName {
    switch (this) {
      case IncomeType.rent:
        return 'Rent';
      case IncomeType.deposit:
        return 'Deposit';
      case IncomeType.maintenanceCharge:
        return 'Maintenance Charge';
      case IncomeType.penalty:
        return 'Penalty';
      case IncomeType.other:
        return 'Other';
    }
  }
}

extension ExpenseCategoryExt on ExpenseCategory {
  String get displayName {
    switch (this) {
      case ExpenseCategory.maintenance:
        return 'Maintenance';
      case ExpenseCategory.repair:
        return 'Repair';
      case ExpenseCategory.electricity:
        return 'Electricity';
      case ExpenseCategory.water:
        return 'Water';
      case ExpenseCategory.cleaning:
        return 'Cleaning';
      case ExpenseCategory.commission:
        return 'Commission';
      case ExpenseCategory.insurance:
        return 'Insurance';
      case ExpenseCategory.governmentFee:
        return 'Government Fee';
      case ExpenseCategory.loan:
        return 'Loan';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

extension PaymentMethodExt on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.check:
        return 'Check';
      case PaymentMethod.transfer:
        return 'Transfer';
      case PaymentMethod.online:
        return 'Online';
      case PaymentMethod.other:
        return 'Other';
    }
  }
}
