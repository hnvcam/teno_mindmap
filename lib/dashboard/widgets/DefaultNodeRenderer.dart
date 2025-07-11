import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import 'package:teno_mindmap/constants.dart';

import '../../models/Node.dart';
import '../../models/NodeMeta.dart';
import '../bloc/DashboardBloc.dart';
import '../bloc/DashboardState.dart';

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

    /// we Overlay here so that it won't raise unnecessary size changed event.
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen:
          (previous, current) =>
              !previous.mindMap.nodeMetas.containsKey(node.id) ||
              previous.mindMap.nodeMetas[node.id]?.data[nodeEditingKey] !=
                  current.mindMap.nodeMetas[node.id]?.data[nodeEditingKey],
      listener: _onNodeEditingStateChanged,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.primaryColor),
          color:
              isRoot(node)
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onPrimary,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          nodeMeta.title,
          style:
              isRoot(node)
                  ? theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  )
                  : theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  void _onNodeEditingStateChanged(BuildContext context, DashboardState state) {
    final editing =
        state.mindMap.nodeMetaById(node.id).data[nodeEditingKey] == true;
    if (editing) {
      final textController = TextEditingController(text: nodeMeta.title);
      final starMenuController = StarMenuController();
      StarMenuOverlay.dispose();
      StarMenuOverlay.displayStarMenu(
        context,
        StarMenu(
          params: StarMenuParameters(
            backgroundParams: BackgroundParams(
              backgroundColor: Color(0x80000000),
            ),
          ),
          controller: starMenuController,
          items: [
            Material(
              elevation: 1,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Container(
                constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onSubmitted: (value) {
                          DashboardBloc.read(context).add(
                            RequestUpdateNodeMeta(
                              nodeId: node.id,
                              title: value,
                              data: {nodeEditingKey: false},
                            ),
                          );
                          starMenuController.closeMenu?.call();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        DashboardBloc.read(context).add(
                          RequestUpdateNodeMeta(
                            nodeId: node.id,
                            title: textController.text,
                            data: {nodeEditingKey: false},
                          ),
                        );
                        starMenuController.closeMenu?.call();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
          parentContext: context,
          onStateChanged: (state) {
            if (state == MenuState.closed) {
              DashboardBloc.read(context).add(
                RequestUpdateNodeMeta(
                  nodeId: node.id,
                  data: {nodeEditingKey: false},
                ),
              );
            }
          },
        ),
      );
    }
  }
}
