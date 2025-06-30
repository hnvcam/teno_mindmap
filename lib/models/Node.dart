import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/Node.freezed.dart';
part 'generated/Node.g.dart';

@freezed
sealed class Node with _$Node {
  const Node._();

  const factory Node({
    required String id,
    @Default([]) List<Node> children,
    Node? parent,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  bool get isLeaf => children.isEmpty;
  bool get isRoot => parent == null;
}
