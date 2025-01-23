import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/application/core/utils/constants/database_constants.dart';
import 'package:todo_app/application/core/utils/constants/task_constants.dart';

class DatabaseService {
  static Database? _database;

  static final DatabaseService instance = DatabaseService._internal();

  factory DatabaseService() => instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(createTaskTableQuery);
  }
}
