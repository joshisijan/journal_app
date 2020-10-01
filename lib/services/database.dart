import 'package:journal_app/model/event_model.dart';
import 'package:journal_app/providers/story_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  Database _db;
  bool _initialized = false;

  _createTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE events(id INTEGER PRIMARY KEY, year INTEGER, month INTEGER, day INTEGER, hour INTEGER, minute INTEGER, description TEXT)");
    await db.execute(
        "CREATE TABLE image(id INTEGER PRIMARY KEY, year INTEGER, month INTEGER, day INTEGER, path TEXT)");
  }

  _openDatabase() async {
    var dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'app_database.db'),
      onCreate: (db, version) {
        return _createTable(db, version);
      },
      version: 1,
    ).whenComplete(() => _initialized = true);
  }

  Future<Database> _openDb() async {
    if (!_initialized) await _openDatabase();
    return _db;
  }

  Map<String, dynamic> toMap(EventModel eventModel) {
    return {
      'year': eventModel.year,
      'month': eventModel.month,
      'day': eventModel.day,
      'hour': eventModel.hour,
      'minute': eventModel.minute,
      'description': eventModel.description,
    };
  }

  insertEvent(EventModel eventModel) async {
    try{
      Database db = await _openDb();
      var row = await db.query('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}');
      if(row.length <= 0){
        await db.insert('image', {
          'year': DateTime.now().year,
          'month': DateTime.now().month,
          'day': DateTime.now().day,
          'path': '',
        });
        await StoryProvider().setStories();
      }
      await db.insert('events', toMap(eventModel),conflictAlgorithm: ConflictAlgorithm.replace,);
    }catch(e){
      print('error from insert event from database\n' + e.toString());
    }
  }

  //get total event till now
  Future<int> getTodayEventsTotal() async {
    Database db = await _openDb();
    return await db.query('events').then((value) => value.length);
  }

  Future<List<EventModel>> getTodayEvents(int limit, int page) async {
    try{
      Database db = await _openDb();
      int offset = (page - 1) * limit;
      List<Map<String, dynamic>> map = await db.query('events',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}', orderBy: '-id', limit: limit, offset: offset);
      return List.generate(map.length, (i) {
        return EventModel(
          id: map[i]['id'],
          year: map[i]['year'],
          month: map[i]['month'],
          day: map[i]['day'],
          hour: map[i]['hour'],
          minute: map[i]['minute'],
          description: map[i]['description'],
        );
      });
    }catch(e){
      print('error from get event from database\n' + e.toString());
    }
  }

  removeTodayImage() async {
    try{
      Database db = await _openDb();
      var row = await db.query('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}');
      if(row.length > 0){
        await db.delete('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}');
      }
    }catch(e){
      print('error from remove image path\n' + e.toString());
    }
  }

  insertTodayImage(String path) async {
    try{
      Database db = await _openDb();
      var row = await db.query('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}');
      if(row.length > 0){
        await db.delete('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}');
      }
      db.insert('image', {
        'year': DateTime.now().year,
        'month': DateTime.now().month,
        'day': DateTime.now().day,
        'path': path,
      });
    }catch(e){
      print('error from insert image path\n' + e.toString());
    }
  }

  Future<String> getTodayImage() async {
    try{
      Database db = await _openDb();
      List<Map<String, dynamic>> map = await db.query('image',where: 'year = ${DateTime.now().year} AND month = ${DateTime.now().month} AND day = ${DateTime.now().day}', limit: 1);
      return map[0]['path'];
    }catch(e){
      print('error from get image path\n' + e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAllImages() async {
    try{
      Database db = await _openDb();
      List<Map<String, dynamic>> map = await db.query('image');
      return map;
    }catch(e){
      print('error from get image path\n' + e.toString());
    }
  }

}
