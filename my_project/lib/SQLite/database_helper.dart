import 'package:my_project/JSON/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = 'auth.db';

  String user = '''
    CREATE TABLE users ( 
    usrId INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    usrName TEXT UNIQUE,
    usrPassword TEXT
    )
    ''';

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
    });
  }

  Future<bool> authenticate(Users usr) async {
    final Database db = await initDb();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' AND usrPassword = '${usr.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> createUser(Users usr) async {
    final Database db = await initDb();
    return db.insert('users', usr.toMap());
  }

  Future<Users?> getUser(String usrName) async {
    final Database db = await initDb();
    var res =
        await db.query('users', where: 'usrName = ?', whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<String?> getUserByUsername(String usrName) async {
    final Database db = await initDb();
    final List<Map<String, dynamic>> res = await db.query(
      'users', // Назва таблиці
      where: 'usrName = ?', // Умова для пошуку за usrName
      whereArgs: [usrName], // Параметри для захисту від SQL-ін'єкцій
      limit: 1, // Обмеження результатів до одного запису
    );

    if (res.isNotEmpty) {
      return res.first['usrName'] as String;
    }
    return null;
  }
}
