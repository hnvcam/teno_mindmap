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

 Map<String, Node> get nodes; Map<String, NodeMeta> get nodeMetas; Node? get root; double get spacing;

  /// Serializes this DashboardState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.nodeMetas, nodeMetas)&&(identical(other.root, root) || other.root == root)&&(identical(other.spacing, spacing) || other.spacing == spacing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(nodeMetas),root,spacing);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root, spacing: $spacing)';
}


}




/// @nodoc
@JsonSerializable()

class _DashboardState extends DashboardState {
  const _DashboardState({final  Map<String, Node> nodes = const {}, final  Map<String, NodeMeta> nodeMetas = const {}, this.root, this.spacing = 50.0}): _nodes = nodes,_nodeMetas = nodeMetas,super._();
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
@override@JsonKey() final  double spacing;


@override
Map<String, dynamic> toJson() {
  return _$DashboardStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._nodeMetas, _nodeMetas)&&(identical(other.root, root) || other.root == root)&&(identical(other.spacing, spacing) || other.spacing == spacing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_nodeMetas),root,spacing);

@override
String toString() {
  return 'DashboardState(nodes: $nodes, nodeMetas: $nodeMetas, root: $root, spacing: $spacing)';
}


}




// dart format on
