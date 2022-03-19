import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mimimal_flame/app_game.dart';
import 'package:mimimal_flame/components/chair.component.dart';

class JoystickPlayer extends SpriteComponent
    with HasGameRef<AppGame>, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 300.0;

  final JoystickComponent joystick;

  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(100.0),
          anchor: Anchor.center,
        ) {
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    other as ChairComponent;
    print(
        "collision start: $other id:${other.id} center: ${other.center} me: $center");

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    other as ChairComponent;
    print(
        "collision end: $other id:${other.id} center: ${other.center} me: $center");
    super.onCollisionEnd(other);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick.direction != JoystickDirection.idle) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }
}
