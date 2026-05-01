import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/app_permissions.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/date_formatter.dart';
import '../providers/auth_provider.dart';
import '../providers/villa_provider.dart';
import 'add_edit_villa_screen.dart';

class VillaDetailScreen extends ConsumerWidget {
  final String villaId;

  const VillaDetailScreen({
    Key? key,
    required this.villaId,
  }) : super(key: key);

  Color _getStatusColor(VillaStatus status) {
    switch (status) {
      case VillaStatus.occupied:
        return AppColors.success;
      case VillaStatus.vacant:
        return AppColors.warning;
      case VillaStatus.maintenance:
        return AppColors.error;
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final villaAsync = ref.watch(villaByIdProvider(villaId));
    final authState = ref.watch(authProvider);
    final canManageVillas =
        authState.hasPermission(AppPermissions.manageVillas);
    final canDeleteVillas = canManageVillas &&
        authState.hasPermission(AppPermissions.deleteRecords);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Villa Details'),
        elevation: 0,
      ),
      body: villaAsync.when(
        data: (villa) {
          if (villa == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 48,
                    color: AppColors.border,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Villa not found',
                    style: AppStyles.titleMedium,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card with Villa Name and Status
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    villa.villaName,
                                    style: AppStyles.titleLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Villa # ${villa.villaNumber}',
                                    style: AppStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(villa.status)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                villa.status.displayName,
                                style: AppStyles.labelMedium.copyWith(
                                  color: _getStatusColor(villa.status),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                villa.location,
                                style: AppStyles.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Monthly Rent Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.success.withOpacity(0.1),
                          AppColors.success.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Expected Rent',
                          style: AppStyles.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          CurrencyFormatter.format(villa.monthlyRent),
                          style: AppStyles.headlineSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Due on Day ${villa.paymentDueDay}',
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tenant Information
                  if (villa.status == VillaStatus.occupied) ...[
                    Text(
                      'Tenant Information',
                      style: AppStyles.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tenant Name',
                                      style: AppStyles.labelSmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      villa.tenantName,
                                      style: AppStyles.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone Number',
                                      style: AppStyles.labelSmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      villa.tenantPhone,
                                      style: AppStyles.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Contract Information
                  Text(
                    'Contract Information',
                    style: AppStyles.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date',
                                  style: AppStyles.labelSmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormatter.format(villa.contractStartDate),
                                  style: AppStyles.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'End Date',
                                  style: AppStyles.labelSmall,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormatter.format(villa.contractEndDate),
                                  style: AppStyles.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _getContractProgress(
                                villa.contractStartDate, villa.contractEndDate),
                            minHeight: 6,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getContractProgress(villa.contractStartDate,
                                          villa.contractEndDate) >
                                      0.8
                                  ? AppColors.error
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getContractDaysRemaining(villa.contractEndDate),
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  if (canManageVillas) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditVillaScreen(villa: villa),
                            ),
                          ).then((_) {
                            ref.invalidate(villaByIdProvider);
                          });
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit Villa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (canDeleteVillas)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showDeleteConfirmation(context, ref),
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Delete Villa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error.withOpacity(0.1),
                          foregroundColor: AppColors.error,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
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
                'Error loading villa',
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
    );
  }

  double _getContractProgress(DateTime startDate, DateTime endDate) {
    final now = DateTime.now();
    final totalDays = endDate.difference(startDate).inDays;
    final daysPassed = now.difference(startDate).inDays;
    return (daysPassed / totalDays).clamp(0.0, 1.0);
  }

  String _getContractDaysRemaining(DateTime endDate) {
    final now = DateTime.now();
    final daysRemaining = endDate.difference(now).inDays;

    if (daysRemaining < 0) {
      return 'Contract expired ${daysRemaining.abs()} days ago';
    } else if (daysRemaining == 0) {
      return 'Contract expires today';
    } else if (daysRemaining == 1) {
      return '1 day remaining';
    } else {
      return '$daysRemaining days remaining';
    }
  }
}
