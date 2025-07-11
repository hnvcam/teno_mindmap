import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/constants.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/Node.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

({DashboardState newState, List<Node> children}) sampleChildren(
  DashboardState currentState, {
  required String nodeId,
  required int count,
}) {
  final children = <Node>[];
  DashboardState newState = currentState;
  for (int i = 0; i < count; i++) {
    final childId = '${nodeId}_$i';
    newState = newState.copyWith(
      mindMap: newState.mindMap.addNode(
        parentId: nodeId,
        nodeMeta: NodeMeta(id: childId, title: childId),
      ),
    );
    children.add(newState.mindMap.nodeById(childId));
  }
  return (newState: newState, children: children);
}

Matcher closeToOffset(Offset value, {double delta = distanceSensitive}) =>
    isA<Offset>()
        .having((p0) => p0.dx, 'dx', closeTo(value.dx, delta))
        .having((p0) => p0.dy, 'dy', closeTo(value.dy, delta));

extension OffsetExtension on Offset {
  bool closeTo(Offset other) =>
      (this - other).distanceSquared < distanceSensitive;
}
