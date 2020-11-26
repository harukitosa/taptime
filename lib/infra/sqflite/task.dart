import 'package:sagyoou/repository/task_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sagyoou/model/task.dart';

ITaskRepository newTaskRepository(Database db) {
  return TaskRepository(db);
}

class TaskRepository extends ITaskRepository {
  TaskRepository(this.db);
  final Database db;
  @override
  Future<int> create(Task task) {
    final id = db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<void> update(Task task) {
    final args = [task.id];
    return db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: args,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> delete(Task task) {
    final args = [task.id];
    final deleteTask = Task(
      id: task.id,
      content: task.content,
      createTime: task.createTime,
      updateTime: task.updateTime,
      typeID: task.typeID,
      delete: 'true',
    );

    return db.update(
      'task',
      deleteTask.toMap(),
      where: 'id = ?',
      whereArgs: args,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<List<Task>> getAll() async {
    List<Map<String, dynamic>> res;
    const arg = ['false'];
    res = await db.query(
      'task',
      where: 'delete_flag = ?',
      whereArgs: arg,
    );
    return res.map((c) => Task.fromMap(c)).toList();
  }
}
