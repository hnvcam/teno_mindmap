import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';

class CanvasActivityDetector extends StatefulWidget {
  final Widget child;

  CanvasActivityDetector({super.key, required this.child, int scalingFps = 60})
    : _scalingDelay = Duration(
        milliseconds: (1000 / scalingFps.clamp(1, 120)).round(),
      );

  /// This detector will be responsible for how fast we can zoom in and out (behavior)
  /// But the actual zoom level is controlled by the bloc (business logic)
  final Duration _scalingDelay;

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
          _handleScale(
            context,
            event.scale,
            // because this CanvasActivityDetector and canvas share the same coordinate.
            event.localPosition,
            event.timeStamp,
          );
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
              // because this CanvasActivityDetector and canvas share the same coordinate.
              details.localFocalPoint,
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
    Offset pointerPosition,
    Duration timeStamp,
  ) {
    if (timeStamp - _lastScalingTimeStamp < widget._scalingDelay) {
      return;
    }
    _lastScalingTimeStamp = timeStamp;

    CanvasBloc.read(
      context,
    ).add(CanvasTransformed(scale: scale, pointerPosition: pointerPosition));
  }
}
