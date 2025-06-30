// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../DashboardState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardState {

 Map<String, Node> get nodes; Map<String, NodeMeta> get nodeMetas; Node? get root;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);

  /// Serializes this DashboardState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.nodeMetas, nodeMetas)&&(identical(other.root, root) || other.root == root));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(nodeMetas),root);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 Map<String, Node> nodes, Map<String, NodeMeta> nodeMetas, Node? root
});


$NodeCopyWith<$Res>? get root;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nodes = null,Object? nodeMetas = null,Object? root = freezed,}) {
  return _then(_self.copyWith(
nodes: null == nodes ? _self.nodes : nodes // ignore: cast_nullable_to_non_nullable
as Map<String, Node>,nodeMetas: null == nodeMetas ? _self.nodeMetas : nodeMetas // ignore: cast_nullable_to_non_nullable
as Map<String, NodeMeta>,root: freezed == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as Node?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeCopyWith<$Res>? get root {
    if (_self.root == null) {
    return null;
  }

  return $NodeCopyWith<$Res>(_self.root!, (value) {
    return _then(_self.copyWith(root: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DashboardState extends DashboardState {
  const _DashboardState({final  Map<String, Node> nodes = const {}, final  Map<String, NodeMeta> nodeMetas = const {}, this.root}): _nodes = nodes,_nodeMetas = nodeMetas,super._();
  factory _DashboardState.fromJson(Map<String, dynamic> json) => _$DashboardStateFromJson(json);

 final  Map<String, Node> _nodes;
@override@JsonKey() Map<String, Node> get nodes {
  if (_nodes is EqualUnmodifiableMapView) return _nodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_nodes);
}

 final  Map<String, NodeMeta> _nodeMetas;
@override@JsonKey() Map<String, NodeMeta> get nodeMetas {
  if (_nodeMetas is EqualUnmodifiableMapView) return _nodeMetas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_nodeMetas);
}

@override final  Node? root;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._nodeMetas, _nodeMetas)&&(identical(other.root, root) || other.root == root));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_nodeMetas),root);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Node> nodes, Map<String, NodeMeta> nodeMetas, Node? root
});


@override $NodeCopyWith<$Res>? get root;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nodes = null,Object? nodeMetas = null,Object? root = freezed,}) {
  return _then(_DashboardState(
nodes: null == nodes ? _self._nodes : nodes // ignore: cast_nullable_to_non_nullable
as Map<String, Node>,nodeMetas: null == nodeMetas ? _self._nodeMetas : nodeMetas // ignore: cast_nullable_to_non_nullable
as Map<String, NodeMeta>,root: freezed == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as Node?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeCopyWith<$Res>? get root {
    if (_self.root == null) {
    return null;
  }

  return $NodeCopyWith<$Res>(_self.root!, (value) {
    return _then(_self.copyWith(root: value));
  });
}
}

// dart format on
