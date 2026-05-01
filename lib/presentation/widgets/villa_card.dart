import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/enums.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/models/villa_model.dart';

class VillaCard extends StatelessWidget {
  final VillaModel villa;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const VillaCard({
    Key? key,
    required this.villa,
    required this.onTap,
    this.onDelete,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Villa Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          villa.villaName,
                          style: AppStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Villa # ${villa.villaNumber}',
                    style: AppStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Location
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location',
                    style: AppStyles.labelSmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          villa.location,
                          style: AppStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Tenant
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tenant',
                    style: AppStyles.labelSmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    villa.tenantName.isEmpty ? '—' : villa.tenantName,
                    style: AppStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (onDelete != null) ...[
              IconButton(
                tooltip: 'Delete villa',
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
            ],

            // Monthly Rent + Status
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(villa.status).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      villa.status.displayName,
                      style: AppStyles.labelSmall.copyWith(
                        color: _getStatusColor(villa.status),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    CurrencyFormatter.format(villa.monthlyRent),
                    style: AppStyles.titleSmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
