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
  const RequestAddChildNode({required this.parentNodeId});
  final String parentNodeId;
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
