import 'package:TimeTap/repository/type_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:TimeTap/model/type.dart';

ITypeRepository newtypeRepository(Database db) {
  return TypeRepository(db);
}

class TypeRepository extends ITypeRepository {
  TypeRepository(this.db);
  final Database db;
  @override
  Future<int> create(TypeData type) {
    final id = db.insert(
      'type',
      type.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<void> update(TypeData type) {
    final args = [type.id];
    return db.update(
      'type',
      type.toMap(),
      where: 'id = ?',
      whereArgs: args,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> delete(TypeData type) {
    final args = [type.id];
    final deletetype = TypeData(
      id: type.id,
      color: type.color,
      content: type.content,
      createTime: type.createTime,
      updateTime: type.updateTime,
      delete: 'true',
    );

    return db.update(
      'type',
      deletetype.toMap(),
      where: 'id = ?',
      whereArgs: args,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<List<TypeData>> getAll() async {
    List<Map<String, dynamic>> res;
    const arg = ['false'];
    res = await db.query(
      'type',
      where: 'delete_flag = ?',
      whereArgs: arg,
    );
    return res.map((c) => TypeData.fromMap(c)).toList();
  }
}
