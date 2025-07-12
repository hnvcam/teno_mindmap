import 'package:teno_mindmap/models/Node.dart';

const rootNodeId = '\$\$root';
const nodeEditingKey = 'editing';
// the minimum distance that is considered as a change.
const distanceSensitive = 0.01;

bool isRoot(Node node) => node.id == rootNodeId;
