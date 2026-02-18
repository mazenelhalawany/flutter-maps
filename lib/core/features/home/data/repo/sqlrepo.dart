import '../model/sqlmodel.dart';

abstract class SqlRepo {
  Future<void> savePlace(SqlModel place);
  Future<List<SqlModel>> getSavedPlaces();
  Future<void> deletePlace(int id);
  Future<void> clearAllPlaces();
}
