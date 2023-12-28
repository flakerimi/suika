import 'package:flame_forge2d/flame_forge2d.dart';

class Box extends BodyComponent {
  final List<double> _startGridPos;
  final List<double> _endGridPos;
  final double _thickness;
  final Vector2 screenSize;

  // Constructor accepts Lists for start and end grid positions
  Box(this._startGridPos, this._endGridPos, this._thickness, this.screenSize);

  @override
  Body createBody() {
    final cellWidth = screenSize.x / 80;
    final cellHeight = screenSize.y / 60;

    // Translate grid coordinates (List) to world coordinates (Vector2)
    Vector2 start =
        Vector2(_startGridPos[0] * cellWidth, _startGridPos[1] * cellHeight);
    Vector2 end =
        Vector2(_endGridPos[0] * cellWidth, _endGridPos[1] * cellHeight);

    // Create a body definition
    final bodyDef = BodyDef()..position = Vector2.zero();

    // Create the body in the world
    final body = world.createBody(bodyDef);

    // Calculate the center and dimensions of the wall
    Vector2 center = (start + end) / 2;
    double length = start.distanceTo(end);
    double angle = (start - end).angleToSigned(Vector2(1, 0));

    // Create a polygon shape for the wall
    final shape = PolygonShape()
      ..setAsBox(length / 2, _thickness, center, angle);

    // Create and attach the fixture
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    body.createFixture(fixtureDef);

    return body;
  }
}
