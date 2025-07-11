// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../DashboardState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStateImpl _$$DashboardStateImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStateImpl(
      mindMap: MindMap.fromJson(json['mindMap'] as Map<String, dynamic>),
      minSpacing: (json['minSpacing'] as num?)?.toDouble() ?? 50.0,
      stepSpacing: (json['stepSpacing'] as num?)?.toDouble() ?? 20.0,
      radialAngleStart:
          (json['radialAngleStart'] as num?)?.toDouble() ?? -pi / 2,
    );

Map<String, dynamic> _$$DashboardStateImplToJson(
        _$DashboardStateImpl instance) =>
    <String, dynamic>{
      'mindMap': instance.mindMap,
      'minSpacing': instance.minSpacing,
      'stepSpacing': instance.stepSpacing,
      'radialAngleStart': instance.radialAngleStart,
    };
