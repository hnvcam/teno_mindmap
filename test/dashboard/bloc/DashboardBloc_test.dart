import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/Node.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

void main() {
  group('DashboardBloc', () {
    late DashboardBloc bloc;
    late Node root;

    test('initial state is correct', () {
      bloc = DashboardBloc(DashboardState.empty);
      expect(bloc.state.nodes, hasLength(1));
      expect(bloc.state.nodeMetas, hasLength(1));
      bloc.close();
    });

    blocTest<DashboardBloc, DashboardState>(
      'rebalances unlocked nodes when RequestRebalancingNodes is added',
      build: () {
        // Create a small tree

        final child1 = Node(id: 'child1', parentId: 'root');
        final child2 = Node(id: 'child2', parentId: 'root');
        root = Node(id: 'root', children: [child1, child2]);

        final metas = {
          'root': NodeMeta(
            id: 'root',
            title: 'Root',
            position: Offset.zero,
            size: Size(100, 50),
          ),
          'child1': NodeMeta(
            id: 'child1',
            title: 'Child 1',
            position: Offset.zero,
            size: Size(80, 40),
          ),
          'child2': NodeMeta(
            id: 'child2',
            title: 'Child 2',
            position: Offset.zero,
            size: Size(80, 40),
          ),
        };
        return DashboardBloc(
          DashboardState.empty.copyWith(
            nodes: {root.id: root, child1.id: child1, child2.id: child2},
            nodeMetas: metas,
            spacing: 50,
          ),
        );
      },
      act: (bloc) => bloc.add(RequestRebalancingNodes(node: root)),
      expect:
          () => [
            isA<DashboardState>().having(
              (s) =>
                  s.nodeMetas['child1']!.position != Offset.zero &&
                  s.nodeMetas['child2']!.position != Offset.zero,
              'child positions updated',
              true,
            ),
          ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances all nodes even when locked if forced=true',
      build: () {
        final child = Node(id: 'child', parentId: 'root');
        root = Node(id: 'root', children: [child]);

        final metas = {
          'root': NodeMeta(
            id: 'root',
            title: 'Root',
            position: Offset.zero,
            size: Size(100, 50),
          ),
          'child': NodeMeta(
            id: 'child',
            title: 'Child',
            position: Offset.zero,
            size: Size(80, 40),
            isPositionLocked: true, // Locked node
          ),
        };

        return DashboardBloc(
          DashboardState(
            nodes: {root.id: root, child.id: child},
            nodeMetas: metas,
            spacing: 50,
          ),
        );
      },
      act:
          (bloc) => bloc.add(RequestRebalancingNodes(node: root, forced: true)),
      expect:
          () => [
            isA<DashboardState>().having(
              (s) => s.nodeMetas['child']!.position != Offset.zero,
              'forced update applied to locked node',
              true,
            ),
          ],
    );
  });
}
