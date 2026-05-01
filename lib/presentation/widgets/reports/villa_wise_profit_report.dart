import 'package:flutter/material.dart';

import '../../../domain/models/report_models.dart';
import 'villa_profit_report_card.dart';

class VillaWiseProfitReport extends StatelessWidget {
  final List<VillaProfitReportItem> items;

  const VillaWiseProfitReport({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyReport(message: 'No villas found for this report.');
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
            mainAxisExtent: 184,
          ),
          itemBuilder: (context, index) {
            return VillaProfitReportCard(item: items[index]);
          },
        );
      },
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
