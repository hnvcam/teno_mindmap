import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:logging/logging.dart';

import '../models/Node.dart';
import 'bloc/DashboardBloc.dart';
import 'bloc/DashboardState.dart';

class LayoutTask {
  final String nodeId;
  final double startAngle;
  final double endAngle;
  final bool forced;

  const LayoutTask({
    required this.nodeId,
    required this.startAngle,
    required this.endAngle,
    this.forced = false,
  });
}

class LayoutTaskQueue {
  final Queue<LayoutTask> _queue = Queue();
  final Set<String> _taskNodeIds = {};

  bool addTask({
    required String nodeId,
    required double startAngle,
    required double endAngle,
    bool forced = false,
  }) => add(
    LayoutTask(
      nodeId: nodeId,
      startAngle: startAngle,
      endAngle: endAngle,
      forced: forced,
    ),
  );

  bool add(LayoutTask layoutTask) {
    if (_taskNodeIds.contains(layoutTask.nodeId)) {
      return false;
    }
    _taskNodeIds.add(layoutTask.nodeId);
    _queue.add(layoutTask);
    return true;
  }

  LayoutTask get nextTask {
    final task = _queue.removeFirst();
    _taskNodeIds.remove(task.nodeId);
    return task;
  }

  bool get isEmpty => _queue.isEmpty;

  bool get isNotEmpty => _queue.isNotEmpty;
}

class LayoutService {
  static final _log = Logger('LayoutService');

  LayoutService(DashboardState dashboardState) {
    _currentState = dashboardState;
  }

  final _taskQueue = LayoutTaskQueue();
  final _nodeCenterStream =
      StreamController<RequestUpdateNodeCenter>.broadcast();

  StreamSubscription<DashboardState>? _stateSubscription;
  late DashboardState _currentState;
  LayoutTask? _currentTask;

  Stream<RequestUpdateNodeCenter> get stream => _nodeCenterStream.stream;

  void listen(Stream<DashboardState> stream) {
    _stateSubscription = stream.listen((state) {
      final changeIds = <String>{};

      /// if a node changes in size, then its parent must be rebalanced
      /// if a node changes in position, then its children must be rebalanced
      for (final entry in state.nodeMetas.entries) {
        final existingMeta = _currentState.nodeMetas[entry.key];
        if (existingMeta == null || existingMeta.size != entry.value.size) {
          final node = state.nodeOf(entry.key);
          if (node.isRoot) {
            changeIds.add(node.id);
          } else {
            changeIds.add(node.parentId!);
          }
        } else if ((existingMeta.center - entry.value.center).distance > 0.01) {
          changeIds.add(entry.key);
        }
      }

      /// if a node changes in children count, then its parent must be rebalanced
      for (final node in state.nodes.values) {
        final existingNode = _currentState.nodes[node.id];
        if (existingNode == null ||
            existingNode.children.length != node.children.length) {
          changeIds.add(node.isRoot ? node.id : node.parentId!);
        }
      }

      _currentState = state;
      // _log.info('Process $changeIds');
      for (final id in changeIds) {
        addTask(nodeId: id, forced: false);
      }
    });
  }

  void close() {
    _stateSubscription?.cancel();
    _nodeCenterStream.close();
  }

  void addTask({
    required String nodeId,
    double? startAngle,
    double? endAngle,
    required bool forced,
  }) {
    late bool added;
    if (startAngle != null && endAngle != null) {
      added = _taskQueue.addTask(
        nodeId: nodeId,
        startAngle: startAngle,
        endAngle: endAngle,
      );
    } else {
      final span = getNodeAngularSpan(_currentState.nodeOf(nodeId));
      added = _taskQueue.addTask(
        nodeId: nodeId,
        startAngle: span.start,
        endAngle: span.end,
        forced: forced,
      );
    }
    _log.info(
      '${added ? 'Added' : 'Skipped'} layout task: nodeId=$nodeId, startAngle=$startAngle, endAngle=$endAngle',
    );
    _processQueue();
  }

