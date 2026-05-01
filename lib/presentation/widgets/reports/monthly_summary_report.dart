import 'package:flutter/material.dart';

import '../../../domain/models/report_models.dart';
import 'report_summary_card.dart';

class MonthlySummaryReport extends StatelessWidget {
  final MonthlySummaryReportData data;

  const MonthlySummaryReport({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ResponsiveSummaryGrid(
      children: [
        ReportSummaryCard(
          title: 'Total Income',
          value: data.totalIncome,
          color: const Color(0xFF12B76A),
          icon: Icons.trending_up_rounded,
        ),
        ReportSummaryCard(
          title: 'Total Expenses',
          value: data.totalExpenses,
          color: const Color(0xFFF04438),
          icon: Icons.trending_down_rounded,
        ),
        ReportSummaryCard(
          title: 'Net Profit',
          value: data.netProfit,
          color: const Color(0xFF2563EB),
          icon: Icons.account_balance_wallet_outlined,
        ),
        ReportSummaryCard(
          title: 'Pending Rent',
          value: data.pendingRent,
          color: const Color(0xFFF59E0B),
          icon: Icons.schedule_rounded,
        ),
        ReportSummaryCard(
          title: 'Rent Collection',
          value: data.rentCollectionPercentage,
          color: const Color(0xFF5549DE),
          icon: Icons.pie_chart_rounded,
          isPercentage: true,
        ),
      ],
    );
  }
}

class _ResponsiveSummaryGrid extends StatelessWidget {
  final List<Widget> children;

  const _ResponsiveSummaryGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 700
                ? 2
                : 1;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 1 ? 3.2 : 2.4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: children,
        );
      },
    );
  }
}
