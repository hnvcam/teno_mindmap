import 'package:flutter/material.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class DefaultConnectorRenderer extends StatelessWidget {
  const DefaultConnectorRenderer({
    super.key,
    required this.parent,
    required this.node,
    required this.parentMeta,
    required this.nodeMeta,
  });

  final Node parent;
  final Node node;
  final NodeMeta parentMeta;
  final NodeMeta nodeMeta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rect = Rect.fromPoints(parentMeta.center, nodeMeta.center);
    final from = parentMeta.center - rect.topLeft;
    final to = nodeMeta.center - rect.topLeft;

    // print('Draw line from $from to $to in rect $rect');

    return SizedBox(
      width: rect.width,
      height: rect.height,
      child: CustomPaint(
        painter: _LinePainter(
          from,
          to,
          paintBrush:
              Paint()
                ..strokeWidth = 3.0
                ..color = theme.primaryColor
                ..style = PaintingStyle.stroke,
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  const _LinePainter(this.from, this.to, {required this.paintBrush});
  final Offset from;
  final Offset to;
  final Paint paintBrush;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(from, to, paintBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is _LinePainter &&
      (oldDelegate.from != from || oldDelegate.to != to);
}
