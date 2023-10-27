import 'package:flutter/material.dart';

// Grid dimensions
int rowLength = 10;
int colLength = 13;

enum Direction { left, right, down }

enum Blockis { L, J, I, O, S, Z, T }

// Piece colors
const Map<Blockis, Color> blockisColors = {
  Blockis.L: Colors.orange,
  Blockis.J: Colors.blue,
  Blockis.I: Colors.pinkAccent,
  Blockis.O: Colors.yellow,
  Blockis.S: Colors.green,
  Blockis.Z: Colors.red,
  Blockis.T: Colors.purple,
};
