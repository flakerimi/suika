import 'dart:math';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent with ContactCallbacks {
  final double radius;
  late final Color color; // Color based on radius
  Vector2? initialPosition;
  bool shouldBeMerged = false;

  Ball({this.initialPosition, required this.radius}) {
    color = getColorForRadius(radius);

    fixtureDefs = [
      FixtureDef(
        CircleShape()..radius = radius,
        restitution: 0.8,
        friction: 0.8,
        userData: this,
        density: 1,
      ),
    ];

    bodyDef = BodyDef(
      angularDamping: 0.8,
      position: initialPosition ?? Vector2.zero(),
      type: BodyType.dynamic,
    );
  }
  Color getNextBallColor() {
    List<double> radiuses = [15, 30, 45, 60, 75, 90, 105, 120];
    int nextRadiusIndex = Random().nextInt(radiuses.length);
    double nextRadius = radiuses[nextRadiusIndex];
    return getColorForRadius(
        nextRadius); // Assuming getColorForRadius is accessible
  }

  Color getColorForRadius(double radius) {
    // Define color based on radius
    switch (radius.toInt()) {
      case 15:
        return Colors.red;
      case 30:
        return Colors.blue;
      case 45:
        return Colors.green;
      case 60:
        return Colors.yellow;
      case 75:
        return Colors.purple;
      case 90:
        return Colors.orange;
      case 105:
        return Colors.pink;
      case 120:
        return Colors.teal;
      // Add more cases as needed
      default:
        return Colors.grey; // Default color
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Custom rendering for the ball
    final paint = Paint()..color = color;
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  @mustCallSuper
  void update(double dt) {
    super.update(dt);

    if (shouldBeMerged) {
      _mergeWithAnotherBall();
    }
  }

  void _mergeWithAnotherBall() {
    var ballsToMerge = world.physicsWorld.bodies.where((body) =>
        body.userData is Ball &&
        (body.userData as Ball).shouldBeMerged &&
        (body.userData as Ball) != this);

    if (ballsToMerge.isNotEmpty) {
      Ball ballToMergeWith = ballsToMerge.first.userData as Ball;

      // Mark for removal
      ballToMergeWith.markForRemoval();
      markForRemoval();

      // Schedule the addition of the new ball
      world.add(Ball(
        initialPosition: body.position,
        radius: radius * 2,
      ));

      // Reset the flag
      shouldBeMerged = false;
    }
  }

  void markForRemoval() {
    shouldBeMerged = false;
    removeFromParent();
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is Ball && other.radius == radius) {
      shouldBeMerged = true;
      other.shouldBeMerged = false;
      other.removeFromParent();
    }
  }
}
