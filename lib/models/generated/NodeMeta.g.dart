// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../NodeMeta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NodeMeta _$NodeMetaFromJson(Map<String, dynamic> json) => _NodeMeta(
  id: json['id'] as String?,
  title: json['title'] as String,
  center:
      json['center'] == null
          ? Offset.zero
          : const OffsetJsonConverter().fromJson(
            json['center'] as Map<String, double>,
          ),
  isPositionLocked: json['isPositionLocked'] as bool? ?? false,
  size:
      json['size'] == null
          ? Size.zero
          : const SizeJsonConverter().fromJson(
            json['size'] as Map<String, double>,
          ),
  type: json['type'] as String? ?? 'default',
  data: json['data'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$NodeMetaToJson(_NodeMeta instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'center': const OffsetJsonConverter().toJson(instance.center),
  'isPositionLocked': instance.isPositionLocked,
  'size': const SizeJsonConverter().toJson(instance.size),
  'type': instance.type,
  'data': instance.data,
};
