import 'dart:math';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teno_mindmap/converters/OffsetJsonConverter.dart';
import 'package:teno_mindmap/converters/SizeJsonConverter.dart';

part 'generated/NodeMeta.freezed.dart';
part 'generated/NodeMeta.g.dart';

@freezed
sealed class NodeMeta with _$NodeMeta {
  const NodeMeta._();

  const factory NodeMeta({
    String? id,
    required String title,
    @OffsetJsonConverter() @Default(Offset.zero) Offset position,
    @Default(false) bool isPositionLocked,
    @SizeJsonConverter() @Default(Size.zero) Size size,
    @Default('default') String type,
    @Default({}) Map<String, dynamic> data,
  }) = _NodeMeta;

  factory NodeMeta.fromJson(Map<String, dynamic> json) =>
      _$NodeMetaFromJson(json);

  double get radius =>
      sqrt(size.width * size.width + size.height * size.height) / 2;

  Offset get center => (position & size).center;
}
