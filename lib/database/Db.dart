import 'package:sqflite/sqflite.dart';

class Db {
  static final Map<String, dynamic> _db = {};

  static Future<Database> getDatabase(String dbName, String createInfo) async {
    if (_db.isNotEmpty && _db.containsKey(dbName)) {
      return _db[dbName];
    }

    // 打开数据库，如果数据库不存在，则创建数据库
    Database db =
        await openDatabase(dbName, version: 1, onCreate: (db, version) async {
      // 创建数据库表
      await db.execute(createInfo);
    });

    print("db: $db");
    _db[dbName] = db;
    return db;
  }
}
