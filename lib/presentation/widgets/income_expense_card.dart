import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/date_formatter.dart';

class IncomeExpenseCard extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;
  final String? category;
  final bool isIncome;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const IncomeExpenseCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.date,
    this.category,
    required this.isIncome,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isIncome ? AppColors.success : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (category != null) ...[
                        Text(
                          category!,
                          style: AppStyles.labelSmall,
                        ),
                        Text(
                          ' • ',
                          style: AppStyles.labelSmall,
                        ),
                      ],
                      Text(
                        DateFormatter.formatShort(date),
                        style: AppStyles.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isIncome ? '+' : '-'} ${CurrencyFormatter.format(amount)}',
                  style: AppStyles.titleSmall.copyWith(color: color),
                ),
              ],
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.more_vert,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
