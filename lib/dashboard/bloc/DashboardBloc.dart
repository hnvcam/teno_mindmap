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
    on<RequestFixNodeCenter>(_onRequestFixNodePosition);
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
        forced: event.forced,
      ),
    );
  }

  @visibleForTesting
  ({double start, double end}) testNodeAngularSpan(Node node) =>
      _getNodeAngularSpan(node);

  double _getAngleStep(double start, double end, int childrenCount) =>
      (end - start) / max(2, childrenCount);

  ({double start, double end}) _getNodeAngularSpan(Node node) {
    List<Node> ancestors = [node];
    Node? parent = state.parentOf(node);
    while (parent != null) {
      ancestors.insert(0, parent);
      parent = state.parentOf(parent);
    }
    double startAngle = state.radialAngleStart;
    double endAngle = state.radialAngleStart + 2 * pi;
    for (int i = 0; i < ancestors.length - 1; i++) {
      final ancestor = ancestors[i];
      if (ancestor.children.isEmpty) {
        throw Exception(
          'Invalid structure! Ancestor ${ancestor.id} has no children',
        );
      }
      final steppedAngle = _getAngleStep(
        startAngle,
        endAngle,
        ancestor.children.length,
      );
      final nextAncestorIndex = ancestor.children.indexOf(ancestors[i + 1]);
      startAngle += steppedAngle * nextAncestorIndex;
      endAngle = startAngle + steppedAngle;
    }
    return (start: startAngle, end: endAngle);
  }

  DashboardState _layoutRadialRecursive({
    required DashboardState currentState,
    required Node node,
    required double startAngle,
    required double endAngle,
    bool forced = false,
  }) {
    final nodeMeta = currentState.getNodeMeta(node);
    final children = node.children;
    if (children.isEmpty) return currentState;

    final angleStep = _getAngleStep(startAngle, endAngle, children.length);
    double childStartAngle = startAngle;

    final radiusToChildren = nodeMeta.radius + currentState.spacing;

    DashboardState updatedState = currentState;
    for (final child in children) {
      final childMeta = updatedState.getNodeMeta(child);
      final childEndAngle = childStartAngle + angleStep;

      if (forced || !childMeta.isPositionLocked) {
        final midAngle = (childStartAngle + childEndAngle) / 2;
        final childCenter = Offset(
          nodeMeta.center.dx + radiusToChildren * cos(midAngle),
          nodeMeta.center.dy + radiusToChildren * sin(midAngle),
        );

        final updatedChildMeta = childMeta.copyWith(center: childCenter);

        updatedState = updatedState.updateNode(child.id, updatedChildMeta);

        updatedState = _layoutRadialRecursive(
          currentState: updatedState,
          node: child,
          startAngle: childStartAngle,
          endAngle: childEndAngle,
          forced: forced,
        );
      }

      childStartAngle = childEndAngle;
    }

    return updatedState;
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
      state.updateNode(
        event.nodeId,
        state.getNodeMetaById(event.nodeId).copyWith(size: event.size),
      ),
    );
    _log.info('Node ${event.nodeId} updated size: ${event.size}');
  }

  FutureOr<void> _onRequestFixNodePosition(
    RequestFixNodeCenter event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.updateNode(
        event.nodeId,
        state
            .getNodeMetaById(event.nodeId)
            .copyWith(center: event.center, isPositionLocked: true),
      ),
    );
  }
}
