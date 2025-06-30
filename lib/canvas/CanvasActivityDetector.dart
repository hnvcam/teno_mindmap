import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';

class CanvasActivityDetector extends StatefulWidget {
  final Widget child;
  final double _minScale;
  final double _maxScale;
  final double _scalingStep;
  final Duration _scalingDelay;

  CanvasActivityDetector({
    super.key,
    required this.child,
    double minScale = 0.1,
    double maxScale = 10,
    double scalingStep = 0.1,
    int scalingFps = 60,
  }) : _minScale = minScale.clamp(0.01, 1),
       _maxScale = maxScale.clamp(1, 100),
       _scalingStep = scalingStep.clamp(0.01, 0.99),
       _scalingDelay = Duration(
         milliseconds: (1000 / scalingFps.clamp(1, 120)).round(),
       );

  @override
  State<CanvasActivityDetector> createState() => _CanvasActivityDetectorState();
}

class _CanvasActivityDetectorState extends State<CanvasActivityDetector> {
  Duration _lastScalingTimeStamp = Duration.zero;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScaleEvent) {
          _handleScale(context, event.scale, event.delta, event.timeStamp);
        }
      },
      child: GestureDetector(
        onScaleUpdate: (details) {
          if (details.scale == 1) {
            CanvasBloc.read(
              context,
            ).add(CanvasPanned(panDelta: details.focalPointDelta));
          } else {
            _handleScale(
              context,
              details.scale,
              details.focalPointDelta,
              details.sourceTimeStamp ?? Duration.zero,
            );
          }
        },
        // Set the supported devices to all devices.
        supportedDevices: const {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
          PointerDeviceKind.trackpad,
        },
        child: widget.child,
      ),
    );
  }

  void _handleScale(
    BuildContext context,
    double scale,
    Offset delta,
    Duration timeStamp,
  ) {
    if (timeStamp - _lastScalingTimeStamp < widget._scalingDelay) {
      return;
    }
    _lastScalingTimeStamp = timeStamp;
    final currentState = CanvasBloc.read(context).state;
    double effectiveScale = 1.0;
    if (scale > 1) {
      effectiveScale = 1 + widget._scalingStep;
    } else if (scale < 1) {
      effectiveScale = 1 - widget._scalingStep;
    }
    final newScale = clampDouble(
      effectiveScale * currentState.scale,
      widget._minScale,
      widget._maxScale,
    );
    final newOffset = delta / newScale;
    CanvasBloc.read(
      context,
    ).add(CanvasTransformed(scale: newScale, offset: newOffset));
  }
}
