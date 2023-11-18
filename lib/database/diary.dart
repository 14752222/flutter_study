import 'package:sqflite/sqflite.dart';
import 'package:study_1/database/Db.dart';

// 定义一个DBColumns类
class DBColumns {
  // 定义表名
  static const String tableName = 'diary';

  // 定义id列名
  static const String columnId = '_id';

  // 定义title列名
  static const String columnTitle = 'title';

  // 定义image列名
  static const String columnImage = 'image';

  // 定义content列名
  static const String columnContent = 'content';

  // 定义textRightToLeft列名
  static const String columnTextRightToLeft = 'textRightToLeft';

  // 定义weather列名
  static const String columnWeather = 'weather';

  // 定义emotion列名
  static const String columnEmotion = 'emotion';

  // 定义date列名
  static const String columnDate = 'date';
}

// 定义一个Diary类

// 类DiaryDb，用于操作数据库
class DiaryDb {
  late final Database _db;

  DiaryDb() {
    _init();
  }

  // 初始化数据库
  void _init() async {
    _db = await Db.getDatabase('diary.db', '''
      CREATE TABLE ${DBColumns.tableName} (
        ${DBColumns.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBColumns.columnTitle} TEXT,
        ${DBColumns.columnImage} TEXT,
        ${DBColumns.columnContent} TEXT,
        ${DBColumns.columnTextRightToLeft} INTEGER,
        ${DBColumns.columnWeather} INTEGER,
        ${DBColumns.columnEmotion} INTEGER,
        ${DBColumns.columnDate} TEXT
      )
    ''');
  }

  // 插入一条数据
  Future<int> insert(Diary diary) async {
    return await _db.insert(DBColumns.tableName, diary.toMap());
  }

  // 查询所有数据
  Future<List<Diary>> queryAll() async {
    List<Map<String, dynamic>> maps = await _db.query(DBColumns.tableName);
    return List.generate(maps.length, (index) {
      return Diary().formMap(maps[index]);
    });
  }

  // 根据id查询数据
  Future<Diary?> queryById(int id) async {
    List<Map<String, dynamic>> maps = await _db.query(DBColumns.tableName,
        where: '${DBColumns.columnId} = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Diary().formMap(maps.first);
    }
    return null;
  }

  // 根据id删除数据
  Future<int> deleteById(int id) async {
    return await _db.delete(DBColumns.tableName,
        where: '${DBColumns.columnId} = ?', whereArgs: [id]);
  }

  // 更新数据
  Future<int> update(Diary diary) async {
    return await _db.update(DBColumns.tableName, diary.toMap(),
        where: '${DBColumns.columnId} = ?', whereArgs: [diary.id]);
  }

  // 关闭数据库
  Future<void> close() async {
    if (_db.isOpen) {
      await _db.close();
    }
  }
}

// 定义一个Diary数据模型

class Diary {
  late int id;
  late String title;
  late String image;
  late String content;
  late bool textRightToLeft;
  late Map weather;
  late Map emotion;
  late DateTime date;

  Diary();

  // 将Diary对象转换为Map对象
  Map<String, Object?> toMap() {
    return <String, Object?>{
      DBColumns.columnId: id,
      DBColumns.columnTitle: title,
      DBColumns.columnImage: image,
      DBColumns.columnContent: content,
      DBColumns.columnTextRightToLeft: textRightToLeft ? 1 : 0,
      DBColumns.columnWeather: weather,
      DBColumns.columnEmotion: emotion,
      DBColumns.columnDate: date.toString(),
    };
  }

  // 将Map对象转换为Diary对象
   Diary formMap(Map<String, Object?> map) {
    return Diary()
      ..id = map[DBColumns.columnId] as int
      ..title = map[DBColumns.columnTitle] as String
      ..image = map[DBColumns.columnImage] as String
      ..content = map[DBColumns.columnContent] as String
      ..textRightToLeft = map[DBColumns.columnTextRightToLeft] == 1
      ..weather = map[DBColumns.columnWeather] as Map
      ..emotion = map[DBColumns.columnEmotion] as Map
      ..date = DateTime.parse(map[DBColumns.columnDate] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      DBColumns.columnId: id,
      DBColumns.columnTitle: title,
      DBColumns.columnImage: image,
      DBColumns.columnContent: content,
      DBColumns.columnTextRightToLeft: textRightToLeft ? 1 : 0,
      DBColumns.columnWeather: weather,
      DBColumns.columnEmotion: emotion,
      DBColumns.columnDate: date.toString(),
    };
  }

  Map<String, dynamic> fromJson(Map<String, Object?> map) {
    return {
      "id": map[DBColumns.columnId] as int,
      "title": map[DBColumns.columnTitle] as String,
      "image": map[DBColumns.columnImage] as String,
      "content": map[DBColumns.columnContent] as String,
      "textRightToLeft": map[DBColumns.columnTextRightToLeft] == 1,
      "weather": map[DBColumns.columnWeather] as Map,
      "emotion": map[DBColumns.columnEmotion] as Map,
      "date": DateTime.parse(map[DBColumns.columnDate] as String),
    };
  }
}
