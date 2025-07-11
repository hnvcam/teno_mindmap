import 'package:teno_mindmap/models/Node.dart';

const rootNodeId = '\$\$root';
const nodeEditingKey = 'editing';

bool isRoot(Node node) => node.id == rootNodeId;
