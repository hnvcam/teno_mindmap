import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/CanvasState.freezed.dart';

@freezed
sealed class CanvasState with _$CanvasState {
  const factory CanvasState({
    // @Default provides default values for the initial state.
    @Default(1.0) double scale,
    @Default(Offset.zero) Offset offset,
  }) = _CanvasState;
}
