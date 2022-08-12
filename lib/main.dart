import 'package:flutter/material.dart';
import 'package:news_app/src/presentation/presentation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEWS APP',
      home: ListNewsScreen(),
    );
  }
}
