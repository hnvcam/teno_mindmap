import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/GridCanvas.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';

class MindMap extends StatelessWidget {
  const MindMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CanvasBloc(), child: GridCanvas());
  }
}
