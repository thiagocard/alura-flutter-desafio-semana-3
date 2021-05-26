import 'package:flutter_app/models/band.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'bands_dao.dart';

class AppDB {

  AppDB._();

  static Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'bands.db');
    return openDatabase(path, version: 1, onCreate: (Database db, int version) {
      db.execute('CREATE TABLE IF NOT EXISTS bands('
          '${BandsDao.id} TEXT PRIMARY KEY,'
          '${BandsDao.categoryId} INTEGER,'
          '${BandsDao.name} TEXT NOT NULL,'
          '${BandsDao.image} TEXT)');
    });
  }

}
