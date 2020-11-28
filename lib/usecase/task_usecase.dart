import 'package:taptime/repository/task_repository.dart';
import 'package:taptime/model/task.dart';

class TaskUseCase {
  TaskUseCase({this.repository});
  final ITaskRepository repository;

  Future<List<Task>> getAllTask() {
    return repository.getAll();
  }

  Future<int> createTask(String content, int typeID) {
    return repository.create(
      Task(content: content, typeID: typeID, delete: "false"),
    );
  }

  Future<List<Task>> getSpan(DateTime day) async {
    return repository.getSpan(day);
  }

  Future<Task> getTaskByID(int id) async {
    return repository.getByID(id);
  }

  Future<void> delete(Task task) async {
    return repository.delete(task);
  }

  Future<void> update(
    Task task,
    String content,
    int typeID,
  ) async {
    return repository.update(
      Task(
        id: task.id,
        content: content,
        createTime: task.createTime,
        updateTime: task.updateTime,
        delete: task.delete,
        typeID: typeID,
      ),
    );
  }
}
