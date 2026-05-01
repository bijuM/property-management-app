import '../models/income_model.dart';

abstract class IncomeRepository {
  Future<List<IncomeModel>> getAllIncomes();
  Future<List<IncomeModel>> getIncomesByVillaId(String villaId);
  Future<List<IncomeModel>> getIncomesByMonth(DateTime month);
  Future<String> addIncome(IncomeModel income);
  Future<void> updateIncome(IncomeModel income);
  Future<void> deleteIncome(String id);
  Future<double> getTotalIncomeForMonth(DateTime month);
  Future<Map<String, double>> getIncomeByVillaSummary(DateTime month);
}
