import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suika/components/next_ball.dart';
import 'package:suika/game/logic.dart';
import 'package:suika/game/suika_game.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);
   

  @override
  Widget build(BuildContext context) {
    RxInt score = GameLogic.score;  
    return Scaffold(
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

            const Positioned(
              top: 10,
              left: 10,
              child:  Text(
                    'Lisa`s \nSuika',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  )
            ),

            Positioned(
              top: // bottom of the screen
                  MediaQuery.of(context).size.height - 50,
              left: 10,
              child: Obx(() => Text(
                    'Score: $score',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),

            // Score text
          ],
        ),
      );
  }
}