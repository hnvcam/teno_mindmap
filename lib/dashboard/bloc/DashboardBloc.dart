import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../../models/Node.dart';

part 'DashboardEvent.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static DashboardBloc read(BuildContext context) =>
      context.read<DashboardBloc>();

  DashboardBloc(super.initialState) {
    on<RequestAddChildNode>(_onRequestAddChildNode);
    on<RequestRebalancingNodes>(_onRequestRebalancingNodes);
  }

  FutureOr<void> _onRequestAddChildNode(
    RequestAddChildNode event,
    Emitter<DashboardState> emit,
  ) {}

  FutureOr<void> _onRequestRebalancingNodes(
    RequestRebalancingNodes event,
    Emitter<DashboardState> emit,
  ) {
    final span = _getNodeAngularSpan(event.node);
    emit(
      _layoutRadialRecursive(
        currentState: state,
        node: event.node,
        startAngle: span.start,
        endAngle: span.end,
        centerOverride: null,
        forced: event.forced,
      ),
    );
  }

  ({double start, double end}) _getNodeAngularSpan(
    Node node, {
    double fallbackStart = 0,
    double fallbackEnd = 2 * pi,
  }) {
    if (node.isRoot) {
      return (start: fallbackStart, end: fallbackEnd);
    }

    final parent = state.parentOf(node);
    // All siblings (locked and unlocked count equally)
    final siblings = parent.children;

    final index = siblings.indexOf(node);

    if (siblings.isEmpty || index < 0) {
      throw Exception(
        'Invalid state, missing adding this $node to parent\'s children?',
      );
    }

    // Get parent’s angular span recursively
    final parentSpan = _getNodeAngularSpan(
      parent,
      fallbackStart: fallbackStart,
      fallbackEnd: fallbackEnd,
    );
    final totalSiblings = siblings.length;
    final step = (parentSpan.end - parentSpan.start) / totalSiblings;

    final start = parentSpan.start + index * step;
    final end = start + step;

    return (start: start, end: end);
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
        final childPosition = Offset(
          center.dx + radiusToChildren * cos(midAngle),
          center.dy + radiusToChildren * sin(midAngle),
        );

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
}
