enum ReportType {
  monthlySummary,
  villaWiseProfit,
  incomeReport,
  expenseReport,
  pendingRentReport,
  yearlySummary,
}

extension ReportTypeLabel on ReportType {
  String get label {
    switch (this) {
      case ReportType.monthlySummary:
        return 'Monthly Summary';
      case ReportType.villaWiseProfit:
        return 'Villa-wise Profit';
      case ReportType.incomeReport:
        return 'Income Report';
      case ReportType.expenseReport:
        return 'Expense Report';
      case ReportType.pendingRentReport:
        return 'Pending Rent Report';
      case ReportType.yearlySummary:
        return 'Yearly Summary';
    }
  }
}

class MonthlySummaryReportData {
  final double totalIncome;
  final double totalExpenses;
  final double netProfit;
  final double pendingRent;
  final double rentCollectionPercentage;

  const MonthlySummaryReportData({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
    required this.pendingRent,
    required this.rentCollectionPercentage,
  });
}

class VillaProfitReportItem {
  final String villaId;
  final String villaName;
  final String tenantName;
  final double expectedRent;
  final double receivedIncome;
  final double totalExpense;
  final double netProfit;
  final double pendingAmount;

  const VillaProfitReportItem({
    required this.villaId,
    required this.villaName,
    required this.tenantName,
    required this.expectedRent,
    required this.receivedIncome,
    required this.totalExpense,
    required this.netProfit,
    required this.pendingAmount,
  });
}

class PendingRentReportItem {
  final String villaName;
  final String tenantName;
  final double expectedRent;
  final double receivedRent;
  final double pendingRent;
  final int dueDay;

  const PendingRentReportItem({
    required this.villaName,
    required this.tenantName,
    required this.expectedRent,
    required this.receivedRent,
    required this.pendingRent,
    required this.dueDay,
  });
}

class YearlySummaryReportItem {
  final DateTime month;
  final double income;
  final double expense;
  final double profit;

  const YearlySummaryReportItem({
    required this.month,
    required this.income,
    required this.expense,
    required this.profit,
  });
}
