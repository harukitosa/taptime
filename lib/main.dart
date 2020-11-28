import 'package:flutter/material.dart';
import 'package:sagyoou/page/Calendar.dart';
import 'package:sagyoou/page/Home.dart';
import 'package:sagyoou/page/Setting.dart';

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
      title: 'Sagyoou',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/setting': (context) => SettingPage(),
      },
    );
  }
}
