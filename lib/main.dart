import 'package:flutter/material.dart';
import 'package:taptime/page/Calendar.dart';
import 'package:taptime/page/Home.dart';
import 'package:taptime/page/Setting.dart';
import 'package:taptime/page/TaskDetail.dart';

/// TapTime 玄人むけの時間管理アプリ
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'taptime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/setting': (context) => SettingPage(),
        '/taskdetail': (context) => TaskDetailPage(),
      },
    );
  }
}
