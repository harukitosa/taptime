class Task {
  Task({
    this.id,
    this.content,
    this.createTime,
    this.updateTime,
    this.delete,
    this.typeID,
  });

  final int id;
  final String content;
  final String createTime;
  final String updateTime;
  final String delete;
  final int typeID;

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'] as int,
        content: json['content'] as String,
        delete: json['delete_flag'] as String,
        typeID: json['type_id'] as int,
        createTime: json['created_at'] as String,
        updateTime: json['updated_at'] as String,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'type_id': typeID,
      'content': content,
      'created_at': createTime,
      'updated_at': updateTime,
      'delete_flag': delete,
    };
    return map;
  }
}
