import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../models/MindMap.dart';

part 'generated/DashboardState.freezed.dart';
part 'generated/DashboardState.g.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  static final uuid = Uuid();

  static DashboardState withRoot(String title) =>
      DashboardState(mindMap: MindMap(id: uuid.v4(), title: title));

  const DashboardState._();

  const factory DashboardState({
    required MindMap mindMap,

    /// minimum space between parent's center and child's center
    /// excluding the Node.radius
    @Default(50.0) double minSpacing,

    /// if there is an overlapping on nodes, increase the space by this step
    @Default(20.0) double stepSpacing,

    /// Where the angle of the radial layout start, in radian.
    @Default(-pi / 2) double radialAngleStart,
  }) = _DashboardState;

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);
}
