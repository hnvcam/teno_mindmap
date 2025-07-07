// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../NodeMeta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NodeMeta {

 String? get id; String get title;@OffsetJsonConverter() Offset get center; bool get isPositionLocked;@SizeJsonConverter() Size get size; Map<String, dynamic> get data;
/// Create a copy of NodeMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeMetaCopyWith<NodeMeta> get copyWith => _$NodeMetaCopyWithImpl<NodeMeta>(this as NodeMeta, _$identity);

  /// Serializes this NodeMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.center, center) || other.center == center)&&(identical(other.isPositionLocked, isPositionLocked) || other.isPositionLocked == isPositionLocked)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,center,isPositionLocked,size,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NodeMeta(id: $id, title: $title, center: $center, isPositionLocked: $isPositionLocked, size: $size, data: $data)';
}


}

/// @nodoc
abstract mixin class $NodeMetaCopyWith<$Res>  {
  factory $NodeMetaCopyWith(NodeMeta value, $Res Function(NodeMeta) _then) = _$NodeMetaCopyWithImpl;
@useResult
$Res call({
 String? id, String title,@OffsetJsonConverter() Offset center, bool isPositionLocked,@SizeJsonConverter() Size size, Map<String, dynamic> data
});




}
/// @nodoc
class _$NodeMetaCopyWithImpl<$Res>
    implements $NodeMetaCopyWith<$Res> {
  _$NodeMetaCopyWithImpl(this._self, this._then);

  final NodeMeta _self;
  final $Res Function(NodeMeta) _then;

/// Create a copy of NodeMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? center = null,Object? isPositionLocked = null,Object? size = null,Object? data = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,isPositionLocked: null == isPositionLocked ? _self.isPositionLocked : isPositionLocked // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NodeMeta extends NodeMeta {
  const _NodeMeta({this.id, required this.title, @OffsetJsonConverter() this.center = Offset.zero, this.isPositionLocked = false, @SizeJsonConverter() this.size = Size.zero, final  Map<String, dynamic> data = const {}}): _data = data,super._();
  factory _NodeMeta.fromJson(Map<String, dynamic> json) => _$NodeMetaFromJson(json);

@override final  String? id;
@override final  String title;
@override@JsonKey()@OffsetJsonConverter() final  Offset center;
@override@JsonKey() final  bool isPositionLocked;
@override@JsonKey()@SizeJsonConverter() final  Size size;
 final  Map<String, dynamic> _data;
@override@JsonKey() Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of NodeMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NodeMetaCopyWith<_NodeMeta> get copyWith => __$NodeMetaCopyWithImpl<_NodeMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NodeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.center, center) || other.center == center)&&(identical(other.isPositionLocked, isPositionLocked) || other.isPositionLocked == isPositionLocked)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,center,isPositionLocked,size,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NodeMeta(id: $id, title: $title, center: $center, isPositionLocked: $isPositionLocked, size: $size, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NodeMetaCopyWith<$Res> implements $NodeMetaCopyWith<$Res> {
  factory _$NodeMetaCopyWith(_NodeMeta value, $Res Function(_NodeMeta) _then) = __$NodeMetaCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title,@OffsetJsonConverter() Offset center, bool isPositionLocked,@SizeJsonConverter() Size size, Map<String, dynamic> data
});




}
/// @nodoc
class __$NodeMetaCopyWithImpl<$Res>
    implements _$NodeMetaCopyWith<$Res> {
  __$NodeMetaCopyWithImpl(this._self, this._then);

  final _NodeMeta _self;
  final $Res Function(_NodeMeta) _then;

/// Create a copy of NodeMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? center = null,Object? isPositionLocked = null,Object? size = null,Object? data = null,}) {
  return _then(_NodeMeta(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Offset,isPositionLocked: null == isPositionLocked ? _self.isPositionLocked : isPositionLocked // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
