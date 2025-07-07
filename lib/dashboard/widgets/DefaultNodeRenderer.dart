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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor),
        color: theme.colorScheme.onPrimary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(nodeMeta.title),
    );
  }
}
