// ----------------------------------------------------
// The Grid Canvas Widget
// ----------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/CanvasActivityDetector.dart';

import 'bloc/CanvasBloc.dart';
import 'bloc/CanvasState.dart';

class GridCanvas extends StatelessWidget {
  const GridCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return CanvasActivityDetector(
      child: BlocBuilder<CanvasBloc, CanvasState>(
        builder: (context, state) {
          return CustomPaint(
            size: Size.infinite,
            painter: GridPainter(scale: state.scale, offset: state.offset),
          );
        },
      ),
    );
  }
}

// ----------------------------------------------------
// The Grid Painter
// ----------------------------------------------------
class GridPainter extends CustomPainter {
  final double scale;
  final Offset offset;

  GridPainter({required this.scale, required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 1.0;

    const double gridSize = 100.0;

    // Calculate the visible area based on the canvas size, scale, and offset
    final double left = -offset.dx;
    final double top = -offset.dy;
    final double right = left + size.width / scale;
    final double bottom = top + size.height / scale;

    // Calculate the start and end indices for drawing lines to optimize performance
    final int startX = (left / gridSize).floor();
    final int endX = (right / gridSize).ceil();
    final int startY = (top / gridSize).floor();
    final int endY = (bottom / gridSize).ceil();

    // Draw vertical lines
    for (int i = startX; i <= endX; i++) {
      final double x = i * gridSize;
      // Convert world coordinates to screen coordinates before drawing
      final double screenX = (x + offset.dx) * scale;
      canvas.drawLine(Offset(screenX, 0), Offset(screenX, size.height), paint);
    }

    // Draw horizontal lines
    for (int i = startY; i <= endY; i++) {
      final double y = i * gridSize;
      // Convert world coordinates to screen coordinates before drawing
      final double screenY = (y + offset.dy) * scale;
      canvas.drawLine(Offset(0, screenY), Offset(size.width, screenY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.scale != scale || oldDelegate.offset != offset;
  }
}
