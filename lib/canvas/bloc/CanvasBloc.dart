import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CanvasState.dart';

part 'CanvasEvent.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  static CanvasBloc read(BuildContext context) => context.read<CanvasBloc>();

  // The initial state is now cleaner thanks to @Default in freezed
  CanvasBloc({
    double minScale = 0.1,
    double maxScale = 10,
    double scalingStep = 0.1,
  }) : _minScale = minScale.clamp(0.01, 1),
       _maxScale = maxScale.clamp(1, 100),
       _scalingStep = scalingStep.clamp(0.01, 0.99),
       super(const CanvasState()) {
    on<CanvasPanned>(_onPanned);
    on<CanvasTransformed>(_onTransformed);
  }

  final double _minScale;
  final double _maxScale;
  final double _scalingStep;

  FutureOr<void> _onPanned(CanvasPanned event, Emitter<CanvasState> emit) {
    emit(state.copyWith(offset: state.offset + (event.panDelta / state.scale)));
  }

  /// The idea is when we zoom in and out at the position of pointer,
  /// then that position of the canvas should not be moved.
  FutureOr<void> _onTransformed(
    CanvasTransformed event,
    Emitter<CanvasState> emit,
  ) {
    double effectiveScale = 1.0;
    if (event.scale > 1) {
      effectiveScale = 1 + _scalingStep;
    } else if (event.scale < 1) {
      effectiveScale = 1 - _scalingStep;
    }
    effectiveScale = clampDouble(
      effectiveScale * state.scale,
      _minScale,
      _maxScale,
    );

    final pointerRenderCanvasOffset =
        event.pointerPosition - state.renderOffset;
    final pointerRenderDeltaBetweenScale =
        pointerRenderCanvasOffset / state.scale -
        pointerRenderCanvasOffset / effectiveScale;

    /// state.renderOffset / effectiveScale is the same root (Offset.zero) on new scale on rendering.
    final effectiveOffset =
        state.renderOffset / effectiveScale - pointerRenderDeltaBetweenScale;
    emit(state.copyWith(scale: effectiveScale, offset: effectiveOffset));
  }
}
