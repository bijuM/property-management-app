import '../../domain/models/expense.dart';
import '../../domain/models/income.dart';
import '../../domain/models/villa_model.dart';

class ProfitCalculationService {
  const ProfitCalculationService();

  MonthlyProfitSummary calculateMonthlySummary({
    required List<VillaModel> villas,
    required List<Income> incomes,
    required List<Expense> expenses,
    required DateTime month,
  }) {
    final monthlyCashIncomes = incomes
        .where((income) => _isSameMonth(income.paymentDate, month))
        .toList();
    final monthlyRentIncomes = incomes
        .where((income) =>
            _isRentIncome(income) && _isSameMonth(income.monthCovered, month))
        .toList();
    final monthlyExpenses = expenses
        .where((expense) => _isSameMonth(expense.expenseDate, month))
        .toList();

    final occupiedVillas = villas.where(_isOccupiedVilla).toList();
    final occupiedVillaIds = occupiedVillas.map((villa) => villa.id).toSet();

    final actualIncome = _sumIncome(monthlyCashIncomes);
    final rentReceived = _sumIncome(
      monthlyRentIncomes.where(
        (income) => occupiedVillaIds.contains(income.villaId),
      ),
    );
    final otherIncome = _sumIncome(
      monthlyCashIncomes.where((income) => !_isRentIncome(income)),
    );
    final expensesPaid = _sumExpense(monthlyExpenses);
    final expectedRent = calculateExpectedRent(villas);
    final pendingRent = calculatePendingRent(
      expectedRent: expectedRent,
      rentReceived: rentReceived,
    );
    final vacancyLoss = calculateVacancyLoss(villas);

    return MonthlyProfitSummary(
      month: DateTime(month.year, month.month, 1),
      actualIncome: actualIncome,
      rentReceived: rentReceived,
      otherIncome: otherIncome,
      expensesPaid: expensesPaid,
      expectedRent: expectedRent,
      pendingRent: pendingRent,
      overpaidAmount: _calculateOverpaidAmount(
        expectedRent: expectedRent,
        rentReceived: rentReceived,
      ),
      actualNetProfit: actualIncome - expensesPaid,
      expectedNetProfit: expectedRent + otherIncome - expensesPaid,
      vacancyLoss: vacancyLoss,
      rentCollectionPercentage:
          expectedRent == 0 ? 0 : (rentReceived / expectedRent) * 100,
    );
  }

  List<VillaProfitCalculation> calculateVillaProfit({
    required List<VillaModel> villas,
    required List<Income> incomes,
    required List<Expense> expenses,
    required DateTime month,
  }) {
    final monthlyCashIncomes = incomes
        .where((income) => _isSameMonth(income.paymentDate, month))
        .toList();
    final monthlyRentIncomes = incomes
        .where((income) =>
            _isRentIncome(income) && _isSameMonth(income.monthCovered, month))
        .toList();
    final monthlyExpenses = expenses
        .where((expense) => _isSameMonth(expense.expenseDate, month))
        .toList();

    return villas.map((villa) {
      final isOccupied = _isOccupiedVilla(villa);
      final isVacant = _isVacantVilla(villa);
      final rentReceived = isOccupied
          ? _sumIncome(
              monthlyRentIncomes.where((income) => income.villaId == villa.id),
            )
          : 0.0;
      final otherVillaIncome = _sumIncome(
        monthlyCashIncomes.where(
          (income) => income.villaId == villa.id && !_isRentIncome(income),
        ),
      );
      final villaExpenses = _sumExpense(
        monthlyExpenses.where((expense) => expense.villaId == villa.id),
      );
      final expectedRent = isOccupied ? villa.monthlyRent : 0.0;
      final pendingRent = calculatePendingRent(
        expectedRent: expectedRent,
        rentReceived: rentReceived,
      );
      final overpaidAmount = _calculateOverpaidAmount(
        expectedRent: expectedRent,
        rentReceived: rentReceived,
      );
      final actualProfit = rentReceived + otherVillaIncome - villaExpenses;
      final expectedProfit = isOccupied
          ? expectedRent + otherVillaIncome - villaExpenses
          : actualProfit;

      return VillaProfitCalculation(
        villaId: villa.id,
        villaName: villa.villaName,
        tenantName: isOccupied ? villa.tenantName : 'Vacant',
        isOccupied: isOccupied,
        isVacant: isVacant,
        expectedRent: expectedRent,
        rentReceived: rentReceived,
        otherIncome: otherVillaIncome,
        expensesPaid: villaExpenses,
        pendingRent: pendingRent,
        overpaidAmount: overpaidAmount,
        vacancyLoss: isVacant ? villa.monthlyRent : 0.0,
        actualProfit: actualProfit,
        expectedProfit: expectedProfit,
        dueDay: villa.paymentDueDay,
      );
    }).toList();
  }

  List<YearlyProfitSummaryItem> calculateYearlySummary({
    required List<VillaModel> villas,
    required List<Income> incomes,
    required List<Expense> expenses,
    required int year,
  }) {
    return List.generate(12, (index) {
      final month = DateTime(year, index + 1, 1);
      final summary = calculateMonthlySummary(
        villas: villas,
        incomes: incomes,
        expenses: expenses,
        month: month,
      );

      return YearlyProfitSummaryItem(
        month: month,
        actualIncome: summary.actualIncome,
        expensesPaid: summary.expensesPaid,
        actualNetProfit: summary.actualNetProfit,
        expectedRent: summary.expectedRent,
        pendingRent: summary.pendingRent,
        expectedNetProfit: summary.expectedNetProfit,
      );
    });
  }

