import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:suika/components/ball.dart';
import 'package:suika/components/box.dart';

void main() {
  runApp(const GameWidget.controlled(gameFactory: Suika.new));
}

class Suika extends Forge2DGame with TapDetector {
  Suika() : super(gravity: Vector2(0, 98)); // Updated gravity

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // set gravity to 98

    Vector2 screenSize = Vector2(size.x, size.y); // Screen size
    // Add walls and boxes
    add(Box([10, 55], [70, 55], 10, screenSize));
    add(Box([10, 10], [10, 56], 5, screenSize));
    add(Box([70, 10], [70, 56], 5, screenSize));
    add(Ball(initialPosition: Vector2(200, 200), radius: 15));
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final tapPosition = info.eventPosition.global;
    if (_isWithinBounds(tapPosition)) {
      // Only add a ball if within bounds
      addBallAtPosition(tapPosition);
    }
  }

  void addMergedBall(Vector2 position, double radius) {
    List<double> radiuses = [15, 30, 45, 60, 75, 90];
    int currentIndex = radiuses.indexOf(radius);

    // Ensure there is a next radius available
    if (currentIndex < radiuses.length - 1) {
      double nextRadius = radiuses[currentIndex + 1];
      final ball = Ball(initialPosition: position, radius: nextRadius);
      add(ball);
    }
    // Optionally, handle the case where there is no larger radius available
  }

  void addBallAtPosition(Vector2 position) {
    List<double> radiuses = [15, 30, 45, 60, 75, 90];
    final ball = Ball(
        initialPosition: position,
        radius: radiuses[Random().nextInt(radiuses.length)]);
    add(ball);
  }

  bool _isWithinBounds(Vector2 position) {
    // Define the bounds within which the ball can be added
    return position.x > 100 &&
        position.x < 700 &&
        position.y > 100 &&
        position.y < 550;
  }

  @override
  void update(double dt) {
    super.update(dt);

    Map<Vector2, double> mergePositions = {};

    for (var component in children) {
      if (component is Ball &&
          component.shouldBeMerged &&
          component.isMounted) {
        mergePositions[component.body.position] = component.radius;
        component.removeFromParent(); // Remove the ball
      }
    }

    mergePositions.forEach((position, radius) {
      addMergedBall(position, radius);
    });
  }
}
