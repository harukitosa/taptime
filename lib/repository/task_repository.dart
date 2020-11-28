import 'dart:async';

import 'package:taptime/model/task.dart';

abstract class ITaskRepository {
  Future<int> create(Task task);
  Future<void> update(Task task);
  Future<void> delete(Task task);
  Future<List<Task>> getAll();
  Future<List<Task>> getSpan(DateTime day);
  Future<Task> getByID(int id);
}
