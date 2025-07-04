// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Node _$NodeFromJson(Map<String, dynamic> json) => _Node(
  id: json['id'] as String,
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  parentId: json['parentId'] as String?,
);

Map<String, dynamic> _$NodeToJson(_Node instance) => <String, dynamic>{
  'id': instance.id,
  'children': instance.children,
  'parentId': instance.parentId,
};
