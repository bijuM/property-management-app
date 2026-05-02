import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/sync_provider.dart';

class SyncStatusWidget extends ConsumerWidget {
  const SyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider).valueOrNull ?? false;
    final pendingCount = ref.watch(pendingSyncCountProvider).valueOrNull ?? 0;
    final lastSyncedAt = ref.watch(lastSyncedAtProvider).valueOrNull;
    final controller = ref.watch(syncControllerProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isOnline ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                color: isOnline
                    ? const Color(0xFF2EA043)
                    : const Color(0xFFF59E0B),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cloud Sync',
                      style: TextStyle(
                        color: Color(0xFF060B26),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(
                        color: Color(0xFF646B7A),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: isOnline ? controller.syncNow : null,
                icon: const Icon(Icons.sync_rounded, size: 18),
                label: const Text('Sync Now'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Pending sync: $pendingCount',
            style: const TextStyle(
              color: Color(0xFF060B26),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Last synced: ${_formatLastSynced(lastSyncedAt)}',
            style: const TextStyle(
              color: Color(0xFF646B7A),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastSynced(DateTime? value) {
    if (value == null) return 'Never';
    return DateFormat('MMM d, yyyy h:mm a').format(value);
  }
}
