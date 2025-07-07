import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../LayoutService.dart';

part 'DashboardEvent.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static DashboardBloc read(BuildContext context) =>
      context.read<DashboardBloc>();

  static final _log = Logger('DashboardBloc');

  DashboardBloc(super.initialState) {
    on<RequestUpdateNodeCenter>(_onRequestUpdateNodeCenter);
    on<RequestAddChildNode>(_onRequestAddChildNode);
    on<RequestRebalancingNode>(_onRequestRebalancingNodes);
    on<NodeSizeChangedEvent>(_onNodeSizeChanged);
    on<RequestFixNodeCenter>(_onRequestFixNodePosition);
    on<RequestUpdateNodeMeta>(_onRequestUpdateChildNodeData);
    on<RequestRemoveNode>(_onRequestRemoveNode);

    _layoutService = LayoutService(state);
    _layoutService.listen(stream);
    _updateNodeCenterSubscription = _layoutService.stream.listen(add);
  }

  late LayoutService _layoutService;
  late StreamSubscription<RequestUpdateNodeCenter>
  _updateNodeCenterSubscription;

  @override
  Future<void> close() async {
    _updateNodeCenterSubscription.cancel();
    _layoutService.close();
    super.close();
  }

  FutureOr<void> _onRequestAddChildNode(
    RequestAddChildNode event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.addNode(parentId: event.parentNodeId, nodeMeta: event.nodeMeta));
  }

  FutureOr<void> _onRequestRebalancingNodes(
    RequestRebalancingNode event,
    Emitter<DashboardState> emit,
  ) {
    _layoutService.addTask(nodeId: event.nodeId, forced: event.forced);
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

  FutureOr<void> _onRequestUpdateNodeCenter(
    RequestUpdateNodeCenter event,
    Emitter<DashboardState> emit,
  ) {
    final nodeMeta = state.getNodeMetaById(event.nodeId);
    if (nodeMeta.isPositionLocked) {
      return null;
    }
    emit(
      state.updateNode(event.nodeId, nodeMeta.copyWith(center: event.center)),
    );
  }

  FutureOr<void> _onRequestUpdateChildNodeData(
    RequestUpdateNodeMeta event,
    Emitter<DashboardState> emit,
  ) {
    final nodeMeta = state.getNodeMetaById(event.nodeId);
    emit(
      state.updateNode(
        event.nodeId,
        nodeMeta.copyWith(
          title:
              event.title?.isNotEmpty == true ? event.title! : nodeMeta.title,
          data:
              event.data?.isNotEmpty == true
                  ? (event.merged
                      ? {...nodeMeta.data, ...event.data!}
                      : event.data!)
                  : nodeMeta.data,
        ),
      ),
    );
  }

  FutureOr<void> _onRequestRemoveNode(
    RequestRemoveNode event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.removeNode(event.nodeId));
  }
}
