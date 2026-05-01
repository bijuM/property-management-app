import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_permissions.dart';
import '../../domain/models/expense.dart';
import '../providers/auth_provider.dart';
import '../providers/expense_provider.dart';
import 'add_edit_expense_screen.dart';

class ExpenseDetailScreen extends ConsumerWidget {
  final String expenseId;

  const ExpenseDetailScreen({
    Key? key,
    required this.expenseId,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseProvider);
    final expense = expenses.where((item) => item.id == expenseId).firstOrNull;
    final authState = ref.watch(authProvider);
    final canManageExpenses =
        authState.hasPermission(AppPermissions.manageExpenses);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: const Text('Expense Details'),
        elevation: 0,
      ),
      body: expense == null
          ? const Center(child: Text('Expense not found'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFF1D6CF)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB42318).withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 62,
                            width: 62,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFE6E0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.receipt_long_rounded,
                              color: Color(0xFFF04438),
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expense.category,
                                  style: const TextStyle(
                                    color: Color(0xFF060B26),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'QAR ${_moneyFormat.format(expense.amount)}',
                                  style: const TextStyle(
                                    color: Color(0xFFF04438),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _DetailRow(
                        label: 'Villa',
                        value: expense.villaName.trim().isEmpty
                            ? 'General Expense'
                            : expense.villaName,
                        icon: Icons.home_outlined,
                      ),
                      _DetailRow(
                        label: 'Date',
                        value: _dateFormat.format(expense.expenseDate),
                        icon: Icons.calendar_month_rounded,
                      ),
                      _DetailRow(
                        label: 'Paid To',
                        value: expense.paidTo.trim().isEmpty
                            ? 'Not specified'
                            : expense.paidTo,
                        icon: Icons.person_outline_rounded,
                      ),
                      _DetailRow(
                        label: 'Payment Method',
                        value: expense.paymentMethod,
                        icon: Icons.payments_outlined,
                      ),
                      _DetailRow(
                        label: 'Notes',
                        value: expense.notes.trim().isEmpty
                            ? 'No notes'
                            : expense.notes,
                        icon: Icons.notes_rounded,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                if (canManageExpenses) ...[
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditExpenseScreen(expense: expense),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit Expense'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFF04438),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (canManageExpenses)
                  OutlinedButton.icon(
                    onPressed: () => _confirmDelete(context, ref, expense),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Delete Expense'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF04438),
                      side: const BorderSide(color: Color(0xFFF1B8AE)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Expense expense) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Expense?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(expenseProvider.notifier)
                  .deleteExpense(expense.id);
              if (!context.mounted) return;
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFF04438)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isLast;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFF0F1F4)),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFF04438), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF646B7A),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF060B26),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
