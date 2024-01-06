import 'dart:math';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suika/components/ball.dart';

class GameLogic {
  static final List<double> _radiuses = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100,110,120];
  static RxInt score = 0.obs;
   static double currentBallRadius = 10; // Initialize with default radius
  static double nextBallRadius = 10; // Initialize with default radius for next ball
  static final Rx<Color> currentBallColor = const Color(0xFFFFFFFF).obs; // default color
  static final Rx<Color> nextBallColor = const Color(0xFFFFFFFF).obs; // default color for next ball

  static void initializeBalls() {
    determineNextBall(); // Set the initial next ball
    moveToNextBall(); // Set the initial current ball
  }

  static void determineNextBall() {
    int nextRadiusIndex = Random().nextInt(_radiuses.length);
    nextBallRadius = _radiuses[nextRadiusIndex];
    Ball ball = Ball(initialPosition: Vector2.zero(), radius: nextBallRadius);
    nextBallColor.value = ball.getColorForRadius(nextBallRadius);
  }

  static void moveToNextBall() {
    currentBallRadius = nextBallRadius;
    currentBallColor.value = nextBallColor.value;
    determineNextBall(); // Determine the new next ball
  }

  static void addBallAtPosition(Forge2DGame game, Vector2 position) {
    final ball = Ball(
      initialPosition: position,
      radius: nextBallRadius,
    );
    game.add(ball);
    moveToNextBall(); // Determine the radius for the next ball to be added
  }

  static void addNextRadiusBall(Forge2DGame game, Ball ball) {
    final index = _radiuses.indexOf(ball.radius);
    if (index < _radiuses.length - 1) {
      final nextRadius = _radiuses[index + 1];
      final newBall = Ball(
        initialPosition: ball.body.position.clone(),
        radius: nextRadius,
      );
      game.add(newBall);
    }
  }

  // update Score
  static void updateScore(Ball ball) {
    // when ball is merged, update score
    // depending on the radius of the ball merged
    // add 1 point for every 15 radius
    // e.g. 15 radius = 1 point, 30 radius = 2 points, etc.
    score.value += ball.radius ~/ 15;
  }

  // get current mouseX position

  getMouseX() {
    return 0;
  }

  // lets make top wall to end the game
  static bool isGameOver(Vector2 position, Vector2 screenSize) {
    // Define the bounds within which the ball can be added
    return position.y < 100;
  }

  static bool isWithinBounds(Vector2 position, Vector2 screenSize) {
    // Define the bounds within which the ball can be added
    return position.x > 230 &&
        position.x < screenSize.x  -50 &&
        position.y > 100 &&
        position.y < screenSize.y - 100;
  }

   static Color getNextBallColor() {
    // Use the stored next ball radius
    Ball ball = Ball(initialPosition: Vector2.zero(), radius: nextBallRadius);
    return ball.getColorForRadius(nextBallRadius);
  }
}
