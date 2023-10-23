import 'package:block_rush/values.dart';
import 'package:flutter/material.dart';

class Piece {
  // Type of Block piece
  Blockis type;

  Piece({required this.type});

  // List of piece integers
  List<int> position = [];

  // Color of Block Rush piece
  Color get color {
    return blockisColors[type] ?? Colors.white;
  }

  // Generate the integers
  void initializePiece() {
    switch (type) {
      case Blockis.L:
        position = [-26, -16, -6, -5];
        break;
      case Blockis.J:
        position = [-25, -15, -5, -6];
        break;
      case Blockis.I:
        position = [-4, -5, -6, - 7];
        break;
      case Blockis.O:
        position = [-15, -16, -5, -6];
        break;
      case Blockis.S:
        position = [-15, -14, -6, -5];
        break;
      case Blockis.Z:
        position = [-17, -16, -6, -5];
        break;
      case Blockis.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  // Move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }
}
