import 'dart:async';

import 'package:sagyoou/model/type.dart';

abstract class ITypeRepository {
  Future<int> create(Type task);
  Future<void> update(Type task);
  Future<void> delete(Type task);
  Future<List<Type>> getAll();
}
