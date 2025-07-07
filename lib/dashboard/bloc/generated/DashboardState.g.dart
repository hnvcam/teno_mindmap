// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../DashboardState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardState _$DashboardStateFromJson(Map<String, dynamic> json) =>
    _DashboardState(
      nodes:
          (json['nodes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Node.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      nodeMetas:
          (json['nodeMetas'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, NodeMeta.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      root:
          json['root'] == null
              ? null
              : Node.fromJson(json['root'] as Map<String, dynamic>),
      minSpacing: (json['minSpacing'] as num?)?.toDouble() ?? 50.0,
      stepSpacing: (json['stepSpacing'] as num?)?.toDouble() ?? 20.0,
      radialAngleStart:
          (json['radialAngleStart'] as num?)?.toDouble() ?? -pi / 2,
    );

Map<String, dynamic> _$DashboardStateToJson(_DashboardState instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'nodeMetas': instance.nodeMetas,
      'root': instance.root,
      'minSpacing': instance.minSpacing,
      'stepSpacing': instance.stepSpacing,
      'radialAngleStart': instance.radialAngleStart,
    };
