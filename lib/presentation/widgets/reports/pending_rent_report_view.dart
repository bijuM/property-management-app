import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/report_models.dart';

class PendingRentReportView extends StatelessWidget {
  final List<PendingRentReportItem> items;

  const PendingRentReportView({
    Key? key,
    required this.items,
  }) : super(key: key);

  static final NumberFormat _moneyFormat = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyReport(message: 'No pending rent for this month.');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 1100
            ? 3
            : constraints.maxWidth >= 720
                ? 2
                : 1;

        return GridView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 176,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _PendingRentCard(item: item);
          },
        );
      },
    );
  }
}

class _PendingRentCard extends StatelessWidget {
  final PendingRentReportItem item;

  const _PendingRentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF8E4BC)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
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
              const Icon(Icons.schedule_rounded, color: Color(0xFFF59E0B)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.villaName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF060B26),
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Day ${item.dueDay}',
                style: const TextStyle(
                  color: Color(0xFFF59E0B),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.tenantName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF646B7A),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(child: _Metric('Expected', item.expectedRent)),
              Expanded(
                child: _Metric(
                  'Received',
                  item.receivedRent,
                  color: const Color(0xFF12B76A),
                ),
              ),
              Expanded(
                child: _Metric(
                  'Pending',
                  item.pendingRent,
                  color: const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _Metric(
    this.label,
    this.value, {
    this.color = const Color(0xFF060B26),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'QAR ${PendingRentReportView._moneyFormat.format(value)}',
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyReport extends StatelessWidget {
  final String message;

  const _EmptyReport({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF646B7A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
