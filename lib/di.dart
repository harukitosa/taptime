import 'package:taptime/infra/sqflite/task.dart';
import 'package:taptime/infra/sqflite/type.dart';
import 'package:taptime/usecase/task_usecase.dart';
import 'package:taptime/infra/sqflite/connect_db.dart';
import 'package:taptime/usecase/type_usecase.dart';

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
