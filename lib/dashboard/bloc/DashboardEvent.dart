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

class RequestFixNodePosition extends DashboardEvent {
  const RequestFixNodePosition({required this.nodeId, required this.position});
  final String nodeId;
  final Offset position;
}
