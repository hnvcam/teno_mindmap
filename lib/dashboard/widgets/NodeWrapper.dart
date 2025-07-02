import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasState.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class NodeWrapper extends StatelessWidget {
  const NodeWrapper({
    super.key,
    required this.onNodeTap,
    required this.onNodeSecondaryTap,
    required this.child,
    required this.node,
    required this.nodeMeta,
  });

  final Widget child;
  final Node node;
  final NodeMeta nodeMeta;
  final void Function(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  })
  onNodeTap;
  final void Function(
    BuildContext context, {
    required Node node,
    required NodeMeta nodeMeta,
    required Offset tapLocation,
  })
  onNodeSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanvasBloc, CanvasState>(
      buildWhen:
          (prev, curr) =>
              prev.scale != curr.scale || prev.offset != curr.offset,
      builder: (context, state) {
        final scaledPosition = nodeMeta.position * state.scale;
        var tapLocation = Offset.zero;
        var secondaryTapLocation = Offset.zero;
        return Positioned(
          left: state.renderOffset.dx + scaledPosition.dx,
          top: state.renderOffset.dy + scaledPosition.dy,
          child: Transform.scale(
            alignment: Alignment.topLeft,
            scale: state.scale,
            // we need context here for the context menu
            child: GestureDetector(
              onTapDown: (details) => tapLocation = details.globalPosition,
              onSecondaryTapDown:
                  (details) => secondaryTapLocation = details.globalPosition,
              onTap:
                  () => onNodeTap(
                    context,
                    node: node,
                    nodeMeta: nodeMeta,
                    tapLocation: tapLocation,
                  ),
              onSecondaryTap:
                  () => onNodeSecondaryTap(
                    context,
                    node: node,
                    nodeMeta: nodeMeta,
                    tapLocation: secondaryTapLocation,
                  ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
