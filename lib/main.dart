import 'package:flutter/material.dart';
import 'package:last_prvoder/pages/home.dart';
import 'package:last_prvoder/pages/update_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {UpdatePage.Route_name: (context) => UpdatePage()},
    );
  }
}