  void _executeTask(LayoutTask task) {
    if (_currentState.nodeOf(task.nodeId).isLeaf) {
      return;
    }
    final nodeMeta = _currentState.getNodeMetaById(task.nodeId);
    final children = _currentState.nodeOf(task.nodeId).children;
    int multiplier = 0;
    bool hasOverlapped = true;
    while (hasOverlapped) {
      hasOverlapped = false;

      final radiusToChildren =
          nodeMeta.radius +
          _currentState.minSpacing +
          _currentState.stepSpacing * multiplier;

      List<Rect> allRects = [nodeMeta.rect];
      for (final child in children) {
        final childMeta = _currentState.getNodeMeta(child);
        final childSpan = _getNodeAngularPanWithinParent(
          child,
          parentStart: task.startAngle,
          parentEnd: task.endAngle,
        );

        if (task.forced || !childMeta.isPositionLocked) {
          final midAngle = (childSpan.start + childSpan.end) / 2;
          final childCenter = Offset(
            nodeMeta.center.dx + radiusToChildren * cos(midAngle),
            nodeMeta.center.dy + radiusToChildren * sin(midAngle),
          );

          final updatedChildRect = Rect.fromCenter(
            center: childCenter,
            width: childMeta.size.width,
            height: childMeta.size.height,
          );

          if (allRects.any((element) => updatedChildRect.overlaps(element))) {
            multiplier++;
            hasOverlapped = true;
            _log.info('Increase space because of childNode overlapping');
            break;
          }
          allRects.add(updatedChildRect);

          /// this does not make _currentState updated as it needs a round trip from DashboardBloc.
          _nodeCenterStream.add(
            RequestUpdateNodeCenter(nodeId: child.id, center: childCenter),
          );
          _log.info(
            'Requested updating center of node ${child.id} to $childCenter',
          );
        }

        /// we don't need to add recursive children of childNode to taskQueue because
        /// when childNode center gets updated, it will trigger the updates
      }
    }
  }

  Future<void> _processQueue() async {
    if (_currentTask != null || _taskQueue.isEmpty) {
      return;
    }
    _currentTask = _taskQueue.nextTask;

    // _log.info('Processing relayout for ${_currentTask!.nodeId}');
    _executeTask(_currentTask!);
    // _log.info('Finished relayout for ${_currentTask!.nodeId}');
    _currentTask = null;

    _processQueue();
  }

  ({double start, double end}) _getNodeAngularPanWithinParent(
    Node node, {
    required double parentStart,
    required double parentEnd,
  }) {
    final parent = _currentState.parentOf(node);
    assert(parent != null, 'Must not call this function on Root!');

    /// if single child, then it should cover all its parent span
    /// or max of pi
    if (parent!.children.length == 1) {
      return (start: parentStart, end: min(parentStart + pi, parentEnd));
    }

    final parentAngle = parentEnd - parentStart;
    assert(parentAngle <= 2 * pi, 'How come a 2d has more than 360 degrees?');
    final maxChildSpan =
        parentAngle <= pi
            ?
            // if parentAngle is less than pi, then we don't limit the child span
            32767
            : parent.children.length - 1;

    /// we need to ensure that no child of this parent has span larger than pi.
    int totalSpan = 0;
    final overriddenSpan = <Node, int>{};
    for (final child in parent.children) {
      final childSpan = min(maxChildSpan, child.span);
      totalSpan += childSpan;
      overriddenSpan[child] = childSpan;
    }

    /// this min is a bit redundant, however just let it be for safe heart
    final steppedAngle = min(pi, (parentEnd - parentStart) / totalSpan);
    double start = parentStart;
    double end = parentStart;
    for (int i = 0; i < parent.children.length - 1; i++) {
      final child = parent.children[i];
      final step = min(pi, steppedAngle * overriddenSpan[child]!);
      if (child.id == node.id) {
        end = start + step;
        break;
      }
      start += step;
    }
    if (end == parentStart) {
      end = parentEnd;
    }
    return (start: start, end: end);
  }

  ({double start, double end}) getNodeAngularSpan(Node node) {
    List<Node> ancestors = [node];
    Node? parent = _currentState.parentOf(node);
    while (parent != null && !parent.isRoot) {
      ancestors.insert(0, parent);
      parent = _currentState.parentOf(parent);
    }

    /// start from Root, it has 2 * pi span
    double startAngle = _currentState.radialAngleStart;
    double endAngle = _currentState.radialAngleStart + 2 * pi;
    for (int i = 0; i < ancestors.length; i++) {
      final ancestor = ancestors[i];
      if (ancestor.isRoot) {
        continue;
      }
      final ancestorSpan = _getNodeAngularPanWithinParent(
        ancestor,
        parentStart: startAngle,
        parentEnd: endAngle,
      );
      startAngle = ancestorSpan.start;
      endAngle = ancestorSpan.end;
    }
    return (start: startAngle, end: endAngle);
  }
}
