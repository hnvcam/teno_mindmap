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

 String? get id; String get title;@OffsetJsonConverter() Offset get position;@SizeJsonConverter() Size get size; String get type; Map<String, dynamic> get data;
/// Create a copy of NodeMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeMetaCopyWith<NodeMeta> get copyWith => _$NodeMetaCopyWithImpl<NodeMeta>(this as NodeMeta, _$identity);

  /// Serializes this NodeMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.size, size) || other.size == size)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,position,size,type,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NodeMeta(id: $id, title: $title, position: $position, size: $size, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $NodeMetaCopyWith<$Res>  {
  factory $NodeMetaCopyWith(NodeMeta value, $Res Function(NodeMeta) _then) = _$NodeMetaCopyWithImpl;
@useResult
$Res call({
 String? id, String title,@OffsetJsonConverter() Offset position,@SizeJsonConverter() Size size, String type, Map<String, dynamic> data
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? position = null,Object? size = null,Object? type = null,Object? data = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NodeMeta implements NodeMeta {
  const _NodeMeta({this.id, required this.title, @OffsetJsonConverter() this.position = Offset.zero, @SizeJsonConverter() this.size = Size.zero, this.type = 'default', final  Map<String, dynamic> data = const {}}): _data = data;
  factory _NodeMeta.fromJson(Map<String, dynamic> json) => _$NodeMetaFromJson(json);

@override final  String? id;
@override final  String title;
@override@JsonKey()@OffsetJsonConverter() final  Offset position;
@override@JsonKey()@SizeJsonConverter() final  Size size;
@override@JsonKey() final  String type;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NodeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.size, size) || other.size == size)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,position,size,type,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NodeMeta(id: $id, title: $title, position: $position, size: $size, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NodeMetaCopyWith<$Res> implements $NodeMetaCopyWith<$Res> {
  factory _$NodeMetaCopyWith(_NodeMeta value, $Res Function(_NodeMeta) _then) = __$NodeMetaCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title,@OffsetJsonConverter() Offset position,@SizeJsonConverter() Size size, String type, Map<String, dynamic> data
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? position = null,Object? size = null,Object? type = null,Object? data = null,}) {
  return _then(_NodeMeta(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as Size,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
