import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GameOver extends StatelessWidget {
  final int score;
  final int bestScore;
  final VoidCallback onRestart;

  const GameOver({super.key, required this.score, required this.bestScore, required this.onRestart});

  @override
  Widget build(BuildContext context) {
         var bestScore = GetStorage().read('bestScore') ?? 0.obs;

     return Scaffold(
       body: Center(
         child: Container(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Score: $score',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Best Score: $bestScore',
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 50.0),
              GestureDetector(
                onTap: onRestart,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
             ),
       ),
     );
  }
}