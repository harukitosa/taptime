import 'package:TimeTap/repository/type_repository.dart';
import 'package:TimeTap/model/type.dart';

class TypeUseCase {
  TypeUseCase({this.typeRepository});
  final ITypeRepository typeRepository;

  Future<List<TypeData>> getAllType() async {
    return typeRepository.getAll();
  }

  Future<void> save(List<TypeData> list) async {
    for (int i = 0; i < list.length; i++) {
      await typeRepository.update(list[i]);
    }
  }
}
