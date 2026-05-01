import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_permissions.dart';
import '../../core/constants/enums.dart';
import '../../domain/models/villa_model.dart';
import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/villa_provider.dart';
import 'villa_detail_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final villasAsync = ref.watch(villasProvider);
    final totalIncomeAsync =
        ref.watch(totalIncomeForMonthProvider(selectedMonth));
    final incomeSummaryAsync =
        ref.watch(incomeVillaSummaryProvider(selectedMonth));
    final expenses = ref.watch(expenseProvider);
    final authState = ref.watch(authProvider);
    final canManageIncome =
        authState.hasPermission(AppPermissions.manageIncome);
    final canManageExpenses =
        authState.hasPermission(AppPermissions.manageExpenses);
    final canManageVillas =
        authState.hasPermission(AppPermissions.manageVillas);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(villasProvider);
            ref.invalidate(totalIncomeForMonthProvider(selectedMonth));
            ref.invalidate(incomeVillaSummaryProvider(selectedMonth));
          },
          child: villasAsync.when(
            data: (villas) {
              final totalIncome = totalIncomeAsync.valueOrNull ?? 0;
              final incomeByVilla = incomeSummaryAsync.valueOrNull ?? {};
              final expensesForMonth = expenses.where(
                (expense) =>
                    expense.expenseDate.year == selectedMonth.year &&
                    expense.expenseDate.month == selectedMonth.month,
              );
              final expensesByCategory = <String, double>{};
              for (final expense in expensesForMonth) {
                expensesByCategory.update(
                  expense.category,
                  (value) => value + expense.amount,
                  ifAbsent: () => expense.amount,
                );
              }
              final totalExpense = expensesByCategory.values.fold<double>(
                0,
                (sum, value) => sum + value,
              );
              final expectedRent = villas.fold<double>(
                0,
                (sum, villa) => sum + villa.monthlyRent,
              );
              final pendingRent =
                  math.max(expectedRent - totalIncome, 0).toDouble();
              final paidVillas = villas
                  .where((villa) =>
                      (incomeByVilla[villa.id] ?? 0) >= villa.monthlyRent &&
                      villa.monthlyRent > 0)
                  .length;
              final progress = expectedRent == 0
                  ? 0.0
                  : (totalIncome / expectedRent).clamp(0.0, 1.0);

              return ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 112),
                children: [
                  const _DashboardHeader(),
                  const SizedBox(height: 24),
                  _MonthFilter(
                    selectedMonth: selectedMonth,
                    onChangeMonth: (offset) =>
                        _changeMonth(ref, selectedMonth, offset),
                  ),
                  const SizedBox(height: 18),
                  _MetricGrid(
                    totalIncome: totalIncome,
                    totalExpense: totalExpense,
                    pendingRent: pendingRent,
                    pendingVillas: math.max(villas.length - paidVillas, 0),
                  ),
                  const SizedBox(height: 14),
                  _QuickActions(
                    onAddIncome: canManageIncome
                        ? () => ref.read(selectedTabProvider.notifier).state = 2
                        : null,
                    onAddExpense: canManageExpenses
                        ? () => ref.read(selectedTabProvider.notifier).state = 3
                        : null,
                    onAddVilla: canManageVillas
                        ? () => ref.read(selectedTabProvider.notifier).state = 1
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _RentCollectionCard(
                    collected: totalIncome,
                    pending: pendingRent,
                    paidVillas: paidVillas,
                    totalVillas: villas.length,
                    progress: progress,
                  ),
                  const SizedBox(height: 22),
                  _VillaSummary(
                    villas: villas,
                    incomeByVilla: incomeByVilla,
                    onViewAll: () =>
                        ref.read(selectedTabProvider.notifier).state = 1,
                  ),
                  const SizedBox(height: 18),
                  _TopExpenses(expensesByCategory: expensesByCategory),
                ],
              );
            },
            error: (error, _) => ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const _DashboardHeader(),
                const SizedBox(height: 96),
                Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Could not load dashboard',
                    style: TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFF656B7B)),
                  ),
                ),
              ],
            ),
            loading: () => ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 112),
              children: const [
                _DashboardHeader(),
                SizedBox(height: 140),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeMonth(WidgetRef ref, DateTime currentMonth, int monthOffset) {
    ref.read(selectedMonthProvider.notifier).state = DateTime(
      currentMonth.year,
      currentMonth.month + monthOffset,
      1,
    );
  }

  static String money(double value) =>
      'QAR ${_moneyFormat.format(value.round())}';
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.menu_rounded,
              color: Colors.black,
              size: 34,
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VillaBooks',
                style: TextStyle(
                  color: Color(0xFF060B26),
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Color(0xFF6C7180),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.black,
                  size: 32,
                ),
                Positioned(
                  right: -5,
                  top: -6,
                  child: Container(
                    height: 21,
                    width: 21,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF04438),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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

class _MonthFilter extends StatelessWidget {
  final DateTime selectedMonth;
  final ValueChanged<int> onChangeMonth;

  const _MonthFilter({
    required this.selectedMonth,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    final month = DateFormat('MMMM yyyy').format(selectedMonth);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onChangeMonth(-1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    month,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF060B26),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onChangeMonth(1),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF6658E8),
                width: 1.1,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xFF5549DE),
                  size: 21,
                ),
                SizedBox(width: 8),
                Text(
                  'This Month',
                  style: TextStyle(
                    color: Color(0xFF5549DE),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF5549DE),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricGrid extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final double pendingRent;
  final int pendingVillas;

  const _MetricGrid({
    required this.totalIncome,
    required this.totalExpense,
    required this.pendingRent,
    required this.pendingVillas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Total Income',
                value: DashboardScreen.money(totalIncome),
                trend: '12% vs Apr 2026',
                color: const Color(0xFF2EA043),
                background: const Color(0xFFF1FCF3),
                border: const Color(0xFFC8EFD0),
                icon: Icons.insert_chart_outlined_rounded,
                iconBackground: const Color(0xFFDDF6E2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: 'Total Expense',
                value: DashboardScreen.money(totalExpense),
                trend: '8% vs Apr 2026',
                color: const Color(0xFFF04438),
                background: const Color(0xFFFFF6F4),
                border: const Color(0xFFFBD2CE),
                icon: Icons.show_chart_rounded,
                iconBackground: const Color(0xFFFFDFDA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Net Profit',
                value: DashboardScreen.money(totalIncome - totalExpense),
                trend: '15% vs Apr 2026',
                color: const Color(0xFF2563EB),
                background: const Color(0xFFF4F8FF),
                border: const Color(0xFFD2E2FF),
                icon: Icons.account_balance_wallet_outlined,
                iconBackground: const Color(0xFFE2EAFF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                title: 'Pending Rent',
                value: DashboardScreen.money(pendingRent),
                trend: '$pendingVillas Villas',
                color: const Color(0xFFF59E0B),
                background: const Color(0xFFFFFAF0),
                border: const Color(0xFFF8E4BC),
                icon: Icons.access_time_rounded,
                iconBackground: const Color(0xFFFFF0D6),
                showTrendArrow: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color color;
  final Color background;
  final Color border;
  final IconData icon;
  final Color iconBackground;
  final bool showTrendArrow;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.color,
    required this.background,
    required this.border,
    required this.icon,
    required this.iconBackground,
    this.showTrendArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 31,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    if (showTrendArrow)
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: color,
                        size: 16,
                      ),
                    Flexible(
                      child: Text(
                        trend,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              showTrendArrow ? const Color(0xFF596070) : color,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final VoidCallback? onAddIncome;
  final VoidCallback? onAddExpense;
  final VoidCallback? onAddVilla;

  const _QuickActions({
    required this.onAddIncome,
    required this.onAddExpense,
    required this.onAddVilla,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (onAddIncome != null)
        _ActionPill(
          label: 'Add Income',
          icon: Icons.add_circle_outline_rounded,
          color: const Color(0xFF2EA043),
          background: const Color(0xFFF0FCF3),
          border: const Color(0xFFC7ECCF),
          onTap: onAddIncome!,
        ),
      if (onAddExpense != null)
        _ActionPill(
          label: 'Add Expense',
          icon: Icons.add_circle_outline_rounded,
          color: const Color(0xFFF04438),
          background: const Color(0xFFFFF5F4),
          border: const Color(0xFFF8C9C3),
          onTap: onAddExpense!,
        ),
      if (onAddVilla != null)
        _ActionPill(
          label: 'Add Villa',
          icon: Icons.home_outlined,
          color: const Color(0xFF5549DE),
          background: const Color(0xFFF4F0FF),
          border: const Color(0xFFE1D6FF),
          onTap: onAddVilla!,
        ),
    ];

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return _RaisedPanel(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Color(0xFF060B26),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: List.generate(actions.length * 2 - 1, (index) {
              if (index.isOdd) return const SizedBox(width: 10);
              return Expanded(child: actions[index ~/ 2]);
            }),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;
  final Color border;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
    required this.border,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 29),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF060B26),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RentCollectionCard extends StatelessWidget {
  final double collected;
  final double pending;
  final int paidVillas;
  final int totalVillas;
  final double progress;

  const _RentCollectionCard({
    required this.collected,
    required this.pending,
    required this.paidVillas,
    required this.totalVillas,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return _RaisedPanel(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rent Collection Status',
            style: TextStyle(
              color: Color(0xFF060B26),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _CollectionAmount(
                            label: 'Collected',
                            value: DashboardScreen.money(collected),
                            color: const Color(0xFF2EA043),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 45,
                          color: const Color(0xFFD8DCE5),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: _CollectionAmount(
                              label: 'Pending',
                              value: DashboardScreen.money(pending),
                              color: const Color(0xFFF04438),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                              backgroundColor: const Color(0xFFE4E4E6),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF35A84A),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          '$percent%',
                          style: const TextStyle(
                            color: Color(0xFF060B26),
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$paidVillas of $totalVillas villas paid',
                        style: const TextStyle(
                          color: Color(0xFF656B7B),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const SizedBox(
                height: 104,
                width: 106,
                child: _RentIllustration(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CollectionAmount extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CollectionAmount({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF656B7B),
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _VillaSummary extends StatelessWidget {
  final List<VillaModel> villas;
  final Map<String, double> incomeByVilla;
  final VoidCallback onViewAll;

  const _VillaSummary({
    required this.villas,
    required this.incomeByVilla,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final visibleVillas = villas.take(3).toList();

    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Villa Summary',
                style: TextStyle(
                  color: Color(0xFF3B4152),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF5549DE),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _RaisedPanel(
          padding: EdgeInsets.zero,
          child: visibleVillas.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'No villas added yet',
                      style: TextStyle(
                        color: Color(0xFF656B7B),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: List.generate(visibleVillas.length, (index) {
                    final villa = visibleVillas[index];
                    final received = incomeByVilla[villa.id] ?? 0;
                    final pending =
                        math.max(villa.monthlyRent - received, 0).toDouble();

                    return Column(
                      children: [
                        _VillaRow(
                          villa: villa,
                          received: received,
                          pending: pending,
                        ),
                        if (index != visibleVillas.length - 1)
                          const Divider(height: 1, color: Color(0xFFE5E7EF)),
                      ],
                    );
                  }),
                ),
        ),
      ],
    );
  }
}

class _VillaRow extends StatelessWidget {
  final VillaModel villa;
  final double received;
  final double pending;

  const _VillaRow({
    required this.villa,
    required this.received,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    final isVacant = villa.status == VillaStatus.vacant;
    final isPaid = !isVacant && pending <= 0 && villa.monthlyRent > 0;
    final isPartial = !isVacant && received > 0 && pending > 0;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VillaDetailScreen(villaId: villa.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 74,
                width: 74,
                child: CustomPaint(
                  painter:
                      _VillaThumbnailPainter(seed: villa.villaNumber.hashCode),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    villa.villaName.isEmpty
                        ? 'Villa ${villa.villaNumber}'
                        : villa.villaName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    isVacant ? 'Tenant: Vacant' : 'Tenant: ${villa.tenantName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF596070),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _VillaAmount(
                          label: 'Rent',
                          value: DashboardScreen.money(villa.monthlyRent),
                          color: isPaid
                              ? const Color(0xFF2EA043)
                              : const Color(0xFF060B26),
                        ),
                      ),
                      _SmallDivider(),
                      Expanded(
                        child: _VillaAmount(
                          label: 'Received',
                          value: DashboardScreen.money(received),
                          color: received > 0
                              ? const Color(0xFF2EA043)
                              : const Color(0xFF596070),
                        ),
                      ),
                      if (!isPaid) ...[
                        _SmallDivider(),
                        Expanded(
                          child: _VillaAmount(
                            label: 'Pending',
                            value: DashboardScreen.money(pending),
                            color: isPartial
                                ? const Color(0xFFF59E0B)
                                : const Color(0xFFF04438),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusBadge(
              isPaid: isPaid,
              isPartial: isPartial,
              isVacant: isVacant,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF89909E),
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class _VillaAmount extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _VillaAmount({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF656B7B),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _SmallDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 9),
      color: const Color(0xFFD8DCE5),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isPaid;
  final bool isPartial;
  final bool isVacant;

  const _StatusBadge({
    required this.isPaid,
    required this.isPartial,
    required this.isVacant,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPaid
        ? const Color(0xFF2EA043)
        : isPartial
            ? const Color(0xFFF59E0B)
            : const Color(0xFF6C7180);
    final background = isPaid
        ? const Color(0xFFE5F8E9)
        : isPartial
            ? const Color(0xFFFFF0D6)
            : const Color(0xFFF0F1F4);
    final label = isPaid
        ? 'Paid'
        : isPartial
            ? 'Partial'
            : isVacant
                ? 'Vacant'
                : 'Pending';

    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (isPaid || isPartial) ...[
            const SizedBox(width: 5),
            Icon(
              isPaid ? Icons.check_rounded : Icons.error_outline_rounded,
              color: color,
              size: 18,
            ),
          ],
        ],
      ),
    );
  }
}

class _TopExpenses extends StatelessWidget {
  final Map<String, double> expensesByCategory;

  const _TopExpenses({required this.expensesByCategory});

  @override
  Widget build(BuildContext context) {
    final total =
        expensesByCategory.values.fold<double>(0, (sum, value) => sum + value);
    final entries = expensesByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final items = entries.take(4).toList();

    while (items.length < 4) {
      final defaults = ['maintenance', 'electricity', 'cleaning', 'other'];
      final name = defaults[items.length];
      items.add(MapEntry(name, 0));
    }

    return _RaisedPanel(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 16),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Top Expenses',
                  style: TextStyle(
                    color: Color(0xFF060B26),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'This Month',
                style: TextStyle(
                  color: Color(0xFF5549DE),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: List.generate(items.length, (index) {
              final entry = items[index];
              final config = _ExpenseVisual.forName(entry.key);
              final percentage = total == 0 ? 0.0 : (entry.value / total) * 100;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _ExpenseChip(
                        title: config.title,
                        amount: entry.value,
                        percent: percentage,
                        icon: config.icon,
                        color: config.color,
                        background: config.background,
                      ),
                    ),
                    if (index != items.length - 1)
                      Container(
                        height: 48,
                        width: 1,
                        color: const Color(0xFFD8DCE5),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ExpenseChip extends StatelessWidget {
  final String title;
  final double amount;
  final double percent;
  final IconData icon;
  final Color color;
  final Color background;

  const _ExpenseChip({
    required this.title,
    required this.amount,
    required this.percent,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF596070),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            DashboardScreen.money(amount),
            style: const TextStyle(
              color: Color(0xFF060B26),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${percent.toStringAsFixed(1)}%',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _ExpenseVisual {
  final String title;
  final IconData icon;
  final Color color;
  final Color background;

  const _ExpenseVisual({
    required this.title,
    required this.icon,
    required this.color,
    required this.background,
  });

  static _ExpenseVisual forName(String name) {
    switch (name.toLowerCase().replaceAll(' ', '')) {
      case 'maintenance':
      case 'repair':
        return const _ExpenseVisual(
          title: 'Maintenance',
          icon: Icons.build_rounded,
          color: Color(0xFF5549DE),
          background: Color(0xFFEDE9FF),
        );
      case 'electricity':
        return const _ExpenseVisual(
          title: 'Electricity',
          icon: Icons.bolt_rounded,
          color: Color(0xFFF59E0B),
          background: Color(0xFFFFF0D6),
        );
      case 'cleaning':
        return const _ExpenseVisual(
          title: 'Cleaning',
          icon: Icons.cleaning_services_rounded,
          color: Color(0xFFF04438),
          background: Color(0xFFFFE6E3),
        );
      default:
        return const _ExpenseVisual(
          title: 'Others',
          icon: Icons.more_horiz_rounded,
          color: Color(0xFF2563EB),
          background: Color(0xFFEAF0FF),
        );
    }
  }
}

class _RaisedPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _RaisedPanel({
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _RentIllustration extends StatelessWidget {
  const _RentIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RentIllustrationPainter());
  }
}

class _RentIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = const Color(0xFFFFE8C4);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.48), 43, paint);

    final board = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          size.width * 0.32, 8, size.width * 0.44, size.height * 0.74),
      const Radius.circular(5),
    );
    paint.color = const Color(0xFFFFC978);
    canvas.drawRRect(board, paint);

    final paper = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          size.width * 0.37, 14, size.width * 0.34, size.height * 0.65),
      const Radius.circular(4),
    );
    paint.color = Colors.white;
    canvas.drawRRect(paper, paint);

    paint.color = const Color(0xFFE3E8FF);
    for (var i = 0; i < 5; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.49, 27 + i * 10, size.width * 0.17, 4),
          const Radius.circular(2),
        ),
        paint,
      );
    }

    paint.color = const Color(0xFF7B84A1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.44, 2, size.width * 0.24, 15),
        const Radius.circular(4),
      ),
      paint,
    );

    final roof = Path()
      ..moveTo(size.width * 0.08, size.height * 0.74)
      ..lineTo(size.width * 0.25, size.height * 0.51)
      ..lineTo(size.width * 0.42, size.height * 0.74)
      ..close();
    paint.color = const Color(0xFFE84A56);
    canvas.drawPath(roof, paint);

    paint.color = const Color(0xFFD9E6F7);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.13, size.height * 0.70, 32, 27),
      paint,
    );
    paint.color = const Color(0xFFA5C7E6);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.26, size.height * 0.77, 9, 20),
      paint,
    );

    paint.color = const Color(0xFF62C98F);
    canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.75), 19, paint);
    final check = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.76, size.height * 0.74)
      ..lineTo(size.width * 0.82, size.height * 0.80)
      ..lineTo(size.width * 0.91, size.height * 0.67);
    canvas.drawPath(path, check);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _VillaThumbnailPainter extends CustomPainter {
  final int seed;

  const _VillaThumbnailPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final sky = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFAED2FF),
        Color(0xFFEAF3FF),
        Color(0xFFD7C3A0),
      ],
    ).createShader(sky);
    canvas.drawRect(sky, paint);
    paint.shader = null;

    final sunX = seed.isEven ? size.width * 0.78 : size.width * 0.2;
    paint.color = const Color(0xFFFFE6A3);
    canvas.drawCircle(Offset(sunX, size.height * 0.18), 8, paint);

    paint.color = const Color(0xFFC9A775);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.18, size.height * 0.34, size.width * 0.64,
          size.height * 0.42),
      paint,
    );
    paint.color = const Color(0xFFEAD8B8);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.23, size.height * 0.27, size.width * 0.54,
          size.height * 0.45),
      paint,
    );
    paint.color = const Color(0xFFB08756);
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.19, size.height * 0.26, size.width * 0.62, 5),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.16, size.height * 0.51, size.width * 0.68, 5),
      paint,
    );

    paint.color = const Color(0xFF92B6D9);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.31, size.height * 0.37, 12, 12),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.58, size.height * 0.37, 12, 12),
      paint,
    );
    paint.color = const Color(0xFF7C5A35);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.46, size.height * 0.56, 12, 20),
      paint,
    );

    paint.color = const Color(0xFF2C8A4A);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.77, size.width, 5), paint);
    for (final x in [7.0, size.width - 10]) {
      paint.color = const Color(0xFF8B5E36);
      canvas.drawRect(Rect.fromLTWH(x, size.height * 0.42, 3, 28), paint);
      paint.color = const Color(0xFF287A3C);
      canvas.drawOval(Rect.fromLTWH(x - 8, size.height * 0.31, 19, 18), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _VillaThumbnailPainter oldDelegate) {
    return oldDelegate.seed != seed;
  }
}
