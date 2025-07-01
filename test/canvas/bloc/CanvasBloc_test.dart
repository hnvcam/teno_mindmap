import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasState.dart';

main() {
  group('Canvas panning', () {
    blocTest(
      'Move canvas by (100,100) at default scale (1.0)',
      build: () => CanvasBloc(),
      act: (bloc) => bloc.add(CanvasPanned(panDelta: Offset(100, 100))),
      expect: () => [const CanvasState(offset: Offset(100, 100))],
    );

    blocTest(
      'Move canvas by (100,100) at zoomed in scale (0.8)',
      build: () => CanvasBloc(),
      seed: () => const CanvasState(scale: 0.8),
      act: (bloc) => bloc.add(CanvasPanned(panDelta: Offset(100, 100))),

      /// Because the canvas now is bigger so the same delta will become bigger as well
      /// 100 / 0.8
      expect: () => [const CanvasState(scale: 0.8, offset: Offset(125, 125))],
    );

    blocTest(
      'Move canvas by (100, 100) at zoomed out scale (1.25)',
      build: () => CanvasBloc(),
      seed: () => const CanvasState(scale: 1.25),
      act: (bloc) => bloc.add(CanvasPanned(panDelta: Offset(100, 100))),
      expect: () => [const CanvasState(scale: 1.25, offset: Offset(80, 80))],
    );
  });

  group('Canvas zooming', () {
    blocTest(
      'Zoom in the canvas at root position (Offset.zero)',
      build: () => CanvasBloc(),
      seed: () => const CanvasState(scale: 1.0, offset: Offset.zero),
      act:
          (bloc) => bloc.add(
            /// the default zooming step is 0.1, so even we set 0.8, it still zooms by 0.9
            CanvasTransformed(scale: 0.9, pointerPosition: Offset.zero),
          ),
      expect: () => [const CanvasState(scale: 0.9, offset: Offset.zero)],
    );

    blocTest(
      'Zoom in the canvas at (100,100), current Canvas offset is zero',

      /// increase scaling step for round numbers.
      build: () => CanvasBloc(scalingStep: 0.2),
      seed: () => const CanvasState(scale: 1.0, offset: Offset.zero),
      act:
          (bloc) => bloc.add(
            CanvasTransformed(scale: 0.8, pointerPosition: Offset(100, 100)),
          ),
      expect: () => [const CanvasState(scale: 0.8, offset: Offset(25, 25))],
    );

    blocTest(
      'Zoom out the canvas at (100,100), current Canvas offset is zero',

      /// increase scaling step for round numbers.
      build: () => CanvasBloc(scalingStep: 0.25),
      seed: () => const CanvasState(scale: 1.0, offset: Offset.zero),
      act:
          (bloc) => bloc.add(
            CanvasTransformed(scale: 1.25, pointerPosition: Offset(100, 100)),
          ),
      expect: () => [const CanvasState(scale: 1.25, offset: Offset(-20, -20))],
    );

    blocTest(
      'Zoom in the canvas at (100,100), current Canvas offset is (100, 100)',

      /// increase scaling step for round numbers.
      build: () => CanvasBloc(scalingStep: 0.2),
      seed: () => const CanvasState(scale: 1.0, offset: Offset(100, 100)),
      act:
          (bloc) => bloc.add(
            CanvasTransformed(scale: 0.8, pointerPosition: Offset(100, 100)),
          ),
      expect: () => [const CanvasState(scale: 0.8, offset: Offset(125, 125))],
    );

    blocTest(
      'Zoom out the canvas at (100,100), current Canvas offset is (100, 100)',

      /// increase scaling step for round numbers.
      build: () => CanvasBloc(scalingStep: 0.25),
      seed: () => const CanvasState(scale: 1.0, offset: Offset(100, 100)),
      act:
          (bloc) => bloc.add(
            CanvasTransformed(scale: 1.25, pointerPosition: Offset(100, 100)),
          ),
      expect: () => [const CanvasState(scale: 1.25, offset: Offset(80, 80))],
    );
  });
}
