// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../DashboardState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardState {
  MindMap get mindMap => throw _privateConstructorUsedError;

  /// minimum space between parent's center and child's center
  /// excluding the Node.radius
  double get minSpacing => throw _privateConstructorUsedError;

  /// if there is an overlapping on nodes, increase the space by this step
  double get stepSpacing => throw _privateConstructorUsedError;

  /// Where the angle of the radial layout start, in radian.
  double get radialAngleStart => throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call(
      {MindMap mindMap,
      double minSpacing,
      double stepSpacing,
      double radialAngleStart});
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mindMap = null,
    Object? minSpacing = null,
    Object? stepSpacing = null,
    Object? radialAngleStart = null,
  }) {
    return _then(_value.copyWith(
      mindMap: null == mindMap
          ? _value.mindMap
          : mindMap // ignore: cast_nullable_to_non_nullable
              as MindMap,
      minSpacing: null == minSpacing
          ? _value.minSpacing
          : minSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      stepSpacing: null == stepSpacing
          ? _value.stepSpacing
          : stepSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      radialAngleStart: null == radialAngleStart
          ? _value.radialAngleStart
          : radialAngleStart // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStateImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateImplCopyWith(_$DashboardStateImpl value,
          $Res Function(_$DashboardStateImpl) then) =
      __$$DashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MindMap mindMap,
      double minSpacing,
      double stepSpacing,
      double radialAngleStart});
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
      _$DashboardStateImpl _value, $Res Function(_$DashboardStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mindMap = null,
    Object? minSpacing = null,
    Object? stepSpacing = null,
    Object? radialAngleStart = null,
  }) {
    return _then(_$DashboardStateImpl(
      mindMap: null == mindMap
          ? _value.mindMap
          : mindMap // ignore: cast_nullable_to_non_nullable
              as MindMap,
      minSpacing: null == minSpacing
          ? _value.minSpacing
          : minSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      stepSpacing: null == stepSpacing
          ? _value.stepSpacing
          : stepSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      radialAngleStart: null == radialAngleStart
          ? _value.radialAngleStart
          : radialAngleStart // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DashboardStateImpl extends _DashboardState {
  const _$DashboardStateImpl(
      {required this.mindMap,
      this.minSpacing = 50.0,
      this.stepSpacing = 20.0,
      this.radialAngleStart = -pi / 2})
      : super._();

  @override
  final MindMap mindMap;

  /// minimum space between parent's center and child's center
  /// excluding the Node.radius
  @override
  @JsonKey()
  final double minSpacing;

  /// if there is an overlapping on nodes, increase the space by this step
  @override
  @JsonKey()
  final double stepSpacing;

  /// Where the angle of the radial layout start, in radian.
  @override
  @JsonKey()
  final double radialAngleStart;

  @override
  String toString() {
    return 'DashboardState(mindMap: $mindMap, minSpacing: $minSpacing, stepSpacing: $stepSpacing, radialAngleStart: $radialAngleStart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.mindMap, mindMap) || other.mindMap == mindMap) &&
            (identical(other.minSpacing, minSpacing) ||
                other.minSpacing == minSpacing) &&
            (identical(other.stepSpacing, stepSpacing) ||
                other.stepSpacing == stepSpacing) &&
            (identical(other.radialAngleStart, radialAngleStart) ||
                other.radialAngleStart == radialAngleStart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, mindMap, minSpacing, stepSpacing, radialAngleStart);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
          this, _$identity);
}

abstract class _DashboardState extends DashboardState {
  const factory _DashboardState(
      {required final MindMap mindMap,
      final double minSpacing,
      final double stepSpacing,
      final double radialAngleStart}) = _$DashboardStateImpl;
  const _DashboardState._() : super._();

  @override
  MindMap get mindMap;

  /// minimum space between parent's center and child's center
  /// excluding the Node.radius
  @override
  double get minSpacing;

  /// if there is an overlapping on nodes, increase the space by this step
  @override
  double get stepSpacing;

  /// Where the angle of the radial layout start, in radian.
  @override
  double get radialAngleStart;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
