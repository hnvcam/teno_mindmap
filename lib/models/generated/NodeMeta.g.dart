// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../NodeMeta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeMetaImpl _$$NodeMetaImplFromJson(Map<String, dynamic> json) =>
    _$NodeMetaImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      center: json['center'] == null
          ? Offset.zero
          : const OffsetJsonConverter()
              .fromJson(json['center'] as Map<String, double>),
      isPositionLocked: json['isPositionLocked'] as bool? ?? false,
      size: json['size'] == null
          ? Size.zero
          : const SizeJsonConverter()
              .fromJson(json['size'] as Map<String, double>),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$NodeMetaImplToJson(_$NodeMetaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'center': const OffsetJsonConverter().toJson(instance.center),
      'isPositionLocked': instance.isPositionLocked,
      'size': const SizeJsonConverter().toJson(instance.size),
      'data': instance.data,
    };
