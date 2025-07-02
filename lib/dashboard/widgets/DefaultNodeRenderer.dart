import 'package:flutter/material.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class DefaultNodeRenderer extends StatelessWidget {
  const DefaultNodeRenderer({
    super.key,
    required this.node,
    required this.nodeMeta,
  });

  final Node node;
  final NodeMeta nodeMeta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Text(nodeMeta.title),
    );
  }
}
