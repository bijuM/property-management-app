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
        padding: const EdgeInsets.all(12),
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
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.home_outlined,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    villa.villaName,
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          villa.location,
                          style: const TextStyle(
                            color: Color(0xFF646B7A),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        ' • ',
                        style: const TextStyle(
                          color: Color(0xFF646B7A),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        villa.tenantName.isEmpty ? 'No tenant' : villa.tenantName,
                        style: const TextStyle(
                          color: Color(0xFF646B7A),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(villa.status).withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                villa.status.displayName,
                style: TextStyle(
                  color: _getStatusColor(villa.status),
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              CurrencyFormatter.format(villa.monthlyRent),
              style: const TextStyle(
                color: AppColors.success,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Delete villa',
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(width: 30, height: 30),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
