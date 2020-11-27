import 'package:flutter/material.dart';

class TypeData {
  TypeData({
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

  Color colorObj() {
    switch (color) {
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.teal;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  factory TypeData.fromMap(Map<String, dynamic> json) => TypeData(
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
