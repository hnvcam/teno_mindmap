import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasState.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class NodeWrapper extends StatefulWidget {
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
  State<NodeWrapper> createState() => _NodeWrapperState();
}

class _NodeWrapperState extends State<NodeWrapper> {
  final _wrapperKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onSizeChanged(SizeChangedLayoutNotification());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanvasBloc, CanvasState>(
      buildWhen:
          (prev, curr) =>
              prev.scale != curr.scale || prev.offset != curr.offset,
      builder: (context, state) {
        final scaledPosition =
            (widget.nodeMeta.center -
                Offset(
                  widget.nodeMeta.size.width / 2,
                  widget.nodeMeta.size.height / 2,
                )) *
            state.scale;
        var tapLocation = Offset.zero;
        var secondaryTapLocation = Offset.zero;
        return NotificationListener<SizeChangedLayoutNotification>(
          onNotification: _onSizeChanged,
          child: Positioned(
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
                    () => widget.onNodeTap(
                      context,
                      node: widget.node,
                      nodeMeta: widget.nodeMeta,
                      tapLocation: tapLocation,
                    ),
                onSecondaryTap:
                    () => widget.onNodeSecondaryTap(
                      context,
                      node: widget.node,
                      nodeMeta: widget.nodeMeta,
                      tapLocation: secondaryTapLocation,
                    ),
                child: SizeChangedLayoutNotifier(
                  key: _wrapperKey,
                  child: widget.child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _onSizeChanged(SizeChangedLayoutNotification notification) {
    final keyContext = _wrapperKey.currentContext;
    if (keyContext == null) return false;
    final renderBox = keyContext.findRenderObject() as RenderBox;
    final size = renderBox.size;
    DashboardBloc.read(context).add(NodeSizeChangedEvent(widget.node.id, size));
    return true;
  }
}
