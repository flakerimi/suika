import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suika/game/logic.dart';

class NextBall extends StatelessWidget {
  const NextBall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the current ball color
        const Text(
          'Current ball:',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Obx(() {
          return Container(
            margin: const EdgeInsets.all(4),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: GameLogic.currentBallColor.value,
              shape: BoxShape.circle,
            ),
          );
        }),
        // Display the next ball color
        const Text(
          'Next',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Obx(() {
          return Container(
            margin: const EdgeInsets.all(4),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: GameLogic.nextBallColor.value,
              shape: BoxShape.circle,
            ),
          );
        }),
      ],
    );
  }
}
