import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:mimimal_flame/components/chair.component.dart';
import 'package:mimimal_flame/components/player.component.dart';

class AppGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late final JoystickComponent joystickComponent;
  late final JoystickPlayer player;

  @override
  bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    await setChairs();

    await setJoystick();
    player = JoystickPlayer(joystickComponent);
    await add(player);

    camera.followComponent(player);

    return super.onLoad();
  }

  Future<void> setChairs() async {
    final components = <ChairComponent>[];
    for (int idx = 0; idx < 1000; idx++) {
      final pos = idx * 32.0;
      final component = ChairComponent(id: idx, position: Vector2(pos, pos));
      components.add(component);
    }

    await addAll(components);
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
