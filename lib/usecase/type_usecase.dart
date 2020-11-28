import 'package:taptime/repository/type_repository.dart';
import 'package:taptime/model/type.dart';

class TypeUseCase {
  TypeUseCase({this.typeRepository});
  final ITypeRepository typeRepository;

  Future<List<TypeData>> getAllType() async {
    return typeRepository.getAll();
  }
}
