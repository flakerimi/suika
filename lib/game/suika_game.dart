import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:suika/components/ball.dart';
import 'package:suika/components/box.dart';
//import 'package:suika/components/grid.dart';
import 'package:suika/components/lisa.dart';
import 'package:suika/game/logic.dart';

class Suika extends Forge2DGame with TapDetector, MouseMovementDetector {
  Suika() : super(gravity: Vector2(0, 98));
  late Vector2 mousePosition = Vector2.zero();
  late Vector2 screenSize;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    screenSize = Vector2(size.x, size.y);
    // add(GridComponent(screenSize: screenSize));

    add(Box([20, 55], [78, 55], 10, screenSize));
    add(Box([20, 20], [20, 56], 5, screenSize));
    add(Box([78, 20], [78, 56], 5, screenSize));

    final characterImage = await images.load('lisa.png');

    final characterOnBox = Lisa(
      Vector2(20, 55),
      10,
      screenSize,
      characterImage,
    );
    add(characterOnBox);
  }

  getMouseX() {
    return mousePosition.x;
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    mousePosition = info.eventPosition.global;
    super.onMouseMove(info);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final tapPosition = info.eventPosition.global.xy;
    if (GameLogic.isWithinBounds(tapPosition, screenSize)) {
      GameLogic.addBallAtPosition(this, tapPosition);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    final ballsToMerge = children
        .whereType<Ball>()
        .where((b) => b.shouldBeMerged && b.isMounted)
        .toList();
    for (var ball in ballsToMerge) {
      // update score
      GameLogic.updateScore(ball);
      ball.removeFromParent();
      GameLogic.addNextRadiusBall(this, ball);
    }
  }
}
