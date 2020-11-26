import 'package:sagyoou/repository/type_repository.dart';
import 'package:sagyoou/model/type.dart';

class TypeUseCase {
  TypeUseCase({this.typeRepository});
  final ITypeRepository typeRepository;

  Future<List<Type>> getAllType() async {
    return typeRepository.getAll();
  }
}
