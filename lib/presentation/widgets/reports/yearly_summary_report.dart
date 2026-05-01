import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/report_models.dart';

class YearlySummaryReport extends StatelessWidget {
  final List<YearlySummaryReportItem> items;

  const YearlySummaryReport({
    Key? key,
    required this.items,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');
  static final DateFormat _monthFormat = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Month')),
            DataColumn(label: Text('Income')),
            DataColumn(label: Text('Expense')),
            DataColumn(label: Text('Profit')),
          ],
          rows: items.map((item) {
            final profitColor = item.profit >= 0
                ? const Color(0xFF2563EB)
                : const Color(0xFFF04438);

            return DataRow(
              cells: [
                DataCell(Text(_monthFormat.format(item.month))),
                DataCell(
                  Text(
                    'QAR ${_moneyFormat.format(item.income)}',
                    style: const TextStyle(
                      color: Color(0xFF12B76A),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    'QAR ${_moneyFormat.format(item.expense)}',
                    style: const TextStyle(
                      color: Color(0xFFF04438),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    'QAR ${_moneyFormat.format(item.profit)}',
                    style: TextStyle(
                      color: profitColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
