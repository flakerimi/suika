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
      size: Vector2.all(100.0), // Set the size as needed
    );
    position = boxPosition ;
    size = characterSprite.size;
    add(characterSprite);

    // Initialize a ball component, which will be used when dropping balls
    ball = Ball(radius: 15); // Assuming Ball has a radius parameter
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(boxPosition.x, boxPosition.y + 100 - size.y);
  }

  // Follow the mouse horizontally
  @override
  void update(double dt) {
    super.update(dt);
    // Update Lisa's position to follow the mouse horizontally
    // not going beyond the left + 230 and right -20 edges of the screen
    position.x = (gameRef.mousePosition.x - size.x / 2)
        .clamp(230, worldSize.x - size.x - 20);  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render Lisa's sprite
    characterSprite.render(canvas);
  }
}
