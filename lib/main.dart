import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_permissions.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/expenses_screen.dart';
import 'presentation/screens/income/income_screen.dart';
import 'presentation/screens/reports/reports_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/villas_screen.dart';
import 'presentation/providers/navigation_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VillaBooks',
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!authState.isLoggedIn) {
      return const LoginScreen();
    }

    return const MainScreen();
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);
    final authState = ref.watch(authProvider);
    final navItems = [
      const _NavItem(
        Icons.grid_view_rounded,
        Icons.grid_view_outlined,
        'Dashboard',
        DashboardScreen(),
      ),
      const _NavItem(
        Icons.home_rounded,
        Icons.home_outlined,
        'Villas',
        VillasScreen(),
      ),
      const _NavItem(
        Icons.arrow_circle_down_rounded,
        Icons.arrow_downward_rounded,
        'Income',
        IncomeScreen(),
      ),
      const _NavItem(
        Icons.arrow_circle_up_rounded,
        Icons.arrow_outward_rounded,
        'Expenses',
        ExpensesScreen(),
      ),
      if (authState.hasPermission(AppPermissions.viewReports))
        const _NavItem(
          Icons.bar_chart_rounded,
          Icons.bar_chart_outlined,
          'Reports',
          ReportsScreen(),
        ),
      const _NavItem(
        Icons.settings_rounded,
        Icons.settings_outlined,
        'Settings',
        SettingsScreen(),
      ),
    ];
    final safeIndex = selectedIndex >= navItems.length ? 0 : selectedIndex;

    if (safeIndex != selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedTabProvider.notifier).state = safeIndex;
      });
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: safeIndex,
        children: navItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: _VillaBooksBottomNav(
        selectedIndex: safeIndex,
        items: navItems,
        onTap: (index) {
          ref.read(selectedTabProvider.notifier).state = index;
        },
      ),
    );
  }
}

class _VillaBooksBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  const _VillaBooksBottomNav({
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, bottomPadding > 0 ? 8 : 12),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(31),
          border: Border.all(color: const Color(0xFFE8EAF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.11),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == selectedIndex;

            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () => onTap(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isSelected ? item.activeIcon : item.icon,
                      size: 28,
                      color: isSelected
                          ? const Color(0xFF5549DE)
                          : const Color(0xFF626978),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF5549DE)
                              : const Color(0xFF626978),
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  final Widget screen;

  const _NavItem(this.activeIcon, this.icon, this.label, this.screen);
}
