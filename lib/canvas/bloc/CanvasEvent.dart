part of 'CanvasBloc.dart';

sealed class CanvasEvent {
  const CanvasEvent();
}

class CanvasPanned extends CanvasEvent {
  final Offset panDelta;
  const CanvasPanned({required this.panDelta});
}

class CanvasTransformed extends CanvasEvent {
  final double scale;
  final Offset offset;
  const CanvasTransformed({required this.scale, required this.offset});
}
