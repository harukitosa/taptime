import 'package:sagyoou/repository/task_repository.dart';
import 'package:sagyoou/model/task.dart';

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
}
