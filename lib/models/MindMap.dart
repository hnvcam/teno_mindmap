import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teno_mindmap/constants.dart';
import 'package:teno_mindmap/converters/SizeJsonConverter.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';
import 'package:uuid/uuid.dart';

import 'Node.dart';

part 'generated/MindMap.freezed.dart';
part 'generated/MindMap.g.dart';

@Freezed(copyWith: false)
class MindMap with _$MindMap {
  static const uuid = Uuid();
  const MindMap._();

  const factory MindMap({
    required String id,
    required String title,
    @Default({}) Map<String, Node> nodes,
    @Default({}) Map<String, NodeMeta> nodeMetas,
    @Default({}) Map<String, dynamic> data,
    @SizeJsonConverter() @Default(Size.zero) Size size,
  }) = _MindMap;

  factory MindMap.fromJson(Map<String, dynamic> json) =>
      _$MindMapFromJson(json);

  List<Node> get rootChildren => nodes.values
      .where((node) => node.parentId == rootNodeId)
      .toList(growable: false);

  /// We don't generate this method publicly because it may be used incorrect without _updateWithAncestors
  MindMap _copyWith({
    String? title,
    Map<String, dynamic>? data,
    Map<String, Node>? nodes,
    Map<String, NodeMeta>? nodeMetas,
    Size? size,
  }) {
    final effectiveNodes = nodes ?? this.nodes;
    return MindMap(
      id: id,
      nodes: effectiveNodes,
      nodeMetas: nodeMetas ?? this.nodeMetas,
      title: title ?? this.title,
      data: data ?? this.data,
      size: size ?? this.size,
    );
  }

  void assertValidId(String nodeId) {
    assert(
      nodeId == rootNodeId || nodes.containsKey(nodeId),
      'Invalid id: $nodeId',
    );
  }

  MindMap addNode({required String parentId, required NodeMeta nodeMeta}) {
    assertValidId(parentId);

    final newNode = Node(id: nodeMeta.id ?? uuid.v4(), parentId: parentId);
    final newNodeMeta = nodeMeta.copyWith(id: newNode.id);

    Map<String, Node> newNodes = Map.of(nodes);
    newNodes[newNode.id] = newNode;

    if (parentId != rootNodeId) {
      final parentNode = nodes[parentId]!.copyWith(
        children: [...nodes[parentId]!.children, newNode],
      );
      newNodes = _updateWithAncestors(newNodes, parentNode);
    }

    return _copyWith(
      nodes: newNodes,
      nodeMetas: Map.of(nodeMetas)..[newNode.id] = newNodeMeta,
    );
  }

  MindMap removeNode(String nodeId) {
    assertValidId(nodeId);

    if (nodeId == rootNodeId) {
      throw Exception('Cannot remove root node');
    }

    final node = nodes[nodeId]!;

    Map<String, Node> newNodes = Map.of(nodes)..remove(nodeId);

    if (node.parentId != rootNodeId) {
      final parentNode = nodes[node.parentId]!.copyWith(
        children:
            nodes[node.parentId]!.children
                .where((child) => child.id != nodeId)
                .toList(),
      );
      newNodes = _updateWithAncestors(newNodes, parentNode);
    }

    return _copyWith(
      nodes: newNodes,
      nodeMetas: Map.of(nodeMetas)..remove(nodeId),
    );
  }

  MindMap updateNode(String nodeId, NodeMeta newMeta) {
    assertValidId(nodeId);
    if (nodeId == rootNodeId) {
      return _copyWith(
        title: newMeta.title,
        data: newMeta.data,
        size: newMeta.size,
      );
    }

    return _copyWith(
      nodeMetas: Map.of(nodeMetas)..[nodeId] = newMeta.copyWith(id: nodeId),
    );
  }

  Node get root =>
      Node(id: rootNodeId, parentId: rootNodeId, children: rootChildren);

  NodeMeta nodeMetaOf(Node node) => nodeMetaById(node.id);

  NodeMeta nodeMetaById(String nodeId) {
    assertValidId(nodeId);

    if (nodeId == rootNodeId) {
      return NodeMeta(
        id: rootNodeId,
        title: title,
        data: data,
        isPositionLocked: true,
        center: Offset.zero,
        size: size,
      );
    }
    return nodeMetas[nodeId]!;
  }

  Node parentOf(Node node) => nodeById(node.parentId);

  Node nodeById(String nodeId) {
    assertValidId(nodeId);
    if (nodeId == rootNodeId) {
      return root;
    }
    return nodes[nodeId]!;
  }

  Map<String, Node> _updateWithAncestors(Map<String, Node> nodes, Node node) {
    final newNodes = Map.of(nodes);
    newNodes[node.id] = node;
    Node ancestor = parentOf(node);
    Node updatingNode = node;
    while (!isRoot(ancestor)) {
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
}
