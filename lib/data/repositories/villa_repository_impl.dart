import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../domain/models/villa_model.dart';
import '../../domain/repositories/villa_repository.dart';
import '../local/database.dart';
import '../../core/constants/enums.dart';

class VillaRepositoryImpl implements VillaRepository {
  final AppDatabase database;

  VillaRepositoryImpl(this.database);

  @override
  Future<List<VillaModel>> getAllVillas() async {
    final villas = await database.getAllVillas();
    return villas.map((villa) => _mapToModel(villa)).toList();
  }

  @override
  Future<VillaModel?> getVillaById(String id) async {
    final villa = await database.getVillaById(id);
    return villa != null ? _mapToModel(villa) : null;
  }

  @override
  Future<String> addVilla(VillaModel villa) async {
    final id = villa.id.isEmpty ? const Uuid().v4() : villa.id;
    final now = DateTime.now();
    await database.insertVilla(
      VillasCompanion(
        id: Value(id),
        villaName: Value(villa.villaName),
        villaNumber: Value(villa.villaNumber),
        location: Value(villa.location),
        tenantName: Value(villa.tenantName),
        tenantPhone: Value(villa.tenantPhone),
        monthlyRent: Value(villa.monthlyRent),
        contractStartDate: Value(villa.contractStartDate),
        contractEndDate: Value(villa.contractEndDate),
        paymentDueDay: Value(villa.paymentDueDay),
        status: Value(villa.status.name),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    return id;
  }

  @override
  Future<void> updateVilla(VillaModel villa) async {
    await database.updateVilla(
      VillasCompanion(
        id: Value(villa.id),
        villaName: Value(villa.villaName),
        villaNumber: Value(villa.villaNumber),
        location: Value(villa.location),
        tenantName: Value(villa.tenantName),
        tenantPhone: Value(villa.tenantPhone),
        monthlyRent: Value(villa.monthlyRent),
        contractStartDate: Value(villa.contractStartDate),
        contractEndDate: Value(villa.contractEndDate),
        paymentDueDay: Value(villa.paymentDueDay),
        status: Value(villa.status.name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteVilla(String id) async {
    await database.deleteVilla(id);
  }

  VillaModel _mapToModel(Villa villa) {
    return VillaModel(
      id: villa.id,
      villaName: villa.villaName,
      villaNumber: villa.villaNumber,
      location: villa.location,
      tenantName: villa.tenantName,
      tenantPhone: villa.tenantPhone,
      monthlyRent: villa.monthlyRent,
      contractStartDate: villa.contractStartDate,
      contractEndDate: villa.contractEndDate,
      paymentDueDay: villa.paymentDueDay,
      status: _parseVillaStatus(villa.status),
      createdAt: villa.createdAt,
      updatedAt: villa.updatedAt,
    );
  }

  VillaStatus _parseVillaStatus(String status) {
    return VillaStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => VillaStatus.vacant,
    );
  }
}