  List<PendingRentCalculation> calculatePendingRentItems({
    required List<VillaModel> villas,
    required List<Income> incomes,
    required DateTime month,
  }) {
    return calculateVillaProfit(
      villas: villas,
      incomes: incomes,
      expenses: const [],
      month: month,
    )
        .where((item) => item.isOccupied && item.pendingRent > 0)
        .map(
          (item) => PendingRentCalculation(
            villaId: item.villaId,
            villaName: item.villaName,
            tenantName: item.tenantName,
            expectedRent: item.expectedRent,
            rentReceived: item.rentReceived,
            pendingRent: item.pendingRent,
            overpaidAmount: item.overpaidAmount,
            dueDay: item.dueDay,
          ),
        )
        .toList();
  }

  double calculateExpectedRent(List<VillaModel> villas) {
    return _sumMonthlyRent(villas.where(_isOccupiedVilla));
  }

  double calculateVacancyLoss(List<VillaModel> villas) {
    return _sumMonthlyRent(villas.where(_isVacantVilla));
  }

  double calculatePendingRent({
    required double expectedRent,
    required double rentReceived,
  }) {
    final pendingRent = expectedRent - rentReceived;
    return pendingRent < 0 ? 0 : pendingRent;
  }

  bool _isOccupiedVilla(VillaModel villa) {
    return villa.status.name.toLowerCase() == 'occupied';
  }

  bool _isVacantVilla(VillaModel villa) {
    return villa.status.name.toLowerCase() == 'vacant';
  }

  bool _isRentIncome(Income income) {
    return income.incomeType.toLowerCase() == IncomeTypes.rent.toLowerCase();
  }

  bool _isSameMonth(DateTime date, DateTime month) {
    return date.year == month.year && date.month == month.month;
  }

  double _calculateOverpaidAmount({
    required double expectedRent,
    required double rentReceived,
  }) {
    final overpaidAmount = rentReceived - expectedRent;
    return overpaidAmount > 0 ? overpaidAmount : 0;
  }

  double _sumIncome(Iterable<Income> incomes) {
    return incomes.fold<double>(0, (sum, income) => sum + income.amount);
  }

  double _sumExpense(Iterable<Expense> expenses) {
    return expenses.fold<double>(0, (sum, expense) => sum + expense.amount);
  }

  double _sumMonthlyRent(Iterable<VillaModel> villas) {
    return villas.fold<double>(0, (sum, villa) => sum + villa.monthlyRent);
  }
}

class MonthlyProfitSummary {
  final DateTime month;
  final double actualIncome;
  final double rentReceived;
  final double otherIncome;
  final double expensesPaid;
  final double expectedRent;
  final double pendingRent;
  final double overpaidAmount;
  final double actualNetProfit;
  final double expectedNetProfit;
  final double vacancyLoss;
  final double rentCollectionPercentage;

  const MonthlyProfitSummary({
    required this.month,
    required this.actualIncome,
    required this.rentReceived,
    required this.otherIncome,
    required this.expensesPaid,
    required this.expectedRent,
    required this.pendingRent,
    required this.overpaidAmount,
    required this.actualNetProfit,
    required this.expectedNetProfit,
    required this.vacancyLoss,
    required this.rentCollectionPercentage,
  });
}

class VillaProfitCalculation {
  final String villaId;
  final String villaName;
  final String tenantName;
  final bool isOccupied;
  final bool isVacant;
  final double expectedRent;
  final double rentReceived;
  final double otherIncome;
  final double expensesPaid;
  final double pendingRent;
  final double overpaidAmount;
  final double vacancyLoss;
  final double actualProfit;
  final double expectedProfit;
  final int dueDay;

  const VillaProfitCalculation({
    required this.villaId,
    required this.villaName,
    required this.tenantName,
    required this.isOccupied,
    required this.isVacant,
    required this.expectedRent,
    required this.rentReceived,
    required this.otherIncome,
    required this.expensesPaid,
    required this.pendingRent,
    required this.overpaidAmount,
    required this.vacancyLoss,
    required this.actualProfit,
    required this.expectedProfit,
    required this.dueDay,
  });
}

class PendingRentCalculation {
  final String villaId;
  final String villaName;
  final String tenantName;
  final double expectedRent;
  final double rentReceived;
  final double pendingRent;
  final double overpaidAmount;
  final int dueDay;

  const PendingRentCalculation({
    required this.villaId,
    required this.villaName,
    required this.tenantName,
    required this.expectedRent,
    required this.rentReceived,
    required this.pendingRent,
    required this.overpaidAmount,
    required this.dueDay,
  });
}

class YearlyProfitSummaryItem {
  final DateTime month;
  final double actualIncome;
  final double expensesPaid;
  final double actualNetProfit;
  final double expectedRent;
  final double pendingRent;
  final double expectedNetProfit;

  const YearlyProfitSummaryItem({
    required this.month,
    required this.actualIncome,
    required this.expensesPaid,
    required this.actualNetProfit,
    required this.expectedRent,
    required this.pendingRent,
    required this.expectedNetProfit,
  });
}
