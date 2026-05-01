import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_permissions.dart';
import '../../../domain/models/income.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/income_provider.dart';
import '../../widgets/income_card.dart';
import 'add_edit_income_screen.dart';
import 'income_detail_screen.dart';

class IncomeScreen extends ConsumerStatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> {
  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  String _searchQuery = '';
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final incomeAsync = ref.watch(incomeListProvider);
    final authState = ref.watch(authProvider);
    final canManageIncome =
        authState.hasPermission(AppPermissions.manageIncome);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: const Text('Income'),
        elevation: 0,
        actions: [
          if (canManageIncome)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FilledButton.icon(
                onPressed: _openAddIncome,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Income'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF12B76A),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: incomeAsync.when(
        data: (incomes) {
          final filteredIncomes = incomes.where((income) {
            final sameMonth = income.paymentDate.year == selectedMonth.year &&
                income.paymentDate.month == selectedMonth.month;
            final matchesType =
                _selectedType == 'All' || income.incomeType == _selectedType;
            final query = _searchQuery.toLowerCase().trim();
            final matchesSearch = query.isEmpty ||
                income.incomeType.toLowerCase().contains(query) ||
                income.villaName.toLowerCase().contains(query) ||
                income.paymentMethod.toLowerCase().contains(query) ||
                income.notes.toLowerCase().contains(query);

            return sameMonth && matchesType && matchesSearch;
          }).toList()
            ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

          final total = filteredIncomes.fold<double>(
            0,
            (sum, income) => sum + income.amount,
          );

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 116),
            children: [
              _MonthSelector(
                month: selectedMonth,
                onPrevious: () => _changeMonth(selectedMonth, -1),
                onNext: () => _changeMonth(selectedMonth, 1),
              ),
              const SizedBox(height: 14),
              _SummaryCard(total: total, month: selectedMonth),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search income...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xFF12B76A), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: InputDecoration(
                  labelText: 'Income Type',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
                  ),
                ),
                items: [
                  const DropdownMenuItem(
                      value: 'All', child: Text('All Income')),
                  ...IncomeTypes.values.map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedType = value);
                },
              ),
              const SizedBox(height: 18),
              if (filteredIncomes.isEmpty)
                const _EmptyIncome()
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth >= 1100
                        ? 3
                        : constraints.maxWidth >= 720
                            ? 2
                            : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredIncomes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 184,
                      ),
                      itemBuilder: (context, index) {
                        final income = filteredIncomes[index];

                        return IncomeCard(
                          income: income,
                          onTap: () => _openDetail(income),
                          onEdit: canManageIncome
                              ? () => _openEditIncome(income)
                              : null,
                          onDelete: canManageIncome
                              ? () => _confirmDelete(income)
                              : null,
                        );
                      },
                    );
                  },
                ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: canManageIncome
          ? Padding(
              padding: const EdgeInsets.only(bottom: 88),
              child: FloatingActionButton.extended(
                onPressed: _openAddIncome,
                backgroundColor: const Color(0xFF12B76A),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Income'),
              ),
            )
          : null,
    );
  }

  void _changeMonth(DateTime selectedMonth, int offset) {
    ref.read(selectedMonthProvider.notifier).state = DateTime(
      selectedMonth.year,
      selectedMonth.month + offset,
      1,
    );
  }

  void _openAddIncome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditIncomeScreen(),
      ),
    );
  }

  void _openEditIncome(Income income) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditIncomeScreen(income: income),
      ),
    );
  }

  void _openDetail(Income income) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncomeDetailScreen(incomeId: income.id),
      ),
    );
  }

  void _confirmDelete(Income income) {
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
              if (!mounted) return;
              Navigator.pop(dialogContext);
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

class _MonthSelector extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _MonthSelector({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Center(
            child: Text(
              DateFormat('MMMM yyyy').format(month),
              style: const TextStyle(
                color: Color(0xFF060B26),
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double total;
  final DateTime month;

  const _SummaryCard({
    required this.total,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FCF3),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFCDEFD8)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF067647).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFE4F8EA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Color(0xFF12B76A),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Income',
                  style: TextStyle(
                    color: Color(0xFF039855),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'QAR ${_IncomeScreenState._moneyFormat.format(total)}',
                  style: const TextStyle(
                    color: Color(0xFF060B26),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  DateFormat('MMMM yyyy').format(month),
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
      ),
    );
  }
}

class _EmptyIncome extends StatelessWidget {
  const _EmptyIncome();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.payments_outlined,
            color: Color(0xFF12B76A),
            size: 46,
          ),
          SizedBox(height: 12),
          Text(
            'No income found',
            style: TextStyle(
              color: Color(0xFF060B26),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Add an income record or adjust your filters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF646B7A),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
