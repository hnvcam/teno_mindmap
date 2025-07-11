// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../MindMap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MindMapImpl _$$MindMapImplFromJson(Map<String, dynamic> json) =>
    _$MindMapImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      nodes: (json['nodes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Node.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      nodeMetas: (json['nodeMetas'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, NodeMeta.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      data: json['data'] as Map<String, dynamic>? ?? const {},
      size: json['size'] == null
          ? Size.zero
          : const SizeJsonConverter()
              .fromJson(json['size'] as Map<String, double>),
    );

Map<String, dynamic> _$$MindMapImplToJson(_$MindMapImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'nodes': instance.nodes,
      'nodeMetas': instance.nodeMetas,
      'data': instance.data,
      'size': const SizeJsonConverter().toJson(instance.size),
    };
