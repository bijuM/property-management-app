import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_permissions.dart';
import '../../domain/models/expense.dart';
import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_card.dart';
import 'add_edit_expense_screen.dart';
import 'expense_detail_screen.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final expenses = ref.watch(expenseProvider);
    final notifier = ref.read(expenseProvider.notifier);
    final total = notifier.getTotalExpensesForMonth(selectedMonth);
    final authState = ref.watch(authProvider);
    final canManageExpenses =
        authState.hasPermission(AppPermissions.manageExpenses);

    final filteredExpenses = expenses.where((expense) {
      final sameMonth = expense.expenseDate.year == selectedMonth.year &&
          expense.expenseDate.month == selectedMonth.month;
      final matchesCategory =
          _selectedCategory == 'All' || expense.category == _selectedCategory;
      final query = _searchQuery.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          expense.category.toLowerCase().contains(query) ||
          expense.villaName.toLowerCase().contains(query) ||
          expense.paidTo.toLowerCase().contains(query) ||
          expense.paymentMethod.toLowerCase().contains(query) ||
          expense.notes.toLowerCase().contains(query);

      return sameMonth && matchesCategory && matchesSearch;
    }).toList()
      ..sort((a, b) => b.expenseDate.compareTo(a.expenseDate));

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: const Text('Expenses'),
        elevation: 0,
        actions: [
          if (canManageExpenses)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FilledButton.icon(
                onPressed: _openAddExpense,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Expense'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFF04438),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: ListView(
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
              hintText: 'Search expenses...',
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
                    const BorderSide(color: Color(0xFFF04438), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category',
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
                  value: 'All', child: Text('All Categories')),
              ...ExpenseCategories.values.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedCategory = value);
            },
          ),
          const SizedBox(height: 18),
          if (filteredExpenses.isEmpty)
            const _EmptyExpenses()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredExpenses.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 76,
                  ),
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];

                    return ExpenseCard(
                      expense: expense,
                      onTap: () => _openDetail(expense),
                      onEdit: canManageExpenses
                          ? () => _openEditExpense(expense)
                          : null,
                      onDelete: canManageExpenses
                          ? () => _confirmDelete(expense)
                          : null,
                    );
                  },
                );
              },
            ),
        ],
      ),
      floatingActionButton: canManageExpenses
          ? Padding(
              padding: const EdgeInsets.only(bottom: 88),
              child: FloatingActionButton.extended(
                heroTag: 'add-expense-fab',
                onPressed: _openAddExpense,
                backgroundColor: const Color(0xFFF04438),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Expense'),
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

  void _openAddExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditExpenseScreen(),
      ),
    );
  }

  void _openEditExpense(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditExpenseScreen(expense: expense),
      ),
    );
  }

  void _openDetail(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expenseId: expense.id),
      ),
    );
  }

  void _confirmDelete(Expense expense) {
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
        color: const Color(0xFFFFF6F4),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFFBD2CE)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB42318).withValues(alpha: 0.08),
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
              color: Color(0xFFFFDFDA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.trending_down_rounded,
              color: Color(0xFFF04438),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Expenses',
                  style: TextStyle(
                    color: Color(0xFFF04438),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'QAR ${_ExpensesScreenState._moneyFormat.format(total)}',
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

class _EmptyExpenses extends StatelessWidget {
  const _EmptyExpenses();

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
            Icons.receipt_long_outlined,
            color: Color(0xFFF04438),
            size: 46,
          ),
          SizedBox(height: 12),
          Text(
            'No expenses found',
            style: TextStyle(
              color: Color(0xFF060B26),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Add an expense or adjust your filters.',
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
