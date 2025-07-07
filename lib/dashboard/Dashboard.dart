import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/dashboard/widgets/ConnectorWrapper.dart';
import 'package:teno_mindmap/dashboard/widgets/IconTextButton.dart';
import 'package:teno_mindmap/dashboard/widgets/NodeWrapper.dart';
import 'package:teno_mindmap/l10n/generated/app_localizations.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../canvas/bloc/CanvasState.dart';
import '../constants.dart';
import '../models/Node.dart';
import 'bloc/DashboardBloc.dart';
import 'bloc/DashboardState.dart';
import 'widgets/DefaultConnectorRenderer.dart';
import 'widgets/DefaultNodeRenderer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    this.nodeRender,
    this.connectorRender,
    this.onNodeTap,
    this.onNodeSecondaryTap,
  });

  final Widget Function(BuildContext context, Node node, NodeMeta meta)?
  nodeRender;
  final Widget Function(
    BuildContext context, {
    required Node node,
    required Node parentNode,
    required NodeMeta parentMeta,
    required NodeMeta nodeMeta,
  })?
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_centerCanvas);
  }

  @override
  Widget build(BuildContext context) {
    final nodeRender = widget.nodeRender ?? _defaultNodeRenderer;
    final connectorRender = widget.connectorRender ?? _defaultConnectorRenderer;
    final onNodeTap = widget.onNodeTap ?? _defaultOnNodeTap;
    final onNodeSecondaryTap = widget.onNodeSecondaryTap ?? _defaultOnNodeTap;

    return BlocBuilder<CanvasBloc, CanvasState>(
      builder: (context, state) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            final List<Widget> connectors = [];
            for (final node in state.nodes.values) {
              if (node.isRoot) {
                continue;
              }
              final nodeMeta = state.getNodeMeta(node);
              final parentMeta = state.getNodeMetaById(node.parentId!);
              connectors.add(
                ConnectorWrapper(
                  from: parentMeta.center,
                  to: nodeMeta.center,
                  child: connectorRender(
                    context,
                    node: node,
                    parentNode: state.parentOf(node)!,
                    nodeMeta: nodeMeta,
                    parentMeta: parentMeta,
                  ),
                ),
              );
            }

            return Stack(
              children: [
                ...connectors,
                for (final node in state.nodes.values)
                  NodeWrapper(
                    key: ValueKey(node.id),
                    node: node,
                    nodeMeta: state.getNodeMeta(node),
                    onNodeTap: onNodeTap,
                    onNodeSecondaryTap: onNodeSecondaryTap,
                    child: nodeRender(context, node, state.getNodeMeta(node)),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _defaultNodeRenderer(
    BuildContext context,
    Node node,
    NodeMeta nodeMeta,
  ) => DefaultNodeRenderer(node: node, nodeMeta: nodeMeta);

  Widget _defaultConnectorRenderer(
    BuildContext context, {
    required Node node,
    required Node parentNode,
    required NodeMeta parentMeta,
    required NodeMeta nodeMeta,
  }) => DefaultConnectorRenderer(
    parent: parentNode,
    node: node,
    parentMeta: parentMeta,
    nodeMeta: nodeMeta,
  );

  void _defaultOnNodeTap(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  }) {
    final renderBox = context.findRenderObject() as RenderBox;
    final radius =
        max(renderBox.size.width, renderBox.size.height) / 2 +
        min(renderBox.size.width, renderBox.size.height);

    final l10n = AppLocalizations.of(context)!;
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
        onItemTapped: (index, controller) {
          controller.closeMenu?.call();
        },
        items: [
          IconTextButton(
            icon: Icons.add,
            text: l10n.addChild,
            onPressed:
                () => DashboardBloc.read(context).add(
                  RequestAddChildNode(
                    parentNodeId: node.id,
                    nodeMeta: NodeMeta(
                      title: '${nodeMeta.title}_${node.children.length}',
                    ),
                  ),
                ),
          ),
          IconTextButton(
            icon: Icons.edit,
            text: l10n.edit,
            onPressed:
                () => DashboardBloc.read(context).add(
                  RequestUpdateNodeMeta(
                    nodeId: node.id,
                    data: {nodeEditingKey: true},
                  ),
                ),
          ),
          if (!node.isRoot)
            IconTextButton(
              icon: Icons.delete,
              text: l10n.delete,
              onPressed:
                  () => DashboardBloc.read(
                    context,
                  ).add(RequestRemoveNode(nodeId: node.id)),
            ),
        ],
        parentContext: context,
      ),
    );
  }

  void _centerCanvas(Duration timeStamp) {
    final renderObject = context.findRenderObject() as RenderBox;
    final size = renderObject.size;
    CanvasBloc.read(
      context,
    ).add(CanvasPanned(panDelta: Offset(size.width / 2, size.height / 2)));
  }
}
