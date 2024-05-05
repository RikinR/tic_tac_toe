import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue.shade300,
          appBar: AppBar(
            backgroundColor: Colors.blue.shade300,
            title: const Text(
              "TIC-TAC-TOE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          body: const Center(
            child: GameScreen(),
          ),
        ),
      ),
    ),
  );
}
