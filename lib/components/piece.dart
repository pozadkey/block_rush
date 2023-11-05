import 'package:block_rush/screens/game_board.dart';
import 'package:block_rush/constants/values.dart';
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
        position = [-4, -5, -6, -7];
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

  // Rotate piece
  int rotationState = 1;
  void rotatePiece() {
    // New position
    List<int> newPosition = [];

    // Rotate piece based on it's types
    switch (type) {
      case Blockis.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Blockis.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Blockis.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Blockis.O:
        break;

      case Blockis.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Blockis.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Blockis.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // Check if new position is valid
            if (piecePositionIsValid(newPosition)) {
              // Update postion
              position = newPosition;
              //Update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      default:
    }
  }

  // Check if position is valid
  bool positionisValid(int position) {
    // Get row and column
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  // Check for piece position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // Return false if any postion is taken
      if (!positionisValid(pos)) {
        return false;
      }

      // Ge the column of the position
      int col = pos % rowLength;

      // Check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    // If the piece goes through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
