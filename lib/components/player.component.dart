import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:mimimal_flame/components/chair.component.dart';

class Player extends PositionComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 300.0;
  int startCount = 0;
  int collisionCount = 0;
  int endCount = 0;

  final JoystickComponent? joystick;

  Player({this.joystick})
      : super(
          size: Vector2.all(32.0),
          anchor: Anchor.center,
        ) {
    final hitbox = RectangleHitbox(
      size: size,
      anchor: Anchor.center,
      position: size / 2,
    );
    add(hitbox);
  }

  @override
  Future<void>? onLoad() {
    position = gameRef.size / 2;
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    other as TestBlock;
    startCount++;
    print(
        "collision start: other: ${other.center} id:${other.id} center: ${other.center} me: $center size: $size");
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    collisionCount++;
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    other as TestBlock;
    endCount++;
    print(
        "collision end: other: ${other.center} id:${other.id} center: ${other.center} me: $center size: $size");
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick == null) return;
    if (joystick!.direction != JoystickDirection.idle) {
      position.add(joystick!.relativeDelta * maxSpeed * dt);
    }
  }

  Rect? rect;
  Paint paint = BasicPalette.green.paint();

  @override
  render(Canvas canvas) {
    rect ??= Rect.fromCenter(
      center: (size / 2).toOffset(),
      width: width,
      height: height,
    );
    canvas.drawRect(rect!, paint);
    super.render(canvas);
  }
}
