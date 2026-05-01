import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportSummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;
  final IconData icon;
  final String? subtitle;
  final bool isPercentage;

  const ReportSummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    this.subtitle,
    this.isPercentage = false,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    final valueText = isPercentage
        ? '${value.toStringAsFixed(1)}%'
        : 'QAR ${_moneyFormat.format(value)}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.22)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    valueText,
                    style: const TextStyle(
                      color: Color(0xFF060B26),
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF646B7A),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
