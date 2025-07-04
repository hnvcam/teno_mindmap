part of 'DashboardBloc.dart';

sealed class DashboardEvent {
  const DashboardEvent();
}

class RequestRebalancingNodes extends DashboardEvent {
  const RequestRebalancingNodes({required this.node, this.forced = false});

  /// force = true means we ignore the isPositionLocked flag of NodeMeta
  final bool forced;
  final Node node;
}

class RequestAddChildNode extends DashboardEvent {
  const RequestAddChildNode({
    required this.parentNode,
    required this.parentNodeMeta,
    required this.parentSize,
  });

  final Node parentNode;
  final NodeMeta parentNodeMeta;
  final Size parentSize;
}
