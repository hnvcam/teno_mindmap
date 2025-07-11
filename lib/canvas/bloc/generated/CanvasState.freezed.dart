// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../CanvasState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CanvasState {
// @Default provides default values for the initial state.
  double get scale => throw _privateConstructorUsedError;
  Offset get offset => throw _privateConstructorUsedError;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanvasStateCopyWith<CanvasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasStateCopyWith<$Res> {
  factory $CanvasStateCopyWith(
          CanvasState value, $Res Function(CanvasState) then) =
      _$CanvasStateCopyWithImpl<$Res, CanvasState>;
  @useResult
  $Res call({double scale, Offset offset});
}

/// @nodoc
class _$CanvasStateCopyWithImpl<$Res, $Val extends CanvasState>
    implements $CanvasStateCopyWith<$Res> {
  _$CanvasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? offset = null,
  }) {
    return _then(_value.copyWith(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CanvasStateImplCopyWith<$Res>
    implements $CanvasStateCopyWith<$Res> {
  factory _$$CanvasStateImplCopyWith(
          _$CanvasStateImpl value, $Res Function(_$CanvasStateImpl) then) =
      __$$CanvasStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double scale, Offset offset});
}

/// @nodoc
class __$$CanvasStateImplCopyWithImpl<$Res>
    extends _$CanvasStateCopyWithImpl<$Res, _$CanvasStateImpl>
    implements _$$CanvasStateImplCopyWith<$Res> {
  __$$CanvasStateImplCopyWithImpl(
      _$CanvasStateImpl _value, $Res Function(_$CanvasStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = null,
    Object? offset = null,
  }) {
    return _then(_$CanvasStateImpl(
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _$CanvasStateImpl extends _CanvasState {
  const _$CanvasStateImpl({this.scale = 1.0, this.offset = Offset.zero})
      : super._();

// @Default provides default values for the initial state.
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final Offset offset;

  @override
  String toString() {
    return 'CanvasState(scale: $scale, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasStateImpl &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scale, offset);

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasStateImplCopyWith<_$CanvasStateImpl> get copyWith =>
      __$$CanvasStateImplCopyWithImpl<_$CanvasStateImpl>(this, _$identity);
}

abstract class _CanvasState extends CanvasState {
  const factory _CanvasState({final double scale, final Offset offset}) =
      _$CanvasStateImpl;
  const _CanvasState._() : super._();

// @Default provides default values for the initial state.
  @override
  double get scale;
  @override
  Offset get offset;

  /// Create a copy of CanvasState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanvasStateImplCopyWith<_$CanvasStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
