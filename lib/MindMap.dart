import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teno_mindmap/canvas/GridCanvas.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/l10n/generated/app_localizations.dart';

import 'dashboard/Dashboard.dart';

class MindMap extends StatelessWidget {
  static final localizationDelegate = AppLocalizations.delegate;

  const MindMap({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }

    return BlocProvider(
      create: (_) => CanvasBloc(),
      child: ClipRect(
        child: Stack(
          children: [
            Positioned.fill(child: GridCanvas()),
            Positioned.fill(
              child: Dashboard(dashboardState: DashboardState.empty),
            ),
          ],
        ),
      ),
    );
  }
}
