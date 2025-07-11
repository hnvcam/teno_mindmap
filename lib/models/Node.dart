import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/Node.freezed.dart';
part 'generated/Node.g.dart';

/// The idea is every node must have a parent, so we can reduce the null check
/// And we only supported attached nodes.
@freezed
class Node with _$Node {
  const Node._();

  const factory Node({
    required String id,
    @Default([]) List<Node> children,
    required String parentId,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  bool get isLeaf => children.isEmpty;

  int get span {
    if (isLeaf) {
      return 1;
    }
    return children.length;
  }
}
