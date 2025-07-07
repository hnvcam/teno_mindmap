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

 Map<String, Node> get nodes; Map<String, NodeMeta> get nodeMetas; Node? get root;/// minimum space between parent's center and child's center
/// excluding the Node.radius
 double get minSpacing;/// if there is an overlapping on nodes, increase the space by this step
 double get stepSpacing;/// Where the angle of the radial layout start, in radian.
 double get radialAngleStart;

  /// Serializes this DashboardState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.nodeMetas, nodeMetas)&&(identical(other.root, root) || other.root == root)&&(identical(other.minSpacing, minSpacing) || other.minSpacing == minSpacing)&&(identical(other.stepSpacing, stepSpacing) || other.stepSpacing == stepSpacing)&&(identical(other.radialAngleStart, radialAngleStart) || other.radialAngleStart == radialAngleStart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(nodeMetas),root,minSpacing,stepSpacing,radialAngleStart);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root, minSpacing: $minSpacing, stepSpacing: $stepSpacing, radialAngleStart: $radialAngleStart)';
}


}




/// @nodoc
@JsonSerializable()

class _DashboardState extends DashboardState {
  const _DashboardState({final  Map<String, Node> nodes = const {}, final  Map<String, NodeMeta> nodeMetas = const {}, this.root, this.minSpacing = 50.0, this.stepSpacing = 20.0, this.radialAngleStart = -pi / 2}): _nodes = nodes,_nodeMetas = nodeMetas,super._();
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
/// minimum space between parent's center and child's center
/// excluding the Node.radius
@override@JsonKey() final  double minSpacing;
/// if there is an overlapping on nodes, increase the space by this step
@override@JsonKey() final  double stepSpacing;
/// Where the angle of the radial layout start, in radian.
@override@JsonKey() final  double radialAngleStart;


@override
Map<String, dynamic> toJson() {
  return _$DashboardStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._nodeMetas, _nodeMetas)&&(identical(other.root, root) || other.root == root)&&(identical(other.minSpacing, minSpacing) || other.minSpacing == minSpacing)&&(identical(other.stepSpacing, stepSpacing) || other.stepSpacing == stepSpacing)&&(identical(other.radialAngleStart, radialAngleStart) || other.radialAngleStart == radialAngleStart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_nodeMetas),root,minSpacing,stepSpacing,radialAngleStart);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root, minSpacing: $minSpacing, stepSpacing: $stepSpacing, radialAngleStart: $radialAngleStart)';
}


}




// dart format on
