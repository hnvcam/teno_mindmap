import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

part 'generated/DashboardState.freezed.dart';
part 'generated/DashboardState.g.dart';

@Freezed(copyWith: false)
sealed class DashboardState with _$DashboardState {
  static final DashboardState empty = DashboardState();
  static final uuid = Uuid();

  const DashboardState._();

  const factory DashboardState({
    @Default({}) Map<String, Node> nodes,
    @Default({}) Map<String, NodeMeta> nodeMetas,
    Node? root,

    /// minimum space between parent's center and child's center
    /// excluding the Node.radius
    @Default(50.0) double minSpacing,

    /// if there is an overlapping on nodes, increase the space by this step
    @Default(20.0) double stepSpacing,

    /// Where the angle of the radial layout start, in radian.
    @Default(-pi / 2) double radialAngleStart,
  }) = _DashboardState;

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);

  /// We don't generate this method publicly because it may be used incorrect without _updateWithAncestors
  DashboardState _copyWith({
    Map<String, Node>? nodes,
    Map<String, NodeMeta>? nodeMetas,
    double? radialAngleStart,
  }) {
    final effectiveNodes = nodes ?? this.nodes;
    return DashboardState(
      nodes: effectiveNodes,
      nodeMetas: nodeMetas ?? this.nodeMetas,
      root:
          root != null
              ? effectiveNodes[root!.id]
              : effectiveNodes.values
                  .where((element) => element.isRoot)
                  .firstOrNull,
      minSpacing: minSpacing,
      stepSpacing: stepSpacing,
      radialAngleStart: radialAngleStart ?? this.radialAngleStart,
    );
  }

  DashboardState newRoot({String? id, String? title}) {
    if (root != null) {
      throw Exception('Root already exists');
    }
    final rootNode = Node(id: id ?? uuid.v4());
    return _copyWith(
      nodes: Map.of(nodes)..[rootNode.id] = rootNode,
      nodeMetas: Map.of(nodeMetas)
        ..[rootNode.id] = NodeMeta(id: rootNode.id, title: title ?? 'Untitled'),
    );
  }

  DashboardState addNode({
    required String parentId,
    required NodeMeta nodeMeta,
  }) {
    if (!nodes.containsKey(parentId)) {
      throw Exception('Parent node not found');
    }
    final newNode = Node(id: nodeMeta.id ?? uuid.v4(), parentId: parentId);
    final newNodeMeta = nodeMeta.copyWith(id: newNode.id);
    final parentNode = nodes[parentId]!.copyWith(
      children: [...nodes[parentId]!.children, newNode],
    );
    final newNodes = _updateWithAncestors(parentNode);
    newNodes[newNode.id] = newNode;

    return _copyWith(
      nodes: newNodes,
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
    if (!nodes.containsKey(node.parentId)) {
      throw Exception('Node has non-existence parent');
    }
    final parentNode = nodes[node.parentId]!.copyWith(
      children:
          nodes[node.parentId]!.children
              .where((child) => child.id != nodeId)
              .toList(),
    );
    final newNodes = _updateWithAncestors(parentNode);

    return _copyWith(
      nodes: newNodes,
      nodeMetas: Map.of(nodeMetas)..remove(nodeId),
    );
  }

  DashboardState updateNode(String nodeId, NodeMeta newMeta) {
    if (!nodes.containsKey(nodeId)) {
      throw Exception('Node not found');
    }
    return _copyWith(
      nodeMetas: Map.of(nodeMetas)..[nodeId] = newMeta.copyWith(id: nodeId),
    );
  }

  NodeMeta getNodeMeta(Node node) => getNodeMetaById(node.id);

  NodeMeta getNodeMetaById(String nodeId) {
    if (!nodeMetas.containsKey(nodeId)) {
      throw Exception('Node meta not found');
    }
    return nodeMetas[nodeId]!;
  }

  Node? parentOf(Node node) =>
      node.parentId != null ? nodes[node.parentId] : null;

  Node nodeOf(String nodeId) {
    if (!nodes.containsKey(nodeId)) {
      throw Exception('Node $nodeId does not exist!');
    }
    return nodes[nodeId]!;
  }

  Map<String, Node> _updateWithAncestors(Node node) {
    final newNodes = Map.of(nodes);
    newNodes[node.id] = node;
    Node? ancestor = parentOf(node);
    Node updatingNode = node;
    while (ancestor != null) {
      updatingNode = ancestor.copyWith(
        children:
            ancestor.children
                .map(
                  (child) => child.id == updatingNode.id ? updatingNode : child,
                )
                .toList(),
      );
      newNodes[ancestor.id] = updatingNode;
      ancestor = parentOf(ancestor);
    }

    return newNodes;
  }

  DashboardState withRadialAngleStart(double angle) =>
      _copyWith(radialAngleStart: angle);
}
