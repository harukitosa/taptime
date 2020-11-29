import 'package:flutter/material.dart';
import 'package:TimeTap/page/Calendar.dart';
import 'package:TimeTap/page/Home.dart';
import 'package:TimeTap/page/Setting.dart';
import 'package:TimeTap/page/TaskDetail.dart';
import 'package:TimeTap/page/TypeDataDetail.dart';

/// TimeTap 玄人むけの時間管理アプリ
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimeTap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/setting': (context) => SettingPage(),
        '/taskdetail': (context) => TaskDetailPage(),
        '/typedetails': (context) => TypeDataDetail(),
      },
    );
  }
}
