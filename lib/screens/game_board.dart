import 'dart:async';
import 'dart:math';
import 'package:block_rush/components/icon_button.dart';
import 'package:block_rush/components/piece.dart';
import 'package:block_rush/components/pixel.dart';
import 'package:block_rush/responsive/responsive.dart';
import 'package:block_rush/screens/home_screen.dart';
import 'package:block_rush/constants/values.dart';
import 'package:flutter/material.dart';

/*

GAME BOARD

This is a  2x2 grid with null representing an empty space
A non empty sace will have the color represent the landed pieces

*/

List<List<Blockis?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({
    super.key,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Textstyles
  // Gameover message
  final gameOverHeaderText = TextStyle(
      color: Colors.red[800],
      fontSize: 40,
      fontWeight: FontWeight.w800,
      fontFamily: 'ClashDisplay',
      letterSpacing: 0.5);

  // Game Paused message
  final gamePausedHeaderText = const TextStyle(
      color: Color.fromARGB(255, 255, 231, 13),
      fontSize: 40,
      fontFamily: 'ClashDisplay',
      letterSpacing: 0.5,
      fontWeight: FontWeight.w800);

  final difficultyLevelHeaderText = const TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 20,
    fontFamily: 'ClashDisplay',
    fontWeight: FontWeight.w600,
  );

  // Score Text
  final scoreText = const TextStyle(
      color: Colors.yellowAccent,
      fontSize: 64,
      fontFamily: 'ClashDisplay',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5);

  // Difficulty level  Text
  final difficultyLevelText = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'ClashDisplay',
      letterSpacing: 0.2);

  // Current board piece
  Piece currentPiece = Piece(type: Blockis.L);

  // Current Score
  int currentScore = 0;

  // Game over status
  bool gameOver = false;

  // Game speed to determine difficulty level
  int gameSpeed = 500;

  // Active Game difficulty selection color
  Color difficultyLevel = Colors.purpleAccent;

  // Create a random number generator
  Random random = Random();

  @override
  void initState() {
    super.initState();

    // Start game
    startGame();
  }

  StreamSubscription<int>? gameSubscription;
  bool isPaused = false;

  void startGame() {
    currentPiece.initializePiece();

    // Frame refresh rate
    Duration frameRate = Duration(milliseconds: gameSpeed);
    gameSubscription = gameLoop(frameRate);
  }

  StreamSubscription<int> gameLoop(Duration frameRate) {
    return Stream<int>.periodic(frameRate, (count) => count)
        .takeWhile((_) => !gameOver)
        .listen((_) {
      if (gameOver) {
        gameSubscription?.cancel();
        gameOverDialog();
      } else if (!isPaused) {
        setState(() {
          // Clear lines
          clearLines();

          // Check landing
          checkLanding();

          // Move current piece down
          currentPiece.movePiece(Direction.down);
        });
      }
    });
  }

// Pause game
  void pauseGame() {
    if (isPaused) {
      // Resume the game
      isPaused = false;
    } else {
      // Pause the game
      isPaused = true;
    }
  }

  //Resume game

  void resumeGame() {
    pauseGame();
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

// Check if pieces have collided
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

    // Check if  game over when new piece is crated
    if (isGameOver()) {
      gameOver = true;
      gameOverDialog();
    }
  }

  // Move left
  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // Move right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // Rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

// Clear lines
  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  // Game  Over
  bool isGameOver() {
    // Check if any of the top column if filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  // Reset game
  void resetGame() {
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));
    gameOver = false;
    currentScore = 0;

    // Create new piece
    createNewPiece();

    // Restart game
    gameSubscription?.cancel();
    isPaused = false;
    startGame();
  }

