import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ExpenseCard({
    Key? key,
    required this.expense,
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
          border: Border.all(color: const Color(0xFFF1D6CF)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB42318).withValues(alpha: 0.06),
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
                color: Color(0xFFFFE6E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: Color(0xFFF04438),
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
                    expense.category,
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
                          expense.villaName.trim().isEmpty
                              ? 'General Expense'
                              : expense.villaName,
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
                        _dateFormat.format(expense.expenseDate),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'QAR ${_moneyFormat.format(expense.amount)}',
                  style: const TextStyle(
                    color: Color(0xFFF04438),
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
                  tooltip: 'Edit expense',
                  icon: Icons.edit_outlined,
                  color: const Color(0xFFF79009),
                  onPressed: onEdit!,
                ),
              if (onEdit != null && onDelete != null)
                const SizedBox(width: 4),
              if (onDelete != null)
                _TinyIconButton(
                  tooltip: 'Delete expense',
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
