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
  static final DateFormat _monthFormat = DateFormat('MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFCDEFD8)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF067647).withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  width: 36,
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        income.incomeType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF060B26),
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        income.villaName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF646B7A),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      'QAR ${_moneyFormat.format(income.amount)}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color(0xFF12B76A),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                _MetaItem(
                  icon: Icons.calendar_month_rounded,
                  text: _dateFormat.format(income.paymentDate),
                ),
                _MetaItem(
                  icon: Icons.credit_card_rounded,
                  text: income.paymentMethod,
                ),
                _MetaItem(
                  icon: Icons.event_available_rounded,
                  text: _monthFormat.format(income.monthCovered),
                ),
              ],
            ),
            if (income.notes.trim().isNotEmpty) ...[
              const SizedBox(height: 9),
              Text(
                income.notes,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF646B7A),
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
            const Spacer(),
            Row(
              children: [
                _IncomeChip(label: income.incomeType),
                const Spacer(),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _IncomeChip extends StatelessWidget {
  final String label;

  const _IncomeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF039855),
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFF8A91A1),
          size: 14,
        ),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 145),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF646B7A),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
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
