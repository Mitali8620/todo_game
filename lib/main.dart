import 'package:flutter/material.dart';
import 'package:todo_game/timer.dart';

void main() => runApp(MatrixApp());

class MatrixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Matrix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen1(),
    );
  }
}
