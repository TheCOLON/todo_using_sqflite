import 'package:flutter/material.dart';
import 'package:todo_written_exam/homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter UI',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Homepage(),
  ));
}
