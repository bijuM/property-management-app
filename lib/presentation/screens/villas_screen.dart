import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/app_permissions.dart';
import '../../core/utils/currency_formatter.dart';
import '../providers/auth_provider.dart';
import '../providers/villa_provider.dart';
import '../widgets/villa_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/summary_card.dart';
import 'add_edit_villa_screen.dart';
import 'villa_detail_screen.dart';

class VillasScreen extends ConsumerStatefulWidget {
  const VillasScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VillasScreen> createState() => _VillasScreenState();
}

class _VillasScreenState extends ConsumerState<VillasScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final villasAsync = ref.watch(villasProvider);
    final authState = ref.watch(authProvider);
    final canManageVillas =
        authState.hasPermission(AppPermissions.manageVillas);
    final canDeleteVillas = canManageVillas &&
        authState.hasPermission(AppPermissions.deleteRecords);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Villas'),
        elevation: 0,
        actions: [
          if (canManageVillas)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FilledButton.icon(
                onPressed: _openAddVillaScreen,
                icon: const Icon(Icons.add),
                label: const Text('Add Villa'),
              ),
            ),
        ],
      ),
      body: villasAsync.when(
        data: (villas) {
          final filteredVillas = villas
              .where((villa) =>
                  villa.villaName
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ||
                  villa.tenantName
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ||
                  villa.villaNumber
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
              .toList();

          final occupied =
              villas.where((v) => v.status.name == 'occupied').length;
          final vacant = villas.where((v) => v.status.name == 'vacant').length;
          final expectedRent =
              villas.fold<double>(0, (sum, v) => sum + v.monthlyRent);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Total Villas',
                          value: villas.length.toString(),
                          color: AppColors.primary,
                          icon: Icons.home,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          title: 'Occupied',
                          value: occupied.toString(),
                          color: AppColors.success,
                          icon: Icons.check_circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Vacant',
                          value: vacant.toString(),
                          color: AppColors.warning,
                          icon: Icons.home_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          title: 'Monthly Rent',
                          value: CurrencyFormatter.format(expectedRent),
                          color: AppColors.profit,
                          icon: Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search villas or tenants...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Villas List - Grid Layout
                  if (filteredVillas.isEmpty)
                    EmptyState(
                      icon: Icons.home_outlined,
                      title: _searchQuery.isEmpty ? 'No Villas' : 'No Results',
                      subtitle: _searchQuery.isEmpty
                          ? 'Create your first villa to get started'
                          : 'Try a different search term',
                    )
                  else
                    Column(
                      children: List.generate(
                        (filteredVillas.length / 2).ceil(),
                        (rowIndex) {
                          final startIndex = rowIndex * 2;
                          final endIndex =
                              (startIndex + 2 > filteredVillas.length)
                                  ? filteredVillas.length
                                  : startIndex + 2;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                // First Villa Card
                                Expanded(
                                  child: VillaCard(
                                    villa: filteredVillas[startIndex],
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VillaDetailScreen(
                                            villaId:
                                                filteredVillas[startIndex].id,
                                          ),
                                        ),
                                      );
                                    },
                                    onDelete: canDeleteVillas
                                        ? () {
                                            _showDeleteConfirmation(
                                              context,
                                              filteredVillas[startIndex].id,
                                            );
                                          }
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Second Villa Card (if exists)
                                if (endIndex > startIndex + 1)
                                  Expanded(
                                    child: VillaCard(
                                      villa: filteredVillas[startIndex + 1],
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VillaDetailScreen(
                                              villaId:
                                                  filteredVillas[startIndex + 1]
                                                      .id,
                                            ),
                                          ),
                                        );
                                      },
                                      onDelete: canDeleteVillas
                                          ? () {
                                              _showDeleteConfirmation(
                                                context,
                                                filteredVillas[startIndex + 1]
                                                    .id,
                                              );
                                            }
                                          : null,
                                    ),
                                  )
                                else
                                  // Empty space if odd number
                                  Expanded(child: SizedBox.shrink()),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading villas',
                style: AppStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: AppStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: canManageVillas
          ? FloatingActionButton(
              onPressed: _openAddVillaScreen,
              tooltip: 'Add Villa',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _openAddVillaScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddEditVillaScreen(),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String villaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Villa?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(deleteVillaProvider(villaId));
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
