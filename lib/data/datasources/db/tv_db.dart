import 'package:sqflite/sqflite.dart';
import 'package:ditonton/data/models/tv_tbl.dart';

class TvDb{
  static TvDb? _tvDb;
  TvDb._instance(){
    _tvDb = this;
  }
  
  factory TvDb() =>
  _tvDb ??
  TvDb._instance();

  static Database? _database;

  Future<Database?> get database async{
    if (_database == null){
      _database = await _initDb();
    }
    return _database;
  }

  static const String _Tvlist = 'TvList';

  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = '$path/tv.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE  $_Tvlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(Tvku tv) async{
    final db = await database;
    return await db!.insert(_Tvlist, tv.toJson());
  }

  Future<int> removeWatchlist(Tvku tv) async {
    final db = await database;
    return await db!.delete(
      _Tvlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _Tvlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_Tvlist);

    return results;
  }
}
