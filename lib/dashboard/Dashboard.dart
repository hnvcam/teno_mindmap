import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import 'package:teno_mindmap/dashboard/widgets/NodeWrapper.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../models/Node.dart';
import 'bloc/DashboardBloc.dart';
import 'bloc/DashboardState.dart';
import 'widgets/DefaultConnectorRenderer.dart';
import 'widgets/DefaultNodeRenderer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    required this.dashboardState,
    this.nodeRender,
    this.connectorRender,
    this.onNodeTap,
    this.onNodeSecondaryTap,
  });

  final DashboardState dashboardState;
  final Widget Function(BuildContext context, Node node, NodeMeta meta)?
  nodeRender;
  final Widget Function(
    BuildContext context,
    Node parent,
    Node child,
    NodeMeta parentMeta,
    NodeMeta childMeta,
  )?
  connectorRender;
  final void Function(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  })?
  onNodeTap;
  final void Function(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  })?
  onNodeSecondaryTap;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final nodeRender = widget.nodeRender ?? _defaultNodeRenderer;
    final connectorRender = widget.connectorRender ?? _defaultConnectorRenderer;
    final onNodeTap = widget.onNodeTap ?? _defaultOnNodeTap;
    final onNodeSecondaryTap = widget.onNodeSecondaryTap ?? _defaultOnNodeTap;

    return BlocProvider(
      create: (_) => DashboardBloc(widget.dashboardState),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Stack(
            children: [
              for (final node in state.nodes.values)
                NodeWrapper(
                  node: node,
                  nodeMeta: state.getNodeMeta(node),
                  onNodeTap: onNodeTap,
                  onNodeSecondaryTap: onNodeSecondaryTap,
                  child: nodeRender(context, node, state.getNodeMeta(node)),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _defaultNodeRenderer(
    BuildContext context,
    Node node,
    NodeMeta nodeMeta,
  ) => DefaultNodeRenderer(node: node, nodeMeta: nodeMeta);

  Widget _defaultConnectorRenderer(
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

  void _defaultOnNodeTap(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  }) {
    final renderObject = context.findRenderObject() as RenderBox;
    final radius = max(
      renderObject.paintBounds.width,
      renderObject.paintBounds.height,
    );
    StarMenuOverlay.displayStarMenu(
      context,
      StarMenu(
        params: StarMenuParameters(
          shape: MenuShape.circle,
          circleShapeParams: CircleShapeParams(
            startAngle: -90,
            endAngle: 90,
            radiusY: radius,
            radiusX: radius,
          ),
        ),
        items: [
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
        ],
        parentContext: context,
      ),
    );
  }
}
