part of 'DashboardBloc.dart';

sealed class DashboardEvent {
  const DashboardEvent();
}

class RequestRebalancingNode extends DashboardEvent {
  const RequestRebalancingNode({required this.nodeId, this.forced = false});

  /// force = true means we ignore the isPositionLocked flag of NodeMeta
  final bool forced;
  final String nodeId;
}

class RequestAddChildNode extends DashboardEvent {
  const RequestAddChildNode({
    required this.parentNodeId,
    required this.nodeMeta,
  });
  final String parentNodeId;
  final NodeMeta nodeMeta;
}

class RequestUpdateNodeMeta extends DashboardEvent {
  const RequestUpdateNodeMeta({
    required this.nodeId,
    this.data,
    this.title,
    this.merged = true,
  });
  final String nodeId;
  final String? title;
  final Map<String, dynamic>? data;
  final bool merged;
}

class RequestRemoveNode extends DashboardEvent {
  const RequestRemoveNode({required this.nodeId});
  final String nodeId;
}

class NodeSizeChangedEvent extends DashboardEvent {
  const NodeSizeChangedEvent(this.nodeId, this.size);
  final String nodeId;
  final Size size;
}

class RequestFixNodeCenter extends DashboardEvent {
  const RequestFixNodeCenter({required this.nodeId, required this.center});
  final String nodeId;
  final Offset center;
}

class RequestUpdateNodeCenter extends DashboardEvent {
  const RequestUpdateNodeCenter({required this.nodeId, required this.center});
  final String nodeId;
  final Offset center;
}
