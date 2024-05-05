import 'dart:io';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int turn = 0;
  List<String?> gridValues = List.filled(9, null);

  void check() {
    if (gridValues[0] != null &&
        (gridValues[0] == gridValues[1] && gridValues[0] == gridValues[2] ||
            gridValues[0] == gridValues[3] && gridValues[0] == gridValues[6] ||
            gridValues[0] == gridValues[4] && gridValues[0] == gridValues[8])) {
      showWinnerDialog(gridValues[0]!);
    } else if (gridValues[1] != null &&
        (gridValues[1] == gridValues[4] && gridValues[1] == gridValues[7])) {
      showWinnerDialog(gridValues[1]!);
    } else if (gridValues[2] != null &&
        (gridValues[2] == gridValues[4] && gridValues[2] == gridValues[6] ||
            gridValues[2] == gridValues[5] && gridValues[2] == gridValues[8])) {
      showWinnerDialog(gridValues[2]!);
    } else if (gridValues[3] != null &&
        (gridValues[3] == gridValues[4] && gridValues[3] == gridValues[5])) {
      showWinnerDialog(gridValues[3]!);
    } else if (gridValues[6] != null &&
        (gridValues[6] == gridValues[7] && gridValues[6] == gridValues[8])) {
      showWinnerDialog(gridValues[6]!);
    } else if (turn == 9) {
      showDrawDialog();
    }
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('Player $winner won!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  turn = 0;
                  gridValues = List.filled(9, null);
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Draw!'),
          content: const Text('It\'s a draw!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  turn = 0;
                  gridValues = List.filled(9, null);
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Player one : O ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Player two : X ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (gridValues[index] == null) {
                setState(() {
                  if (turn % 2 == 0) {
                    gridValues[index] = 'O';
                  } else {
                    gridValues[index] = 'X';
                  }
                  turn++;
                  check(); // Call check after each move
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: Text(
                    gridValues[index] ?? '',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color:
                          gridValues[index] == 'X' ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  exit(0);
                },
                child: const Text("Exit")),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    turn = 0;
                    gridValues = List.filled(9, null);
                  });
                },
                child: const Text("Restart"))
          ],
        ),
      ],
    );
  }
}
