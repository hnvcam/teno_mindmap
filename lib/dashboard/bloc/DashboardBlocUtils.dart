part of 'DashboardBloc.dart';

class _LayoutTask {
  final Node node;
  final double startAngle;
  final double endAngle;
  const _LayoutTask({
    required this.node,
    required this.startAngle,
    required this.endAngle,
  });
}

class _LayoutTaskQueue {
  final Queue<_LayoutTask> _queue = Queue();
  final Set<Node> _taskNodes = {};

  void addTask({
    required Node node,
    required double startAngle,
    required double endAngle,
  }) {
    if (_taskNodes.contains(node)) {
      return;
    }
    _taskNodes.add(node);
    _queue.add(
      _LayoutTask(node: node, startAngle: startAngle, endAngle: endAngle),
    );
  }

  _LayoutTask get nextTask {
    final task = _queue.removeFirst();
    _taskNodes.remove(task.node);
    return task;
  }

  bool get isEmpty => _queue.isEmpty;

  bool get isNotEmpty => _queue.isNotEmpty;
}
