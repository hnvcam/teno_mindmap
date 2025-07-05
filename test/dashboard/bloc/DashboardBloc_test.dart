import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/Node.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

void main() {
  group('DashboardBloc - _getNodeAngularSpan', () {
    test('Root node has span of full angle', () {
      final bloc = DashboardBloc(
        DashboardState.empty.copyWith(
          nodes: {'root': Node(id: 'root')},
          spacing: 50,
        ),
      );
      expect(bloc.testNodeAngularSpan(Node(id: 'root')), (
        start: 0,
        end: 2 * pi,
      ));
    });

    test('Fist child of root has span of 0 to pi', () {
      final child = Node(id: 'child', parentId: 'root');
      final bloc = DashboardBloc(
        DashboardState.empty.copyWith(
          nodes: {
            'root': Node(id: 'root', children: [child]),
            'child': child,
          },
        ),
      );
      expect(bloc.testNodeAngularSpan(child), (start: 0, end: pi));
    });

    test('Second child of root has span of pi to 2pi', () {
      final children = [
        for (int i = 1; i <= 2; i++) Node(id: 'child$i', parentId: 'root'),
      ];
      final bloc = DashboardBloc(
        DashboardState.empty.copyWith(
          nodes: {
            'root': Node(id: 'root', children: children),
            for (final child in children) child.id: child,
          },
        ),
      );
      expect(bloc.testNodeAngularSpan(children[1]), (start: pi, end: 2 * pi));
    });
  });

  group('DashboardBloc - Rebalancing', () {
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
      act: (bloc) => bloc.add(RequestRebalancingNode(nodeId: root.id)),
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
          (bloc) =>
              bloc.add(RequestRebalancingNode(nodeId: root.id, forced: true)),
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
