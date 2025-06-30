import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CanvasState.dart';

part 'CanvasEvent.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  static CanvasBloc read(BuildContext context) => context.read<CanvasBloc>();

  // The initial state is now cleaner thanks to @Default in freezed
  CanvasBloc() : super(const CanvasState()) {
    on<CanvasPanned>(_onPanned);
    on<CanvasTransformed>(_onTransformed);
  }

  FutureOr<void> _onPanned(CanvasPanned event, Emitter<CanvasState> emit) {
    emit(state.copyWith(offset: state.offset + (event.panDelta / state.scale)));
  }

  FutureOr<void> _onTransformed(
    CanvasTransformed event,
    Emitter<CanvasState> emit,
  ) {
    emit(state.copyWith(scale: event.scale, offset: event.offset));
  }
}
