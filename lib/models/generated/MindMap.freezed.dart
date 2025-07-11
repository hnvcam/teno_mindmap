// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../MindMap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MindMap _$MindMapFromJson(Map<String, dynamic> json) {
  return _MindMap.fromJson(json);
}

/// @nodoc
mixin _$MindMap {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  Map<String, Node> get nodes => throw _privateConstructorUsedError;
  Map<String, NodeMeta> get nodeMetas => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @SizeJsonConverter()
  Size get size => throw _privateConstructorUsedError;

  /// Serializes this MindMap to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$MindMapImpl extends _MindMap {
  const _$MindMapImpl(
      {required this.id,
      required this.title,
      final Map<String, Node> nodes = const {},
      final Map<String, NodeMeta> nodeMetas = const {},
      final Map<String, dynamic> data = const {},
      @SizeJsonConverter() this.size = Size.zero})
      : _nodes = nodes,
        _nodeMetas = nodeMetas,
        _data = data,
        super._();

  factory _$MindMapImpl.fromJson(Map<String, dynamic> json) =>
      _$$MindMapImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final Map<String, Node> _nodes;
  @override
  @JsonKey()
  Map<String, Node> get nodes {
    if (_nodes is EqualUnmodifiableMapView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nodes);
  }

  final Map<String, NodeMeta> _nodeMetas;
  @override
  @JsonKey()
  Map<String, NodeMeta> get nodeMetas {
    if (_nodeMetas is EqualUnmodifiableMapView) return _nodeMetas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nodeMetas);
  }

  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  @SizeJsonConverter()
  final Size size;

  @override
  String toString() {
    return 'MindMap(id: $id, title: $title, nodes: $nodes, nodeMetas: $nodeMetas, data: $data, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MindMapImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality()
                .equals(other._nodeMetas, _nodeMetas) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_nodeMetas),
      const DeepCollectionEquality().hash(_data),
      size);

  @override
  Map<String, dynamic> toJson() {
    return _$$MindMapImplToJson(
      this,
    );
  }
}

abstract class _MindMap extends MindMap {
  const factory _MindMap(
      {required final String id,
      required final String title,
      final Map<String, Node> nodes,
      final Map<String, NodeMeta> nodeMetas,
      final Map<String, dynamic> data,
      @SizeJsonConverter() final Size size}) = _$MindMapImpl;
  const _MindMap._() : super._();

  factory _MindMap.fromJson(Map<String, dynamic> json) = _$MindMapImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  Map<String, Node> get nodes;
  @override
  Map<String, NodeMeta> get nodeMetas;
  @override
  Map<String, dynamic> get data;
  @override
  @SizeJsonConverter()
  Size get size;
}
