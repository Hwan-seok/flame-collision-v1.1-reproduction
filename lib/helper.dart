import 'package:flame/game.dart';
import 'package:mimimal_flame/components/chair.component.dart';

Future<void> addCollidableBlocks(FlameGame game) async {
  final components = <TestBlock>[];
  for (int idx = 0; idx < 1000; idx++) {
    if (idx % 2 == 0) continue;
    final pos = idx * 32.0;
    final component = TestBlock(id: idx, position: Vector2(pos, pos));
    components.add(component);
  }

  await game.addAll(components);
}
