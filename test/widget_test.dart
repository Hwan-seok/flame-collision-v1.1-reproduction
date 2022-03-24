// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimimal_flame/components/player.component.dart';
import 'package:mimimal_flame/helper.dart';

class HasCollidablesGame extends FlameGame with HasCollisionDetection {}

final withCollidables = FlameTester(() => HasCollidablesGame());

void main() {
  group("infinite collision reproduce", () {
    withCollidables.test("etst", (game) async {
      final player = Player();
      await game.add(player);
      await addCollidableBlocks(game);
      final centerOfOneOfBlock = Vector2(1120, 1120);

      player.position = Vector2(
        centerOfOneOfBlock.x,
        centerOfOneOfBlock.y + 100,
      ); // no sides are overlaps
      game.update(0);
      expect(player.startCount, 0);
      expect(player.collisionCount, 0);
      expect(player.endCount, 0);

      player.position = Vector2(
        centerOfOneOfBlock.x,
        centerOfOneOfBlock.y + 10,
      ); // two sides are overlaps

      game.update(0);
      expect(player.startCount, 1);
      expect(player.collisionCount, 1);
      expect(player.endCount, 0); // <---- this is the point that fails test

      game.update(0);
      expect(player.startCount, 1);
      expect(player.collisionCount, 2);
      expect(player.endCount, 0);

      game.update(0);
      expect(player.startCount, 1);
      expect(player.collisionCount, 3);
      expect(player.endCount, 0);
    });
  });
}
