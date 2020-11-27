import 'dart:async';

import 'package:sagyoou/model/type.dart';

abstract class ITypeRepository {
  Future<int> create(TypeData task);
  Future<void> update(TypeData task);
  Future<void> delete(TypeData task);
  Future<List<TypeData>> getAll();
}
