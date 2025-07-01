import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../canvas/bloc/CanvasState.dart';
import '../models/Node.dart';
import 'bloc/DashboardBloc.dart';
import 'bloc/DashboardState.dart';
import 'widgets/DefaultConnectorRenderer.dart';
import 'widgets/DefaultNodeRenderer.dart';

class Dashboard extends StatelessWidget {
  static Widget defaultNodeRenderer(
    BuildContext context,
    Node node,
    NodeMeta nodeMeta,
  ) => DefaultNodeRenderer(node, meta: nodeMeta);

  static Widget defaultConnectorRenderer(
    BuildContext context,
    Node parent,
    Node child,
    NodeMeta parentMeta,
    NodeMeta childMeta,
  ) => DefaultConnectorRenderer(
    parent: parent,
    node: child,
    parentMeta: parentMeta,
    nodeMeta: childMeta,
  );

  const Dashboard({
    super.key,
    required this.dashboardState,
    this.nodeRender = defaultNodeRenderer,
    this.connectorRender = defaultConnectorRenderer,
  });

  final DashboardState dashboardState;
  final Widget Function(BuildContext context, Node node, NodeMeta meta)
  nodeRender;
  final Widget Function(
    BuildContext context,
    Node parent,
    Node child,
    NodeMeta parentMeta,
    NodeMeta childMeta,
  )
  connectorRender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(dashboardState),
      child: BlocBuilder<CanvasBloc, CanvasState>(
        builder: (context, canvasState) {
          return BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Stack(
                children: [
                  for (final node in state.nodes.values)
                    Builder(
                      builder: (context) {
                        final nodeMeta = state.nodeMetas[node.id]!;
                        final scaledPosition =
                            nodeMeta.position * canvasState.scale;
                        return Positioned(
                          left: canvasState.renderOffset.dx + scaledPosition.dx,
                          top: canvasState.renderOffset.dy + scaledPosition.dy,
                          child: Transform.scale(
                            alignment: Alignment.topLeft,
                            scale: canvasState.scale,
                            child: nodeRender(context, node, nodeMeta),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
