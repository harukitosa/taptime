class Type {
  Type({
    this.id,
    this.color,
    this.content,
    this.createTime,
    this.updateTime,
    this.delete,
  });

  final int id;
  final String content;
  final String color;
  final String createTime;
  final String updateTime;
  final String delete;

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        id: json['id'] as int,
        color: json['color'] as String,
        content: json['content'] as String,
        delete: json['delete_flag'] as String,
        createTime: json['created_at'] as String,
        updateTime: json['updated_at'] as String,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'content': content,
      'color': color,
      'created_at': createTime,
      'updated_at': updateTime,
      'delete_flag': delete,
    };
    return map;
  }
}
