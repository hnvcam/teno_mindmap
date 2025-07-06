import 'package:flutter/material.dart';

import '../../canvas/bloc/CanvasBloc.dart';

class ConnectorWrapper extends StatelessWidget {
  const ConnectorWrapper({
    super.key,
    required this.from,
    required this.to,
    required this.child,
  });

  final Offset from;
  final Offset to;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final canvasState = CanvasBloc.read(context).state;

    final rect = Rect.fromPoints(
      from * canvasState.scale,
      to * canvasState.scale,
    );
    return Positioned(
      left: canvasState.renderOffset.dx + rect.left,
      top: canvasState.renderOffset.dy + rect.top,
      width: rect.width,
      height: rect.height,
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: canvasState.scale,
        child: child,
      ),
    );
  }
}
