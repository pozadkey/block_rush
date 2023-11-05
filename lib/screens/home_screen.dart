import 'package:flutter/material.dart';
import 'package:block_rush/components/button.dart';
import 'package:block_rush/screens/game_board.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Background Image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Center(
                child: AspectRatio(
                  aspectRatio: 0.56,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Image
                      Hero(
                        tag: 'logoTag', // Unique tag for the Hero widget
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 500,
                        ),
                      ),
                      Text(
                        'BLOCK RUSH',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 40),
                      buildGameButton(
                        context,
                        'START GAME',
                        100,
                        const Color.fromARGB(255, 5, 201, 96), // Bright blue
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGameButton(
      BuildContext context, String label, int gameLevel, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Hero(
        tag: 'startButtonTag', // Unique tag for the Hero widget
        child: MyButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GameBoard(),
              ),
            );
          },
          text: label,
          bgColor: color,
          buttonWidth: 200,
          padding: 16.0,
          textColor: Colors.white,
          borderRadius: 10.0,
        ),
      ),
    );
  }
}
