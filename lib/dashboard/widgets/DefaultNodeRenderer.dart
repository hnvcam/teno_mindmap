import 'package:flutter/material.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';

class DefaultNodeRenderer extends StatelessWidget {
  const DefaultNodeRenderer(this.node, {super.key, required this.meta});

  final Node node;
  final NodeMeta meta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.primaryColor),
      ),
      child: Text(meta.title),
    );
  }
}
