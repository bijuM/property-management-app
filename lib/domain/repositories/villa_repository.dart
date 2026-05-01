import '../models/villa_model.dart';

abstract class VillaRepository {
  Future<List<VillaModel>> getAllVillas();
  Future<VillaModel?> getVillaById(String id);
  Future<String> addVilla(VillaModel villa);
  Future<void> updateVilla(VillaModel villa);
  Future<void> deleteVilla(String id);
}
