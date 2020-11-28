import 'package:taptime/repository/task_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taptime/model/task.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

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

  @override
  Future<List<Task>> getSpan(DateTime day) async {
    initializeDateFormatting("ja_JP");
    final tomorrow = day.add(new Duration(days: 1));
    final formatter = new DateFormat('yyyy-MM-dd', "ja_JP");
    final start = formatter.format(day);
    final end = formatter.format(tomorrow);
    final args = [start, end, "false"];
    final res = await db.query(
      'task',
      where: '? <= created_at AND created_at <= ? AND delete_flag == ?',
      whereArgs: args,
    );
    return res.map((c) => Task.fromMap(c)).toList();
  }

  @override
  Future<Task> getByID(int id) async {
    List<Map<String, dynamic>> res;
    final arg = [id, 'false'];
    res = await db.query(
      'task',
      where: 'id = ? and delete_flag = ?',
      whereArgs: arg,
      orderBy: 'created_at DESC',
    );
    final task = res.map((c) => Task.fromMap(c)).toList();
    return task[0];
  }
}
