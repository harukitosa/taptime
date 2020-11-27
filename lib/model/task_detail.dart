import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

class TaskDetail {
  TaskDetail({
    this.id,
    this.content,
    this.createTime,
    this.color,
    this.typeContent,
  });

  final int id;
  final String content;
  final String createTime;
  final String color;
  final String typeContent;

  String date() {
    initializeDateFormatting("ja_JP");
    final formatter = new DateFormat('HH:mm', "ja_JP");
    DateTime datetime = DateTime.parse(createTime);
    final date = formatter.format(datetime);
    return date;
  }

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
}
