import 'package:sagyoou/infra/sqflite/task.dart';
import 'package:sagyoou/infra/sqflite/type.dart';
import 'package:sagyoou/usecase/get_task_by_day.dart';
import 'package:sagyoou/usecase/task_usecase.dart';
import 'package:sagyoou/infra/sqflite/connect_db.dart';
import 'package:sagyoou/usecase/type_usecase.dart';

Future<TaskUseCase> initTask() async {
  final db = await DBManager.instance.initDB();
  final _taskRepository = TaskRepository(db);
  final _taskUsecase = TaskUseCase(repository: _taskRepository);
  return _taskUsecase;
}

Future<TypeUseCase> initType() async {
  final db = await DBManager.instance.initDB();
  final _typeRepository = TypeRepository(db);
  final _typeUsecase = TypeUseCase(typeRepository: _typeRepository);
  return _typeUsecase;
}

Future<TaskDetailUseCase> initTaskDetail() async {
  final db = await DBManager.instance.initDB();
  final _typeRepository = TypeRepository(db);
  final _taskRepository = TaskRepository(db);
  final _taskDetailUsecase = TaskDetailUseCase(
    taskRepository: _taskRepository,
    typeRepository: _typeRepository,
  );
  return _taskDetailUsecase;
}
