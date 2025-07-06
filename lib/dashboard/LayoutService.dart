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

  double getAngleStep(double start, double end, int childrenCount) =>
      (end - start) / max(2, childrenCount);

  void _executeTask(LayoutTask task) {
    if (_currentState.nodeOf(task.nodeId).isLeaf) {
      return;
    }
    final nodeMeta = _currentState.getNodeMetaById(task.nodeId);
    final children = _currentState.nodeOf(task.nodeId).children;
    final angleStep = getAngleStep(
      task.startAngle,
      task.endAngle,
      children.length,
    );
    int multiplier = 1;
    bool hasOverlapped = true;
    while (hasOverlapped) {
      hasOverlapped = false;

      final radiusToChildren =
          nodeMeta.radius + _currentState.spacing * multiplier;

      double childStartAngle = task.startAngle;
      List<Rect> allRects = [nodeMeta.rect];
      for (final child in children) {
        final childMeta = _currentState.getNodeMeta(child);

        final childEndAngle = childStartAngle + angleStep;

        if (task.forced || !childMeta.isPositionLocked) {
          final midAngle = (childStartAngle + childEndAngle) / 2;
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

        childStartAngle = childEndAngle;
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

  ({double start, double end}) getNodeAngularSpan(Node node) {
    List<Node> ancestors = [node];
    Node? parent = _currentState.parentOf(node);
    while (parent != null) {
      ancestors.insert(0, parent);
      parent = _currentState.parentOf(parent);
    }
    double startAngle = _currentState.radialAngleStart;
    double endAngle = _currentState.radialAngleStart + 2 * pi;
    for (int i = 0; i < ancestors.length - 1; i++) {
      final ancestor = ancestors[i];
      if (ancestor.children.isEmpty) {
        throw Exception(
          'Invalid structure! Ancestor ${ancestor.id} has no children',
        );
      }
      final steppedAngle = getAngleStep(
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
}
