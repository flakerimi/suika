import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:get/get.dart';
import 'package:suika/components/ball.dart';
import 'package:suika/components/box.dart';
import 'package:suika/components/lisa.dart';
import 'package:suika/game/logic.dart';
import 'package:suika/ui/game_over.dart';

class Suika extends Forge2DGame with TapDetector, MouseMovementDetector {

   Suika() : super(gravity: Vector2(0, 98));
  late Vector2 mousePosition = Vector2.zero();
  late Vector2 screenSize;
      Lisa? lisa;
  late Box topWall;// = Box(Vector2.zero() as List<double>, Vector2.zero() as List<double>, 0, Vector2.zero());

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    screenSize = Vector2(size.x, size.y);
    //  add(GridComponent(screenSize: screenSize));

    //add  top wall as transparent box, beneath lisa
    // but allow balls to pass through it
    //if ball hits this wall, game over

    topWall = Box([20, 15], [78, 15], 0.1 , screenSize);
     add(topWall);
 


    add(Box([20, 55], [78, 55], 10, screenSize));
    add(Box([20, 20], [20, 56], 5, screenSize));
    add(Box([78, 20], [78, 56], 5, screenSize));

 // Direct initialization for testing
    lisa = Lisa(
      Vector2(10, 55),
      10,
      screenSize,
      await Flame.images.load('lisa.png'), // Make sure this path is correct
    );
    add(lisa!);

    // Debug statement
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
    // Check if the tap is within the bounds of the game
    if (lisa != null) {
      // Use Lisa's position to add a new ball
      print("lisa position: ${lisa!.position}");
      print("topWall position: ${topWall.position}");
      Vector2 lisaPosition = lisa!.position.clone();
      Vector2 ballPosition = Vector2(lisaPosition.x,   lisaPosition.y *4 );

      GameLogic.addBallAtPosition(this, ballPosition);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check if the game is over
    // if topWall is hit, game over

    // if (GameLogic.isGameOver(topWall.body.position, screenSize)) {
    //   // Game over
    //   showGameOver();
    // }
     

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

  void showGameOver() {

    // Show the game over screen
    // Pass the current score and the best score
    // to the game over screen

    Get.to(GameOver(
      score: GameLogic.score.value,
      bestScore: 0,
      onRestart: () {
        // Restart the game
        GameLogic.score.value = 0;
        Get.back();
      },
    ));

  }
}
