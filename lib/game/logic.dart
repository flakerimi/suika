import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suika/components/ball.dart';

class GameLogic {
  static final List<double> _radiuses = [15, 30, 45, 60, 75, 90, 105, 120];
  static RxInt score = 0.obs;
  static void addBallAtPosition(Forge2DGame game, Vector2 position) {
    final ball = Ball(
      initialPosition: position,
      radius: _radiuses[Random().nextInt(_radiuses.length - 4)],
    );
    game.add(ball);
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

  static bool isWithinBounds(Vector2 position, Vector2 screenSize) {
    // Define the bounds within which the ball can be added
    return position.x > 100 &&
        position.x < screenSize.x - 100 &&
        position.y > 100 &&
        position.y < screenSize.y - 100;
  }

  static Color getNextBallColor() {
    int nextRadiusIndex = Random().nextInt(_radiuses.length);
    double nextRadius = _radiuses[nextRadiusIndex];
    Ball ball = Ball(initialPosition: Vector2.zero(), radius: nextRadius);
    return ball.getColorForRadius(nextRadius);
  }
}
