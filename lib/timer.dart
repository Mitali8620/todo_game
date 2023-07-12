import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController numRowsController = TextEditingController();
  final TextEditingController minValueController = TextEditingController();
  final TextEditingController maxValueController = TextEditingController();

  @override
  void dispose() {
    numRowsController.dispose();
    minValueController.dispose();
    maxValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the number of rows:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            TextField(
              controller: numRowsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter the minimum value:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            TextField(
              controller: minValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter the maximum value:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            TextField(
              controller: maxValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                int numRows = int.tryParse(numRowsController.text) ?? 0;
                int minValue = int.tryParse(minValueController.text) ?? 0;
                int maxValue = int.tryParse(maxValueController.text) ?? 0;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen2(
                      numRows: numRows,
                      minValue: minValue,
                      maxValue: maxValue,
                    ),
                  ),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  final int numRows;
  final int minValue;
  final int maxValue;

  Screen2(
      {required this.numRows, required this.minValue, required this.maxValue});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<int> countdownValues = [];
  List<Color> rowColors = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    countdownValues =
        List.generate(widget.numRows, (index) => widget.maxValue - index);
    rowColors = List.generate(widget.numRows, (_) => Colors.white);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int randomIndex = Random().nextInt(widget.numRows);
      List<Color> updatedRowColors = List.from(rowColors);
      updatedRowColors[randomIndex] = Colors.green;

      setState(() {
        rowColors = updatedRowColors;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: ListView.builder(
        itemCount: widget.numRows,
        itemBuilder: (context, index) {
          return Container(
            color: rowColors[index],
            padding: EdgeInsets.all(16.0),
            child: Text(
              countdownValues[index].toString(),
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
