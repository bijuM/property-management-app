import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/report_models.dart';

class VillaProfitReportCard extends StatelessWidget {
  final VillaProfitReportItem item;

  const VillaProfitReportCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    final profitColor =
        item.netProfit >= 0 ? const Color(0xFF2563EB) : const Color(0xFFF04438);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF0FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.home_rounded, color: Color(0xFF2563EB)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.villaName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF060B26),
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.tenantName.isEmpty ? 'Vacant' : item.tenantName,
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
              Text(
                _money(item.netProfit),
                style: TextStyle(
                  color: profitColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Metric(label: 'Expected', value: item.expectedRent),
              _Metric(
                label: 'Received',
                value: item.receivedIncome,
                color: const Color(0xFF12B76A),
              ),
              _Metric(
                label: 'Expenses',
                value: item.totalExpense,
                color: const Color(0xFFF04438),
              ),
              _Metric(
                label: 'Pending',
                value: item.pendingAmount,
                color: const Color(0xFFF59E0B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _money(double value) => 'QAR ${_moneyFormat.format(value)}';
}

class _Metric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _Metric({
    required this.label,
    required this.value,
    this.color = const Color(0xFF060B26),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF646B7A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'QAR ${NumberFormat('#,##0.00').format(value)}',
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
