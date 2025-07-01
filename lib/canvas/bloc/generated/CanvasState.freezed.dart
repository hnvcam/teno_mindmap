// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../CanvasState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CanvasState {

// @Default provides default values for the initial state.
 double get scale; Offset get offset;
/// Create a copy of CanvasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CanvasStateCopyWith<CanvasState> get copyWith => _$CanvasStateCopyWithImpl<CanvasState>(this as CanvasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CanvasState&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,scale,offset);

@override
String toString() {
  return 'CanvasState(scale: $scale, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $CanvasStateCopyWith<$Res>  {
  factory $CanvasStateCopyWith(CanvasState value, $Res Function(CanvasState) _then) = _$CanvasStateCopyWithImpl;
@useResult
$Res call({
 double scale, Offset offset
});




}
/// @nodoc
class _$CanvasStateCopyWithImpl<$Res>
    implements $CanvasStateCopyWith<$Res> {
  _$CanvasStateCopyWithImpl(this._self, this._then);

  final CanvasState _self;
  final $Res Function(CanvasState) _then;

/// Create a copy of CanvasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scale = null,Object? offset = null,}) {
  return _then(_self.copyWith(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Offset,
  ));
}

}


/// @nodoc


class _CanvasState extends CanvasState {
  const _CanvasState({this.scale = 1.0, this.offset = Offset.zero}): super._();
  

// @Default provides default values for the initial state.
@override@JsonKey() final  double scale;
@override@JsonKey() final  Offset offset;

/// Create a copy of CanvasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CanvasStateCopyWith<_CanvasState> get copyWith => __$CanvasStateCopyWithImpl<_CanvasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CanvasState&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode => Object.hash(runtimeType,scale,offset);

@override
String toString() {
  return 'CanvasState(scale: $scale, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$CanvasStateCopyWith<$Res> implements $CanvasStateCopyWith<$Res> {
  factory _$CanvasStateCopyWith(_CanvasState value, $Res Function(_CanvasState) _then) = __$CanvasStateCopyWithImpl;
@override @useResult
$Res call({
 double scale, Offset offset
});




}
/// @nodoc
class __$CanvasStateCopyWithImpl<$Res>
    implements _$CanvasStateCopyWith<$Res> {
  __$CanvasStateCopyWithImpl(this._self, this._then);

  final _CanvasState _self;
  final $Res Function(_CanvasState) _then;

/// Create a copy of CanvasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scale = null,Object? offset = null,}) {
  return _then(_CanvasState(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as Offset,
  ));
}


}

// dart format on
