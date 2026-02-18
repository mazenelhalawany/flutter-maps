import '../../../../services/sqflite.dart';
import '../model/sqlmodel.dart';
import 'sqlrepo.dart';

class PlacesLocalRepoImpl implements SqlRepo {
  @override
  Future<void> savePlace(SqlModel place) async {
    await SqlDb.instance.insert("places", place.toMap());
  }

  @override
  Future<List<SqlModel>> getSavedPlaces() async {
    // final db = await SqlDb.instance.database;

    // final result = await db.query("places", orderBy: "id DESC");

    // return result.map((e) => SqlModel.fromMap(e)).toList();
    final result = await SqlDb.instance.getAll("places");

    return result.map((e) => SqlModel.fromMap(e)).toList();
  }

  @override
  Future<void> deletePlace(int id) async {
    // final db = await SqlDb.instance.database;

    // await db.delete("places", where: "id = ?", whereArgs: [id]);
    await SqlDb.instance.delete("places", where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<void> clearAllPlaces() async {
    // final db = await SqlDb.instance.database;
    // await db.delete("places");
    await SqlDb.instance.deleteAll("places");
  }
}
