import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:mimimal_flame/components/player.component.dart';
import 'package:mimimal_flame/helper.dart';

class AppGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late final JoystickComponent joystickComponent;
  late final Player player;

  @override
  bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    await addCollidableBlocks(this);

    await setJoystick();
    player = Player(joystick: joystickComponent);
    await add(player);

    camera.followComponent(player);

    return super.onLoad();
  }

  Future<void> setJoystick() async {
    final image = await images.load('joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );
    joystickComponent = JoystickComponent(
      knob: SpriteComponent(
        sprite: sheet.getSpriteById(1),
        size: Vector2.all(100),
      ),
      background: SpriteComponent(
        sprite: sheet.getSpriteById(0),
        size: Vector2.all(150),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    await add(joystickComponent);
  }
}
