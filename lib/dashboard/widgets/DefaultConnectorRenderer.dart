import 'package:flutter/material.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class DefaultConnectorRenderer extends StatelessWidget {
  const DefaultConnectorRenderer({
    super.key,
    required this.parent,
    required this.node,
    required this.parentMeta,
    required this.nodeMeta,
  });

  final Node parent;
  final Node node;
  final NodeMeta parentMeta;
  final NodeMeta nodeMeta;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
