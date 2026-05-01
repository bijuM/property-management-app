import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_permissions.dart';
import '../../../domain/models/income.dart';
import '../../providers/auth_provider.dart';
import '../../providers/income_provider.dart';
import 'add_edit_income_screen.dart';

class IncomeDetailScreen extends ConsumerWidget {
  final String incomeId;

  const IncomeDetailScreen({
    Key? key,
    required this.incomeId,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomeAsync = ref.watch(incomeListProvider);
    final authState = ref.watch(authProvider);
    final canManageIncome =
        authState.hasPermission(AppPermissions.manageIncome);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: const Text('Income Details'),
        elevation: 0,
      ),
      body: incomeAsync.when(
        data: (incomes) {
          final income =
              incomes.where((item) => item.id == incomeId).firstOrNull;

          if (income == null) {
            return const Center(child: Text('Income not found'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFCDEFD8)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF067647).withValues(alpha: 0.08),
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
                            color: Color(0xFFE4F8EA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.payments_rounded,
                            color: Color(0xFF12B76A),
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                income.incomeType,
                                style: const TextStyle(
                                  color: Color(0xFF060B26),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'QAR ${_moneyFormat.format(income.amount)}',
                                style: const TextStyle(
                                  color: Color(0xFF12B76A),
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
                      value: income.villaName,
                      icon: Icons.home_outlined,
                    ),
                    _DetailRow(
                      label: 'Payment Date',
                      value: _dateFormat.format(income.paymentDate),
                      icon: Icons.calendar_month_rounded,
                    ),
                    _DetailRow(
                      label: 'Payment Method',
                      value: income.paymentMethod,
                      icon: Icons.credit_card_rounded,
                    ),
                    _DetailRow(
                      label: 'Month Covered',
                      value: _monthFormat.format(income.monthCovered),
                      icon: Icons.event_available_rounded,
                    ),
                    _DetailRow(
                      label: 'Notes',
                      value: income.notes.trim().isEmpty
                          ? 'No notes'
                          : income.notes,
                      icon: Icons.notes_rounded,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              if (canManageIncome) ...[
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEditIncomeScreen(income: income),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Income'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF12B76A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (canManageIncome)
                OutlinedButton.icon(
                  onPressed: () => _confirmDelete(context, ref, income),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Delete Income'),
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
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Income income) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Income?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(incomeControllerProvider.notifier)
                  .deleteIncome(income.id);
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
          Icon(icon, color: const Color(0xFF12B76A), size: 22),
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
