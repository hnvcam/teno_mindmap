// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../NodeMeta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodeMeta _$NodeMetaFromJson(Map<String, dynamic> json) {
  return _NodeMeta.fromJson(json);
}

/// @nodoc
mixin _$NodeMeta {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @OffsetJsonConverter()
  Offset get center => throw _privateConstructorUsedError;
  bool get isPositionLocked => throw _privateConstructorUsedError;
  @SizeJsonConverter()
  Size get size => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this NodeMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NodeMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NodeMetaCopyWith<NodeMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeMetaCopyWith<$Res> {
  factory $NodeMetaCopyWith(NodeMeta value, $Res Function(NodeMeta) then) =
      _$NodeMetaCopyWithImpl<$Res, NodeMeta>;
  @useResult
  $Res call(
      {String? id,
      String title,
      @OffsetJsonConverter() Offset center,
      bool isPositionLocked,
      @SizeJsonConverter() Size size,
      Map<String, dynamic> data});
}

/// @nodoc
class _$NodeMetaCopyWithImpl<$Res, $Val extends NodeMeta>
    implements $NodeMetaCopyWith<$Res> {
  _$NodeMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NodeMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? center = null,
    Object? isPositionLocked = null,
    Object? size = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
      isPositionLocked: null == isPositionLocked
          ? _value.isPositionLocked
          : isPositionLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeMetaImplCopyWith<$Res>
    implements $NodeMetaCopyWith<$Res> {
  factory _$$NodeMetaImplCopyWith(
          _$NodeMetaImpl value, $Res Function(_$NodeMetaImpl) then) =
      __$$NodeMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      @OffsetJsonConverter() Offset center,
      bool isPositionLocked,
      @SizeJsonConverter() Size size,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$NodeMetaImplCopyWithImpl<$Res>
    extends _$NodeMetaCopyWithImpl<$Res, _$NodeMetaImpl>
    implements _$$NodeMetaImplCopyWith<$Res> {
  __$$NodeMetaImplCopyWithImpl(
      _$NodeMetaImpl _value, $Res Function(_$NodeMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of NodeMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? center = null,
    Object? isPositionLocked = null,
    Object? size = null,
    Object? data = null,
  }) {
    return _then(_$NodeMetaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
      isPositionLocked: null == isPositionLocked
          ? _value.isPositionLocked
          : isPositionLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeMetaImpl extends _NodeMeta {
  const _$NodeMetaImpl(
      {this.id,
      required this.title,
      @OffsetJsonConverter() this.center = Offset.zero,
      this.isPositionLocked = false,
      @SizeJsonConverter() this.size = Size.zero,
      final Map<String, dynamic> data = const {}})
      : _data = data,
        super._();

  factory _$NodeMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeMetaImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  @JsonKey()
  @OffsetJsonConverter()
  final Offset center;
  @override
  @JsonKey()
  final bool isPositionLocked;
  @override
  @JsonKey()
  @SizeJsonConverter()
  final Size size;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'NodeMeta(id: $id, title: $title, center: $center, isPositionLocked: $isPositionLocked, size: $size, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeMetaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.isPositionLocked, isPositionLocked) ||
                other.isPositionLocked == isPositionLocked) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, center,
      isPositionLocked, size, const DeepCollectionEquality().hash(_data));

  /// Create a copy of NodeMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeMetaImplCopyWith<_$NodeMetaImpl> get copyWith =>
      __$$NodeMetaImplCopyWithImpl<_$NodeMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeMetaImplToJson(
      this,
    );
  }
}

abstract class _NodeMeta extends NodeMeta {
  const factory _NodeMeta(
      {final String? id,
      required final String title,
      @OffsetJsonConverter() final Offset center,
      final bool isPositionLocked,
      @SizeJsonConverter() final Size size,
      final Map<String, dynamic> data}) = _$NodeMetaImpl;
  const _NodeMeta._() : super._();

  factory _NodeMeta.fromJson(Map<String, dynamic> json) =
      _$NodeMetaImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  @OffsetJsonConverter()
  Offset get center;
  @override
  bool get isPositionLocked;
  @override
  @SizeJsonConverter()
  Size get size;
  @override
  Map<String, dynamic> get data;

  /// Create a copy of NodeMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NodeMetaImplCopyWith<_$NodeMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
