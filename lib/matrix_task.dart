import 'package:flutter/material.dart';

///4
class MatrixTaskScreen extends StatefulWidget {
  @override
  _MatrixTaskScreenState createState() => _MatrixTaskScreenState();
}

class _MatrixTaskScreenState extends State<MatrixTaskScreen> {
  List<List<bool>> matrix = [];
  int size = 0;
  bool displayMatrix = false;

  void generateMatrix() {
    matrix = List.generate(size, (_) => List<bool>.filled(size, false));
    displayMatrix = true;
  }

  void fillCells(int row, int col) {
    if (matrix[row][col]) {
      return;
    }

    for (int i = 0; i < size; i++) {
      matrix[row][i] = true;
      matrix[i][col] = true;

      int rowDiff = row - i;
      int colDiff = col - i;
      if (rowDiff >= 0 && colDiff >= 0) {
        matrix[rowDiff][colDiff] = true;
      }

      rowDiff = row + i;
      colDiff = col + i;
      if (rowDiff < size && colDiff < size) {
        matrix[rowDiff][colDiff] = true;
      }

      rowDiff = row + i;
      colDiff = col - i;
      if (rowDiff < size && colDiff >= 0) {
        matrix[rowDiff][colDiff] = true;
      }

      rowDiff = row - i;
      colDiff = col + i;
      if (rowDiff >= 0 && colDiff < size) {
        matrix[rowDiff][colDiff] = true;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queen Matrix'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the size of the matrix:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      size = int.tryParse(value) ?? 0;
                      displayMatrix = false;
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
              if (displayMatrix)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size,
                  ),
                  itemBuilder: (context, index) {
                    final row = index ~/ size;
                    final col = index % size;
                    return GestureDetector(
                      onTap: () {
                        fillCells(row, col);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: matrix[row][col] ? Colors.red : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            /* "(index + 1).toString()"*/
                            "",
                            style: TextStyle(
                              fontSize: 18,
                              color: matrix[row][col]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: size * size,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
