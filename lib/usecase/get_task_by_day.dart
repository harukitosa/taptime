import 'package:sagyoou/model/task_detail.dart';
import 'package:sagyoou/repository/task_repository.dart';
import 'package:sagyoou/repository/type_repository.dart';

class TaskDetailUseCase {
  TaskDetailUseCase({this.taskRepository, this.typeRepository});
  final ITaskRepository taskRepository;
  final ITypeRepository typeRepository;

  // List<TaskDetail> getBySpan(DateTime day) async {
  //   List<TaskDetail> result = [];
  //   // DB側で統合しろof the year
  //   final list = await taskRepository.getSpan(day);
  //   final typeList = await typeRepository.getAll();
  //   for (final item in list) {
  //     print(item);
  //     for (final type in typeList) {
  //         result.add(
  //           TaskDetail(
  //             id: item.id,
  //             content: item.content,
  //             createTime: item.createTime,
  //             color: type.color,
  //             typeContent: type.content,
  //           ),
  //         );
  //         continue;
  //       }
  //     }
  //   }
  //   return result;
  // }
}
