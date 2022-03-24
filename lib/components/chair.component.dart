import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TestBlock extends PositionComponent {
  final int id;

  TestBlock({
    required Vector2 position,
    required this.id,
  }) : super(
          position: position,
          size: Vector2(32, 32),
          anchor: Anchor.center,
        ) {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  Rect? rect;
  Paint paint = BasicPalette.red.paint();

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
