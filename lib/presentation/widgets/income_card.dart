import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/income.dart';

class IncomeCard extends StatelessWidget {
  final Income income;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const IncomeCard({
    Key? key,
    required this.income,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCDEFD8)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF067647).withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFE4F8EA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.payments_rounded,
                color: Color(0xFF12B76A),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    income.incomeType,
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
                      Text(
                        income.villaName,
                        style: const TextStyle(
                          color: Color(0xFF646B7A),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ' • ',
                        style: const TextStyle(
                          color: Color(0xFF646B7A),
                          fontSize: 11,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _dateFormat.format(income.paymentDate),
                          style: const TextStyle(
                            color: Color(0xFF646B7A),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
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
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'QAR ${_moneyFormat.format(income.amount)}',
                  style: const TextStyle(
                    color: Color(0xFF12B76A),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            if (onDelete != null || onEdit != null) ...[
              const SizedBox(width: 8),
              if (onEdit != null)
                _TinyIconButton(
                  tooltip: 'Edit income',
                  icon: Icons.edit_outlined,
                  color: const Color(0xFF039855),
                  onPressed: onEdit!,
                ),
              if (onEdit != null && onDelete != null)
                const SizedBox(width: 4),
              if (onDelete != null)
                _TinyIconButton(
                  tooltip: 'Delete income',
                  icon: Icons.delete_outline_rounded,
                  color: const Color(0xFFF04438),
                  onPressed: onDelete!,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TinyIconButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _TinyIconButton({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 18),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 30, height: 30),
    );
  }
}
