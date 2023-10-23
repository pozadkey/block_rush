import 'dart:async';
import 'dart:math';
import 'package:block_rush/components/piece.dart';
import 'package:block_rush/components/pixel.dart';
import 'package:block_rush/values.dart';
import 'package:flutter/material.dart';

/*

GAME BOARD

This is a  2x2 grid with null representing an empty space
A non empty sace will have the color represent the landed pieces

*/

List<List<Blockis?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Current board piece
  Piece currentPiece = Piece(type: Blockis.L);

  @override
  void initState() {
    super.initState();

    // Start game
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // Frame refresh rate
    Duration frameRate = const Duration(milliseconds: 300);
    gameLoop(frameRate);
  }

  // Game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // Check landing
        checkLanding();
        // Move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

// Check for collison (Make the game land)
  bool checkCollision(Direction direction) {
    // Check for the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // Calculate the row and column of the current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // Adjust row  and column based on direction
      if (direction == Direction.left) {
        col--;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.down) {
        row++;
      }

      if (col < 0 || col >= rowLength || row >= colLength) {
        return true;
      }
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    // If not collision, return false
    return false;
  }

  void checkLanding() {
    // Check if position below is occupied
    if (checkCollision(Direction.down)) {
      // Mark position as occupied
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // Once piece is landed
      createNewPiece();
    }
  }

// Create new  piece
  void createNewPiece() {
    // Create a random object to generate random piceces
    Random randomPiece = Random();

    // Create new piece with new type
    Blockis randomType =
        Blockis.values[randomPiece.nextInt(Blockis.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rowLength * colLength,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  // Get row and column of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
          
                  // Current  piece
                  if (currentPiece.position.contains(index)) {
                    return Pixel(color: currentPiece.color, child: index);
                    //return const Pixel(color: Colors.yellow, child: '');
                  }
          
                  // Landed pieces
                  else if (gameBoard[row][col] != null) {
                    final Blockis? blockisType = gameBoard[row][col];
                    return Pixel(color: blockisColors[blockisType], child: ' ');
                    //return const Pixel(color: Colors.pink, child: '');
                  }
          
                  // Blank pixek
                  else {
                    return Pixel(color: Colors.grey[900], child: index);
                  }
                }),
          ),

         
        ],
      ),
    );
  }
}
