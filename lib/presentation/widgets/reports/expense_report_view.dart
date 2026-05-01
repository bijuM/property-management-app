import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/expense.dart';

class ExpenseReportView extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseReportView({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const _EmptyReport(message: 'No expense records found.');
    }

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
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Villa / General')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Paid To')),
            DataColumn(label: Text('Amount')),
          ],
          rows: expenses.map((expense) {
            return DataRow(
              cells: [
                DataCell(Text(_dateFormat.format(expense.expenseDate))),
                DataCell(Text(expense.villaName)),
                DataCell(Text(expense.category)),
                DataCell(Text(expense.paidTo.trim().isEmpty
                    ? 'Not specified'
                    : expense.paidTo)),
                DataCell(
                  Text(
                    'QAR ${_moneyFormat.format(expense.amount)}',
                    style: const TextStyle(
                      color: Color(0xFFF04438),
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

class _EmptyReport extends StatelessWidget {
  final String message;

  const _EmptyReport({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF646B7A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
