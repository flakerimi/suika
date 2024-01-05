import 'dart:ui';
import 'package:flame/components.dart';
import 'package:suika/components/ball.dart';
import 'package:suika/game/suika_game.dart';

class Lisa extends PositionComponent with HasGameRef<Suika> {
  late final SpriteComponent characterSprite;
  final Vector2 boxPosition;
  final double boxHeight;
  Vector2 worldSize;
  late final Ball ball;

  Lisa(this.boxPosition, this.boxHeight, this.worldSize, Image characterImage) {
    characterSprite = SpriteComponent(
      sprite: Sprite(characterImage),
      size: Vector2.all(50.0), // Set the size as needed
    );
    position = boxPosition;
    size = characterSprite.size;
    add(characterSprite);

    // Initialize a ball component, which will be used when dropping balls
    ball = Ball(radius: 15); // Assuming Ball has a radius parameter
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(boxPosition.x, boxPosition.y - boxHeight - size.y);
  }

  // Follow the mouse horizontally
  @override
  void update(double dt) {
    super.update(dt);
    position = Vector2(gameRef.getMouseX(), position.y);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render Lisa's sprite
    characterSprite.render(canvas);
  }
}