// Show paused game message
  void showPausedGame() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Responsive(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            height: 450,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 41, 41, 41),
                width: 3,
              ),
              color: const Color.fromARGB(255, 22, 22, 22),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    'PAUSED',
                    style: gamePausedHeaderText,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyIconButton(
                  onTap: () {
                    pauseGame();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                  ),
                  buttonWidth: 200,
                  bgdColor: const Color(0xFF66BB6A),
                  iconSize: 40,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyIconButton(
                        bgdColor: const Color(0xFFE86060),
                        iconSize: 25,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.home),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      MyIconButton(
                        onTap: () {
                          resetGame();
                          Navigator.pop(context);
                        },
                        bgdColor: const Color(0xFFFFD166),
                        icon: const Icon(Icons.restart_alt_rounded),
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Color.fromARGB(255, 192, 192, 192),
                  thickness: 1.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                FittedBox(
                  child: Text(
                    'DIFFICULTY  LEVEL:',
                    style: difficultyLevelHeaderText,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Easy level
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gameSpeed = 800;
                          });
                          pauseGame();
                          resetGame();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: gameSpeed == 800
                                ? difficultyLevel
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Easy',
                            style: difficultyLevelText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),

                      // Nomal level
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gameSpeed = 500;
                          });
                          pauseGame();
                          resetGame();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: gameSpeed == 500
                                ? difficultyLevel
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Normal',
                            style: difficultyLevelText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),

                      // Hard level
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gameSpeed = 200;
                          });
                          pauseGame();
                          resetGame();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: gameSpeed == 200
                                ? difficultyLevel
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text('Hard', style: difficultyLevelText),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Game over message
  void gameOverDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Responsive(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 41, 41, 41), // Slightly lighter border color
                      width: 3,
                    ),
                    color: const Color.fromARGB(
                        255, 22, 22, 22), // Dialog background color
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            'GAME OVER',
                            style: gameOverHeaderText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Text(
                            '${currentScore * 5}'.toString(),
                            style: scoreText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyIconButton(
                                bgdColor: const Color(0xFFE86060),
                                onTap: () {
                                  pauseGame();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                },
                                icon: const Icon(Icons.home),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              // resetGame
                              MyIconButton(
                                onTap: () {
                                  resetGame();
                                  Navigator.pop(context);
                                },
                                bgdColor: const Color(0xFFFFD166),
                                icon: const Icon(Icons.restart_alt_rounded),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 0.56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Bar with Home Button, Score, and Pause Button
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Home Button
                        MyIconButton(
                          onTap: () async {
                            pauseGame();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          icon: const Icon(Icons.home),
                          bgdColor: Colors.purple[300],
                        ),

                        // Score Display
                        Text(
                          ' ${currentScore * 5}'.toString(),
                          style: const TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 40,
                              fontFamily: 'ClashDisplay',
                              fontWeight: FontWeight.bold),
                        ),

                        // Pause Button
                        MyIconButton(
                          onTap: () {
                            pauseGame();
                            showPausedGame();
                          },
                          icon: const Icon(Icons.pause),
                          bgdColor: const Color(0xFFFFD166),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Game Grid
                Responsive(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rowLength * colLength,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength, // Adjust for responsiveness
                    ),
                    itemBuilder: (context, index) {
                      int row = (index / rowLength).floor();
                      int col = index % rowLength;
                      if (currentPiece.position.contains(index)) {
                        return Pixel(
                          color: currentPiece.color,
                        );
                      } else if (gameBoard[row][col] != null) {
                        final Blockis? blockisType = gameBoard[row][col];
                        return Pixel(
                          color: blockisColors[blockisType],
                        );
                      } else {
                        return Pixel(
                          color: Colors.grey[900],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Game Controls
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Button to move the piece to the left
                        MyIconButton(
                          onTap: moveLeft,
                          icon: const Icon(Icons.arrow_back_ios),
                          bgdColor: const Color(0xFF65AFFF),
                          iconColor: Colors.white,
                        ),

                        // Button to rotate the piece
                        MyIconButton(
                          onTap: rotatePiece,
                          icon: const Icon(Icons.rotate_right_rounded),
                          bgdColor: const Color(0xFFFF6B6B),
                          iconColor: Colors.white,
                        ),

                        // Button to move the piece to the right
                        MyIconButton(
                          onTap: moveRight,
                          icon: const Icon(Icons.arrow_forward_ios),
                          bgdColor: const Color(0xFF65AFFF),
                          iconColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
