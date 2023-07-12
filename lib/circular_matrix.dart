import 'package:flutter/material.dart';
/// 5
class CircularMatrixScreen extends StatefulWidget {
  @override
  _CircularMatrixScreenState createState() => _CircularMatrixScreenState();
}

class _CircularMatrixScreenState extends State<CircularMatrixScreen> {
  List<List<int>> matrix = [];
  int rows = 0;
  int columns = 0;

  void generateMatrix() {
    matrix = List.generate(rows, (_) => List<int>.filled(columns, 0));

    int num = 1;
    int top = 0;
    int bottom = rows - 1;
    int left = 0;
    int right = columns - 1;

    while (top <= bottom && left <= right) {
      for (int i = left; i <= right; i++) {
        matrix[top][i] = num++;
      }
      top++;

      for (int i = top; i <= bottom; i++) {
        matrix[i][right] = num++;
      }
      right--;

      if (top <= bottom) {
        for (int i = right; i >= left; i--) {
          matrix[bottom][i] = num++;
        }
        bottom--;
      }

      if (left <= right) {
        for (int i = bottom; i >= top; i--) {
          matrix[i][left] = num++;
        }
        left++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Matrix'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the number of rows:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      rows = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter the number of columns:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      columns = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  generateMatrix();
                  setState(() {});
                },
                child: const Text('Display'),
              ),
              const SizedBox(height: 16),
              if (matrix.isNotEmpty)
                Table(
                  border: TableBorder.all(),
                  defaultColumnWidth: const FixedColumnWidth(48.0),
                  children: matrix.map((row) {
                    return TableRow(
                      children: row.map((number) {
                        return TableCell(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              number.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
