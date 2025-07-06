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
    newState = newState.addNode(
      parentId: nodeId,
      nodeMeta: NodeMeta(id: childId, title: childId),
    );
    children.add(newState.nodeOf(childId));
  }
  return (newState: newState, children: children);
}
