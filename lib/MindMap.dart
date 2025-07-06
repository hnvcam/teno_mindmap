import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/GridCanvas.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/l10n/generated/app_localizations.dart';

import 'dashboard/Dashboard.dart';
import 'dashboard/bloc/DashboardBloc.dart';

class MindMap extends StatelessWidget {
  static final localizationDelegate = AppLocalizations.delegate;

  const MindMap({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CanvasBloc()),
        BlocProvider(
          create:
              (_) => DashboardBloc(DashboardState.empty.newRoot(title: title)),
        ),
      ],
      child: BlocProvider(
        create: (_) => CanvasBloc(),
        child: ClipRect(
          child: Stack(
            children: [
              Positioned.fill(child: GridCanvas()),
              Positioned.fill(child: Dashboard()),
            ],
          ),
        ),
      ),
    );
  }
}
