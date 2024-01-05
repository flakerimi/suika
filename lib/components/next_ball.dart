import 'package:flutter/material.dart';

class NextBall extends StatelessWidget {
  const NextBall({super.key});

  @override
  Widget build(BuildContext context) {
    Color nextBallColor = Colors.red; // Replace with your logic
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: nextBallColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}
