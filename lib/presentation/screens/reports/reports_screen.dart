import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/app_permissions.dart';
import '../../../data/services/report_export_service.dart';
import '../../../domain/models/expense.dart';
import '../../../domain/models/income.dart';
import '../../../domain/models/report_models.dart';
import '../../../domain/models/villa_model.dart';
import '../../providers/expense_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/income_provider.dart';
import '../../providers/villa_provider.dart';
import '../common/access_denied_screen.dart';
import '../../widgets/reports/expense_report_view.dart';
import '../../widgets/reports/income_report_view.dart';
import '../../widgets/reports/monthly_summary_report.dart';
import '../../widgets/reports/pending_rent_report_view.dart';
import '../../widgets/reports/villa_wise_profit_report.dart';
import '../../widgets/reports/yearly_summary_report.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  final ReportExportService _exportService = ReportExportService();
  final NumberFormat _moneyFormat = NumberFormat('#,##0.00');
  final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  late DateTime _selectedMonth;
  late int _selectedYear;
  ReportType _selectedReportType = ReportType.monthlySummary;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
    _selectedYear = now.year;
  }

  @override
  Widget build(BuildContext context) {
    final villasAsync = ref.watch(villasProvider);
    final incomesAsync = ref.watch(incomeListProvider);
    final expenses = ref.watch(expenseProvider);
    final authState = ref.watch(authProvider);
    final canViewReports = authState.hasPermission(AppPermissions.viewReports);
    final canExportReports =
        authState.hasPermission(AppPermissions.exportReports);

    if (!canViewReports) {
      return const AccessDeniedScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: const Text('Reports'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Wrap(
              spacing: 8,
              children: [
                if (canExportReports) ...[
                  OutlinedButton.icon(
                    onPressed: _isExporting
                        ? null
                        : () => _export(
                              villasAsync.valueOrNull ?? const [],
                              incomesAsync.valueOrNull ?? const [],
                              expenses,
                              ExportFormat.pdf,
                            ),
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    label: const Text('Export PDF'),
                  ),
                  FilledButton.icon(
                    onPressed: _isExporting
                        ? null
                        : () => _export(
                              villasAsync.valueOrNull ?? const [],
                              incomesAsync.valueOrNull ?? const [],
                              expenses,
                              ExportFormat.csv,
                            ),
                    icon: const Icon(Icons.table_chart_rounded),
                    label: const Text('Export CSV'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF5549DE),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      body: villasAsync.when(
        data: (villas) => incomesAsync.when(
          data: (incomes) {
            final reportData = _buildReportData(villas, incomes, expenses);

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 116),
              children: [
                _Filters(
                  selectedMonth: _selectedMonth,
                  selectedYear: _selectedYear,
                  selectedReportType: _selectedReportType,
                  onPreviousMonth: () => _changeMonth(-1),
                  onNextMonth: () => _changeMonth(1),
                  onYearChanged: (year) {
                    if (year == null) return;
                    setState(() => _selectedYear = year);
                  },
                  onReportTypeChanged: (type) {
                    if (type == null) return;
                    setState(() => _selectedReportType = type);
                  },
                ),
                const SizedBox(height: 16),
                _ReportHeader(
                  title: _selectedReportType.label,
                  subtitle: _selectedReportType == ReportType.yearlySummary
                      ? '$_selectedYear'
                      : _monthFormat.format(_selectedMonth),
                ),
                const SizedBox(height: 14),
                _buildReportView(reportData),
              ],
            );
          },
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  _ReportData _buildReportData(
    List<VillaModel> villas,
    List<Income> incomes,
    List<Expense> expenses,
  ) {
    final monthlyIncomes = incomes
        .where((income) => _isSameMonth(income.paymentDate, _selectedMonth))
        .toList();
    final monthlyExpenses = expenses
        .where((expense) => _isSameMonth(expense.expenseDate, _selectedMonth))
        .toList();
    final occupiedVillas =
        villas.where((villa) => villa.status == VillaStatus.occupied).toList();
    final expectedRent = occupiedVillas.fold<double>(
      0,
      (sum, villa) => sum + villa.monthlyRent,
    );
    final rentIncome = monthlyIncomes
        .where((income) => income.incomeType == IncomeTypes.rent)
        .fold<double>(0, (sum, income) => sum + income.amount);
    final totalIncome =
        monthlyIncomes.fold<double>(0, (sum, income) => sum + income.amount);
    final totalExpenses =
        monthlyExpenses.fold<double>(0, (sum, expense) => sum + expense.amount);
    final pendingRent = math.max(expectedRent - rentIncome, 0).toDouble();

    final monthlySummary = MonthlySummaryReportData(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      netProfit: totalIncome - totalExpenses,
      pendingRent: pendingRent,
      rentCollectionPercentage:
          expectedRent == 0 ? 0 : (rentIncome / expectedRent) * 100,
    );

    final villaProfitItems = villas.map((villa) {
      final villaIncomes =
          monthlyIncomes.where((income) => income.villaId == villa.id).toList();
      final villaExpenses = monthlyExpenses
          .where((expense) => expense.villaId == villa.id)
          .toList();
      final villaIncome =
          villaIncomes.fold<double>(0, (sum, income) => sum + income.amount);
      final villaRentIncome = villaIncomes
          .where((income) => income.incomeType == IncomeTypes.rent)
          .fold<double>(0, (sum, income) => sum + income.amount);
      final villaExpense =
          villaExpenses.fold<double>(0, (sum, expense) => sum + expense.amount);
      final villaExpectedRent =
          villa.status == VillaStatus.occupied ? villa.monthlyRent : 0.0;

      return VillaProfitReportItem(
        villaId: villa.id,
        villaName: villa.villaName,
        tenantName:
            villa.status == VillaStatus.occupied ? villa.tenantName : 'Vacant',
        expectedRent: villaExpectedRent,
        receivedIncome: villaIncome,
        totalExpense: villaExpense,
        netProfit: villaIncome - villaExpense,
        pendingAmount:
            math.max(villaExpectedRent - villaRentIncome, 0).toDouble(),
      );
    }).toList();

    final pendingRentItems = occupiedVillas
        .map((villa) {
          final receivedRent = monthlyIncomes
              .where((income) =>
                  income.villaId == villa.id &&
                  income.incomeType == IncomeTypes.rent)
              .fold<double>(0, (sum, income) => sum + income.amount);

          return PendingRentReportItem(
            villaName: villa.villaName,
            tenantName: villa.tenantName,
            expectedRent: villa.monthlyRent,
            receivedRent: receivedRent,
            pendingRent:
                math.max(villa.monthlyRent - receivedRent, 0).toDouble(),
            dueDay: villa.paymentDueDay,
          );
        })
        .where((item) => item.pendingRent > 0)
        .toList();

    final yearlyItems = List.generate(12, (index) {
      final month = DateTime(_selectedYear, index + 1, 1);
      final income = incomes
          .where((item) => _isSameMonth(item.paymentDate, month))
          .fold<double>(0, (sum, item) => sum + item.amount);
      final expense = expenses
          .where((item) => _isSameMonth(item.expenseDate, month))
          .fold<double>(0, (sum, item) => sum + item.amount);

      return YearlySummaryReportItem(
        month: month,
        income: income,
        expense: expense,
        profit: income - expense,
      );
    });

    return _ReportData(
      monthlySummary: monthlySummary,
      villaProfitItems: villaProfitItems,
      monthlyIncomes: monthlyIncomes,
      monthlyExpenses: monthlyExpenses,
      pendingRentItems: pendingRentItems,
      yearlyItems: yearlyItems,
    );
  }

  Widget _buildReportView(_ReportData data) {
    switch (_selectedReportType) {
      case ReportType.monthlySummary:
        return MonthlySummaryReport(data: data.monthlySummary);
      case ReportType.villaWiseProfit:
        return VillaWiseProfitReport(items: data.villaProfitItems);
      case ReportType.incomeReport:
        return IncomeReportView(incomes: data.monthlyIncomes);
      case ReportType.expenseReport:
        return ExpenseReportView(expenses: data.monthlyExpenses);
      case ReportType.pendingRentReport:
        return PendingRentReportView(items: data.pendingRentItems);
      case ReportType.yearlySummary:
        return YearlySummaryReport(items: data.yearlyItems);
    }
  }

  Future<void> _export(
    List<VillaModel> villas,
    List<Income> incomes,
    List<Expense> expenses,
    ExportFormat format,
  ) async {
    setState(() => _isExporting = true);
    try {
      final data = _buildReportData(villas, incomes, expenses);
      final exportData = _buildExportData(data);
      final title =
          '${_selectedReportType.label} - ${_selectedReportType == ReportType.yearlySummary ? _selectedYear : _monthFormat.format(_selectedMonth)}';

      if (format == ExportFormat.csv) {
        await _exportService.exportCsv(
          title: title,
          headers: exportData.headers,
          rows: exportData.rows,
        );
      } else {
        await _exportService.exportPdf(
          title: title,
          summaryLines: exportData.summaryLines,
          headers: exportData.headers,
          rows: exportData.rows,
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  _ExportData _buildExportData(_ReportData data) {
    switch (_selectedReportType) {
      case ReportType.monthlySummary:
        return _ExportData(
          headers: const ['Metric', 'Value'],
          rows: [
            ['Total Income', _money(data.monthlySummary.totalIncome)],
            ['Total Expenses', _money(data.monthlySummary.totalExpenses)],
            ['Net Profit', _money(data.monthlySummary.netProfit)],
            ['Pending Rent', _money(data.monthlySummary.pendingRent)],
            [
              'Rent Collection',
              '${data.monthlySummary.rentCollectionPercentage.toStringAsFixed(1)}%',
            ],
          ],
          summaryLines: [
            'Period: ${_monthFormat.format(_selectedMonth)}',
          ],
        );
      case ReportType.villaWiseProfit:
        return _ExportData(
          headers: const [
            'Villa',
            'Expected Rent',
            'Received Income',
            'Total Expense',
            'Net Profit',
            'Pending',
          ],
          rows: data.villaProfitItems
              .map(
                (item) => [
                  item.villaName,
                  _money(item.expectedRent),
                  _money(item.receivedIncome),
                  _money(item.totalExpense),
                  _money(item.netProfit),
                  _money(item.pendingAmount),
                ],
              )
              .toList(),
          summaryLines: ['Period: ${_monthFormat.format(_selectedMonth)}'],
        );
      case ReportType.incomeReport:
        return _ExportData(
          headers: const ['Date', 'Villa', 'Type', 'Payment Method', 'Amount'],
          rows: data.monthlyIncomes
              .map(
                (income) => [
                  _dateFormat.format(income.paymentDate),
                  income.villaName,
                  income.incomeType,
                  income.paymentMethod,
                  _money(income.amount),
                ],
              )
              .toList(),
          summaryLines: ['Period: ${_monthFormat.format(_selectedMonth)}'],
        );
      case ReportType.expenseReport:
        return _ExportData(
          headers: const [
            'Date',
            'Villa / General',
            'Category',
            'Paid To',
            'Amount'
          ],
          rows: data.monthlyExpenses
              .map(
                (expense) => [
                  _dateFormat.format(expense.expenseDate),
                  expense.villaName,
                  expense.category,
                  expense.paidTo,
                  _money(expense.amount),
                ],
              )
              .toList(),
          summaryLines: ['Period: ${_monthFormat.format(_selectedMonth)}'],
        );
      case ReportType.pendingRentReport:
        return _ExportData(
          headers: const [
            'Villa',
            'Tenant',
            'Expected Rent',
            'Received Rent',
            'Pending Rent',
            'Due Day',
          ],
          rows: data.pendingRentItems
              .map(
                (item) => [
                  item.villaName,
                  item.tenantName,
                  _money(item.expectedRent),
                  _money(item.receivedRent),
                  _money(item.pendingRent),
                  item.dueDay.toString(),
                ],
              )
              .toList(),
          summaryLines: ['Period: ${_monthFormat.format(_selectedMonth)}'],
        );
      case ReportType.yearlySummary:
        return _ExportData(
          headers: const ['Month', 'Income', 'Expense', 'Profit'],
          rows: data.yearlyItems
              .map(
                (item) => [
                  DateFormat('MMMM').format(item.month),
                  _money(item.income),
                  _money(item.expense),
                  _money(item.profit),
                ],
              )
              .toList(),
          summaryLines: ['Year: $_selectedYear'],
        );
    }
  }

  void _changeMonth(int offset) {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + offset,
        1,
      );
      _selectedYear = _selectedMonth.year;
    });
  }

  bool _isSameMonth(DateTime date, DateTime month) {
    return date.year == month.year && date.month == month.month;
  }

  String _money(double value) => 'QAR ${_moneyFormat.format(value)}';
}

enum ExportFormat { pdf, csv }

class _Filters extends StatelessWidget {
  final DateTime selectedMonth;
  final int selectedYear;
  final ReportType selectedReportType;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<ReportType?> onReportTypeChanged;

  const _Filters({
    required this.selectedMonth,
    required this.selectedYear,
    required this.selectedReportType,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onYearChanged,
    required this.onReportTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final years = List.generate(8, (index) => now.year - 5 + index);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 820;
          final monthControl = Row(
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat('MMMM yyyy').format(selectedMonth),
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          );
          final yearControl = DropdownButtonFormField<int>(
            initialValue: selectedYear,
            decoration: _inputDecoration('Year'),
            items: years
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  ),
                )
                .toList(),
            onChanged: onYearChanged,
          );
          final typeControl = DropdownButtonFormField<ReportType>(
            initialValue: selectedReportType,
            decoration: _inputDecoration('Report Type'),
            items: ReportType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.label),
                  ),
                )
                .toList(),
            onChanged: onReportTypeChanged,
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(flex: 2, child: monthControl),
                const SizedBox(width: 12),
                Expanded(child: yearControl),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: typeControl),
              ],
            );
          }

          return Column(
            children: [
              monthControl,
              const SizedBox(height: 12),
              yearControl,
              const SizedBox(height: 12),
              typeControl,
            ],
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFFCFCFD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
      ),
    );
  }
}

class _ReportHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ReportHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF060B26),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF646B7A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReportData {
  final MonthlySummaryReportData monthlySummary;
  final List<VillaProfitReportItem> villaProfitItems;
  final List<Income> monthlyIncomes;
  final List<Expense> monthlyExpenses;
  final List<PendingRentReportItem> pendingRentItems;
  final List<YearlySummaryReportItem> yearlyItems;

  const _ReportData({
    required this.monthlySummary,
    required this.villaProfitItems,
    required this.monthlyIncomes,
    required this.monthlyExpenses,
    required this.pendingRentItems,
    required this.yearlyItems,
  });
}

class _ExportData {
  final List<String> headers;
  final List<List<String>> rows;
  final List<String> summaryLines;

  const _ExportData({
    required this.headers,
    required this.rows,
    required this.summaryLines,
  });
}
