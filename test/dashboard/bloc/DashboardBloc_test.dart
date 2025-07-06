import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/Node.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../../testUtils.dart';

void main() {
  test('initial state is correct', () {
    final emptyStateBloc = DashboardBloc(DashboardState.empty);
    expect(emptyStateBloc.state.nodes, hasLength(0));
    expect(emptyStateBloc.state.nodeMetas, hasLength(0));
    emptyStateBloc.close();

    final rootStateBloc = DashboardBloc(DashboardState.empty.newRoot());
    expect(rootStateBloc.state.nodes, hasLength(1));
    expect(rootStateBloc.state.nodeMetas, hasLength(1));
    rootStateBloc.close();
  });

  group('DashboardBloc - Rebalancing', () {
    late DashboardState testState;
    late List<Node> testChildren;
    late DashboardState rootState;

    setUp(() {
      rootState = DashboardState.empty.newRoot(id: 'root');
    });

    blocTest<DashboardBloc, DashboardState>(
      'rebalances unlocked nodes when RequestRebalancingNodes is added',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: 'root', count: 1);
        testState = sample.newState;
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(NodeSizeChangedEvent('root', Size(100, 50)));
        bloc.add(NodeSizeChangedEvent(testChildren[0].id, Size(80, 20)));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.getNodeMeta(bloc.state.root!).center, Offset.zero);
        expect(bloc.state.getNodeMeta(testChildren[0]).center, Offset(100, 0));
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances locked node when RequestRebalancingNodes is added',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: 'root', count: 1);
        testState = sample.newState;
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(NodeSizeChangedEvent('root', Size(100, 50)));
        bloc.add(NodeSizeChangedEvent(testChildren[0].id, Size(80, 20)));

        /// maybe flaky here, because above request issue relayout task first.
        bloc.add(
          RequestFixNodeCenter(nodeId: testChildren[0].id, center: Offset.zero),
        );
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.getNodeMeta(bloc.state.root!).center, Offset.zero);
        expect(bloc.state.getNodeMeta(testChildren[0]).center, Offset.zero);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances 3 levels map',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: 'root', count: 2);
        final sample2 = sampleChildren(
          sample.newState,
          nodeId: sample.children[0].id,
          count: 2,
        );
        testState = sample2.newState
            .updateNode('root', NodeMeta(title: 'Root', size: Size(100, 50)))
            .updateNode(
              'root_0',
              NodeMeta(title: 'root_0', size: Size(100, 50)),
            )
            .updateNode(
              'root_1',
              NodeMeta(title: 'root_1', size: Size(100, 50)),
            )
            .updateNode(
              'root_0_0',
              NodeMeta(title: 'root_0_0', size: Size(100, 50)),
            )
            .updateNode(
              'root_0_1',
              NodeMeta(title: 'root_0_1', size: Size(100, 50)),
            );
        testChildren = sample2.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(RequestRebalancingNode(nodeId: 'root'));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.getNodeMetaById('root').center, Offset.zero);
        expect(
          bloc.state.getNodeMetaById('root_0').center,
          closeToOffset(Offset(100, 0)),
        );
        expect(
          bloc.state.getNodeMetaById('root_1').center,
          closeToOffset(Offset(-100, 0)),
        );
        expect(
          bloc.state.getNodeMetaById('root_0_0').center,
          closeToOffset(Offset(100 + 100 * cos(-pi / 4), 100 * sin(-pi / 4))),
        );
        expect(
          bloc.state.getNodeMetaById('root_0_1').center,
          closeToOffset(Offset(100 + 100 * cos(pi / 4), 100 * sin(pi / 4))),
        );
        bloc.close();
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances overlapped nodes',
      setUp: () {
        final sample = sampleChildren(
          DashboardState(spacing: 10).newRoot(id: 'root'),
          nodeId: 'root',
          count: 1,
        );
        testState = sample.newState
            .updateNode('root', NodeMeta(title: 'root', size: Size(100, 50)))
            .updateNode(
              'root_0',
              NodeMeta(title: 'root_0', size: Size(100, 50)),
            );
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(RequestRebalancingNode(nodeId: 'root'));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.getNodeMeta(bloc.state.root!).center, Offset.zero);
        expect(
          bloc.state
              .getNodeMeta(testChildren[0])
              .rect
              .overlaps(bloc.state.getNodeMetaById('root').rect),
          false,
        );
      },
    );
  });
}
