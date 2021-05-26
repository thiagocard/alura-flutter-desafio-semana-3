import 'package:flutter_app/database/app_db.dart';
import 'package:flutter_app/models/band.dart';

class BandsDao {

  static final String tableName = 'bands';
  static final String id = '_id';
  static final String categoryId = 'category_id';
  static final String name = 'name';
  static final String image = 'image';

  BandsDao._();

  static Future<List<Band>> findAll() async {
    var db = await AppDB.database;
    return (await db.query(tableName)).map((row) {
      return Band(row[id], row[categoryId], row[name], row[image]);
    }).toList();
  }

  static Future<int> save(Band band) async {
    var db = await AppDB.database;
    var map = {
      '_id': band.uuid,
      'name': band.name,
      'category_id': band.categoryId,
      'image': band.image
    };
    return await db.insert(tableName, map);
  }

  static Future<int> remove(String uuid) async {
    var db = await AppDB.database;
    return await db.delete(tableName, where: '_id = ?', whereArgs: [uuid]);
  }

}