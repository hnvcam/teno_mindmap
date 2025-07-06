import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../../models/Node.dart';

part 'DashboardBlocUtils.dart';
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
        nodeMeta: NodeMeta(title: event.title),
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
      _layoutRadial(
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

  DashboardState _layoutRadial({
    required DashboardState currentState,
    required Node node,
    required double startAngle,
    required double endAngle,
    bool forced = false,
  }) {
    DashboardState updatedState = currentState;
    final queue = _LayoutTaskQueue();
    queue.addTask(node: node, startAngle: startAngle, endAngle: endAngle);

    while (queue.isNotEmpty) {
      final current = queue.nextTask;
      if (current.node.isLeaf) {
        continue;
      }
      final currentMeta = updatedState.getNodeMeta(current.node);
      final children = current.node.children;
      final angleStep = _getAngleStep(
        current.startAngle,
        current.endAngle,
        children.length,
      );
      int multiplier = 1;
      bool hasOverlapped = true;
      while (hasOverlapped) {
        hasOverlapped = false;

        final radiusToChildren =
            currentMeta.radius + currentState.spacing * multiplier;

        double childStartAngle = current.startAngle;
        List<Rect> allRects = [currentMeta.rect];
        for (final child in children) {
          final childMeta = updatedState.getNodeMeta(child);

          final childEndAngle = childStartAngle + angleStep;

          if (forced || !childMeta.isPositionLocked) {
            final midAngle = (childStartAngle + childEndAngle) / 2;
            final childCenter = Offset(
              currentMeta.center.dx + radiusToChildren * cos(midAngle),
              currentMeta.center.dy + radiusToChildren * sin(midAngle),
            );

            final updatedChildMeta = childMeta.copyWith(center: childCenter);

            final childRect = updatedChildMeta.rect;
            if (allRects.any((element) => childRect.overlaps(element))) {
              multiplier++;
              hasOverlapped = true;
              break;
            }
            allRects.add(childRect);

            updatedState = updatedState.updateNode(child.id, updatedChildMeta);
          }

          queue.addTask(
            node: child,
            startAngle: childStartAngle,
            endAngle: childEndAngle,
          );

          childStartAngle = childEndAngle;
        }
      }
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
