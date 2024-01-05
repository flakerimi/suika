import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:suika/game/logic.dart';
import 'package:suika/game/suika_game.dart';
import 'package:suika/components/next_ball.dart';

class Ui extends StatelessWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt score = GameLogic.score; // Replace with your logic

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            const GameWidget.controlled(
                gameFactory: Suika.new), // Use the Suika widget
            const Positioned(
              top: 10,
              right: 10,
              child: NextBall(),
            ),
            // Hi-score text

            Positioned(
              top: 10,
              left: 10,
              child: Obx(() => Text(
                    'Hi-score: $score',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),

            // Score text
          ],
        ),
      ),
    );
  }
}
