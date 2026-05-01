import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/villa_model.dart';
import 'repository_provider.dart';

final villasProvider =
    FutureProvider<List<VillaModel>>((ref) async {
  final repository = ref.watch(villaRepositoryProvider);
  return repository.getAllVillas();
});

final villaByIdProvider =
    FutureProvider.family<VillaModel?, String>((ref, id) async {
  final repository = ref.watch(villaRepositoryProvider);
  return repository.getVillaById(id);
});

final addVillaProvider = FutureProvider.family<String, VillaModel>((ref, villa) async {
  final repository = ref.watch(villaRepositoryProvider);
  final id = await repository.addVilla(villa);
  ref.invalidate(villasProvider);
  return id;
});

final updateVillaProvider =
    FutureProvider.family<void, VillaModel>((ref, villa) async {
  final repository = ref.watch(villaRepositoryProvider);
  await repository.updateVilla(villa);
  ref.invalidate(villasProvider);
});

final deleteVillaProvider =
    FutureProvider.family<void, String>((ref, id) async {
  final repository = ref.watch(villaRepositoryProvider);
  await repository.deleteVilla(id);
  ref.invalidate(villasProvider);
});
