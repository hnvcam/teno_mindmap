import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

part 'generated/DashboardState.freezed.dart';
part 'generated/DashboardState.g.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  static final DashboardState empty = DashboardState().newRoot();
  static final uuid = Uuid();

  const DashboardState._();

  const factory DashboardState({
    @Default({}) Map<String, Node> nodes,
    @Default({}) Map<String, NodeMeta> nodeMetas,
    Node? root,
    @Default(50.0) double spacing,
  }) = _DashboardState;

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);

  DashboardState newRoot() {
    if (root != null) {
      throw Exception('Root already exists');
    }
    final rootNode = Node(id: uuid.v4());
    return copyWith(
      root: rootNode,
      nodes: Map.of(nodes)..[rootNode.id] = rootNode,
      nodeMetas: Map.of(nodeMetas)
        ..[rootNode.id] = NodeMeta(id: rootNode.id, title: 'Untitled'),
    );
  }

  DashboardState addNode({
    required String parentId,
    required NodeMeta nodeMeta,
  }) {
    if (!nodes.containsKey(parentId)) {
      throw Exception('Parent node not found');
    }
    final parentNode = nodes[parentId];
    final newNode = Node(id: uuid.v4(), parentId: parentId);
    final newNodeMeta = nodeMeta.copyWith(id: newNode.id);
    return copyWith(
      nodes:
          Map.of(nodes)
            ..[newNode.id] = newNode
            ..[parentId] = parentNode!.copyWith(
              children: [...parentNode.children, newNode],
            ),
      nodeMetas: Map.of(nodeMetas)..[newNode.id] = newNodeMeta,
    );
  }

  DashboardState removeNode(String nodeId) {
    if (!nodes.containsKey(nodeId)) {
      throw Exception('Node not found');
    }
    final node = nodes[nodeId];
    if (node!.isRoot) {
      throw Exception('Cannot remove root node');
    }
    final parentNode = nodes[node.parentId];
    if (parentNode == null) {
      throw Exception('Node has non-existence parent');
    }
    return copyWith(
      nodes:
          Map.of(nodes)
            ..remove(nodeId)
            ..[parentNode.id] = parentNode.copyWith(
              children:
                  parentNode.children
                      .where((child) => child.id != nodeId)
                      .toList(),
            ),
      nodeMetas: Map.of(nodeMetas)..remove(nodeId),
    );
  }

  DashboardState updateNode(String nodeId, NodeMeta newMeta) {
    if (!nodes.containsKey(nodeId)) {
      throw Exception('Node not found');
    }
    return copyWith(
      nodeMetas: Map.of(nodeMetas)..[nodeId] = newMeta.copyWith(id: nodeId),
    );
  }

  NodeMeta getNodeMeta(Node node) {
    if (!nodeMetas.containsKey(node.id)) {
      throw Exception('Node meta not found');
    }
    return nodeMetas[node.id]!;
  }

  Node? parentOf(Node node) =>
      node.parentId != null ? nodes[node.parentId] : null;

  Node nodeOf(String nodeId) {
    if (!nodes.containsKey(nodeId)) {
      throw Exception('Node $nodeId does not exist!');
    }
    return nodes[nodeId]!;
  }
}
