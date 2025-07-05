import 'package:flutter/material.dart';
import 'package:teno_debug/teno_debug.dart';
import 'package:teno_mindmap/canvas/bloc/CanvasBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/teno_mindmap.dart';

void main() {
  debugBloc([CanvasBloc, DashboardBloc]);
  debugLog(['DashboardBloc']);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp(
      title: 'Teno Mind Map Editor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: colorScheme,
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: withStates(colorScheme.primary),
            foregroundColor: withStates(colorScheme.onPrimary),
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [MindMap.localizationDelegate],
    );
  }
}

WidgetStateProperty<T> withStates<T>(
  T defaultState, [
  Map<WidgetState, T>? stateMap,
]) => WidgetStateProperty.resolveWith((states) {
  final resolvedState =
      stateMap?.keys.where((state) => states.contains(state)).firstOrNull;
  if (resolvedState != null) {
    return stateMap![resolvedState] as T;
  }
  return defaultState;
});

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mind Map Canvas')),
      body: const MindMap(),
    );
  }
}
