import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/villa_model.dart';
import 'auth_provider.dart';
import 'repository_provider.dart';
import 'sync_provider.dart';

final villasProvider = FutureProvider<List<VillaModel>>((ref) async {
  final repository = ref.watch(villaRepositoryProvider);
  return repository.getAllVillas();
});

final villaByIdProvider =
    FutureProvider.family<VillaModel?, String>((ref, id) async {
  final repository = ref.watch(villaRepositoryProvider);
  return repository.getVillaById(id);
});

final addVillaProvider =
    FutureProvider.family<String, VillaModel>((ref, villa) async {
  final repository = ref.watch(villaRepositoryProvider);
  final id = await repository.addVilla(villa);
  final currentUser = ref.read(authProvider).currentUser;
  if (currentUser != null) {
    await ref.read(firebaseSyncServiceProvider).queueVilla(
          villa: villa.copyWith(id: id),
          userId: currentUser.id,
        );
    ref.read(syncRefreshProvider.notifier).state++;
  }
  ref.invalidate(villasProvider);
  return id;
});

final updateVillaProvider =
    FutureProvider.family<void, VillaModel>((ref, villa) async {
  final repository = ref.watch(villaRepositoryProvider);
  await repository.updateVilla(villa);
  final currentUser = ref.read(authProvider).currentUser;
  if (currentUser != null) {
    await ref.read(firebaseSyncServiceProvider).queueVilla(
          villa: villa,
          userId: currentUser.id,
        );
    ref.read(syncRefreshProvider.notifier).state++;
  }
  ref.invalidate(villasProvider);
});

final deleteVillaProvider =
    FutureProvider.family<void, String>((ref, id) async {
  final repository = ref.watch(villaRepositoryProvider);
  await repository.deleteVilla(id);
  final currentUser = ref.read(authProvider).currentUser;
  if (currentUser != null) {
    await ref.read(firebaseSyncServiceProvider).queueDelete(
          collection: 'villas',
          id: id,
          userId: currentUser.id,
        );
    ref.read(syncRefreshProvider.notifier).state++;
  }
  ref.invalidate(villasProvider);
});
