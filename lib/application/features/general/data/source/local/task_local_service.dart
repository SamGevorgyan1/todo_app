import 'package:todo_app/application/core/utils/constants/task_constants.dart';
import 'package:todo_app/application/features/general/data/source/database_service.dart';

class TaskLocalService {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await _dbService.database;
    return await db.insert(taskTable, task);
  }

  Future<Map<String, dynamic>?> get(int id) async {
    final db = await _dbService.database;
    final result = await db.query(
      taskTable,
      where: '$taskColumnId = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) {
      return null;
    }
    return result.first;
  }

  Future<List<Map<String, dynamic>>> getAllTasks({bool? isActive}) async {
    final db = await _dbService.database;

    String filter = '';
    List<dynamic> filterArgs = [];

    if (isActive != null) {
      filter = '$taskColumnIsActive = ?';
      filterArgs.add(isActive ? isActiveTrue : isActiveFalse);
    }

    return await db.query(
      taskTable,
      where: filter.isNotEmpty ? filter : null,
      whereArgs: filterArgs.isNotEmpty ? filterArgs : null,
      orderBy: '$taskColumnIsActive DESC, $taskColumnCreatedAt DESC',
    );
  }

  Future<int> updateTask(Map<String, dynamic> task, String id) async {
    final db = await _dbService.database;
    task.removeWhere((key, value) => value == null);
    return await db.update(taskTable, task, where: '$taskColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await _dbService.database;
    return await db.delete(taskTable, where: '$taskColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteCompletedTasks() async {
    final db = await _dbService.database;
    return await db.delete(taskTable, where: '$taskColumnIsActive = ?', whereArgs: [isActiveTrue]);
  }
}
