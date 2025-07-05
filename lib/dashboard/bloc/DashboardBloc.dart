import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../../models/Node.dart';

part 'DashboardEvent.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static DashboardBloc read(BuildContext context) =>
      context.read<DashboardBloc>();

  static final _log = Logger('DashboardBloc');

  DashboardBloc(super.initialState) {
    on<RequestAddChildNode>(_onRequestAddChildNode);
    on<RequestRebalancingNode>(_onRequestRebalancingNodes);
    on<NodeSizeChangedEvent>(_onNodeSizeChanged);
  }

  FutureOr<void> _onRequestAddChildNode(
    RequestAddChildNode event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.addNode(
        parentId: event.parentNodeId,
        nodeMeta: NodeMeta(title: 'title'),
      ),
    );
    add(RequestRebalancingNode(nodeId: event.parentNodeId));
  }

  FutureOr<void> _onRequestRebalancingNodes(
    RequestRebalancingNode event,
    Emitter<DashboardState> emit,
  ) {
    final node = state.nodeOf(event.nodeId);
    final span = _getNodeAngularSpan(node);
    emit(
      _layoutRadialRecursive(
        currentState: state,
        node: node,
        startAngle: span.start,
        endAngle: span.end,
        centerOverride: null,
        forced: event.forced,
      ),
    );
  }

  @visibleForTesting
  ({double start, double end}) testNodeAngularSpan(Node node) =>
      _getNodeAngularSpan(node);

  ({double start, double end}) _getNodeAngularSpan(Node node) {
    List<Node> ancestors = [node];
    Node? parent = state.parentOf(node);
    while (parent != null) {
      ancestors.insert(0, parent);
      parent = state.parentOf(parent);
    }
    double startAngle = 0;
    double endAngle = 2 * pi;
    for (int i = 0; i < ancestors.length - 1; i++) {
      final ancestor = ancestors[i];
      if (ancestor.children.isEmpty) {
        throw Exception(
          'Invalid structure! Ancestor ${ancestor.id} has no children',
        );
      }
      final steppedAngle =
          (endAngle - startAngle) / max((i + 1) * 2, ancestor.children.length);
      final nextAncestorIndex = ancestor.children.indexOf(ancestors[i + 1]);
      startAngle += steppedAngle * nextAncestorIndex;
      endAngle = startAngle + steppedAngle;
    }
    return (start: startAngle, end: endAngle);
  }

  DashboardState _layoutRadialRecursive({
    required DashboardState currentState,
    required Node node,
    required Offset? centerOverride,
    required double startAngle,
    required double endAngle,
    bool forced = false,
  }) {
    final nodeMeta = currentState.nodeMetas[node.id];
    if (nodeMeta == null) return currentState;

    final newMetas = Map<String, NodeMeta>.from(currentState.nodeMetas);
    final spacing = currentState.spacing;

    final center = centerOverride ?? nodeMeta.center;
    final children = node.children;
    if (children.isEmpty) return currentState.copyWith(nodeMetas: newMetas);

    final totalSiblings = children.length;
    if (totalSiblings == 0) return currentState.copyWith(nodeMetas: newMetas);

    final angleStep = (endAngle - startAngle) / totalSiblings;
    double childStartAngle = startAngle;

    final radiusToChildren = nodeMeta.radius + spacing;

    for (final child in children) {
      final childMeta = newMetas[child.id];
      final childEndAngle = childStartAngle + angleStep;

      if (childMeta != null && (forced || !childMeta.isPositionLocked)) {
        final midAngle = (childStartAngle + childEndAngle) / 2;
        final childPosition =
            Offset(
              center.dx + radiusToChildren * cos(midAngle),
              center.dy + radiusToChildren * sin(midAngle),
            ) -
            Offset(childMeta.size.width / 2, childMeta.size.height / 2);

        final updatedChildMeta = childMeta.copyWith(position: childPosition);
        newMetas[child.id] = updatedChildMeta;

        final updatedState = currentState.copyWith(nodeMetas: newMetas);
        final result = _layoutRadialRecursive(
          currentState: updatedState,
          node: child,
          centerOverride: updatedChildMeta.center,
          startAngle: childStartAngle,
          endAngle: childEndAngle,
          forced: forced,
        );

        newMetas.addAll(result.nodeMetas);
      }

      childStartAngle = childEndAngle;
    }

    return currentState.copyWith(nodeMetas: newMetas);
  }

  FutureOr<void> _onNodeSizeChanged(
    NodeSizeChangedEvent event,
    Emitter<DashboardState> emit,
  ) {
    if (!state.nodeMetas.containsKey(event.nodeId)) {
      _log.severe('Node ${event.nodeId} does not exist');
      return null;
    }
    emit(
      state.copyWith(
        nodeMetas: Map.of(state.nodeMetas)
          ..[event.nodeId] = state.nodeMetas[event.nodeId]!.copyWith(
            size: event.size,
          ),
      ),
    );
    _log.info('Node ${event.nodeId} updated size: ${event.size}');
  }
}
