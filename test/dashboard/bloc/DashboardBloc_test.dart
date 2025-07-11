import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/constants.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/MindMap.dart';
import 'package:teno_mindmap/models/Node.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../../testUtils.dart';

void main() {
  test('initial state is correct', () {
    final emptyStateBloc = DashboardBloc(DashboardState.withRoot('test'));
    final mindMap = emptyStateBloc.state.mindMap;

    expect(mindMap.nodes, hasLength(0));
    expect(mindMap.nodeMetas, hasLength(0));
    expect(isRoot(mindMap.root), true);
    emptyStateBloc.close();
  });

  group('DashboardBloc - Rebalancing', () {
    late DashboardState testState;
    late List<Node> testChildren;
    late DashboardState rootState;

    setUp(() {
      rootState = DashboardState.withRoot('test');
    });

    blocTest<DashboardBloc, DashboardState>(
      'rebalances unlocked nodes when RequestRebalancingNodes is added',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 1);
        testState = sample.newState;
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(NodeSizeChangedEvent(rootNodeId, Size(100, 50)));
        bloc.add(NodeSizeChangedEvent(testChildren[0].id, Size(80, 20)));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(
          bloc.state.mindMap.nodeMetaOf(bloc.state.mindMap.root).center,
          Offset.zero,
        );
        expect(
          bloc.state.mindMap.nodeMetaOf(testChildren[0]).center,
          Offset(100, 0),
        );
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances locked node when RequestRebalancingNodes is added',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 1);
        testState = sample.newState;
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(NodeSizeChangedEvent(rootNodeId, Size(100, 50)));
        bloc.add(NodeSizeChangedEvent(testChildren[0].id, Size(80, 20)));

        /// maybe flaky here, because above request issue relayout task first.
        bloc.add(
          RequestFixNodeCenter(nodeId: testChildren[0].id, center: Offset.zero),
        );
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(
          bloc.state.mindMap.nodeMetaOf(bloc.state.mindMap.root).center,
          Offset.zero,
        );
        expect(
          bloc.state.mindMap.nodeMetaOf(testChildren[0]).center,
          Offset.zero,
        );
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances 3 levels map',
      setUp: () {
        final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 2);
        final sample2 = sampleChildren(
          sample.newState,
          nodeId: sample.children[0].id,
          count: 2,
        );
        testState = sample2.newState.copyWith(
          mindMap: sample2.newState.mindMap
              .updateNode(
                rootNodeId,
                NodeMeta(title: 'Root', size: Size(100, 50)),
              )
              .updateNode(
                '${rootNodeId}_0',
                NodeMeta(title: '${rootNodeId}_0', size: Size(100, 50)),
              )
              .updateNode(
                '${rootNodeId}_1',
                NodeMeta(title: '${rootNodeId}_1', size: Size(100, 50)),
              )
              .updateNode(
                '${rootNodeId}_0_0',
                NodeMeta(title: '${rootNodeId}_0_0', size: Size(100, 50)),
              )
              .updateNode(
                '${rootNodeId}_0_1',
                NodeMeta(title: '${rootNodeId}_0_1', size: Size(100, 50)),
              ),
        );
        testChildren = sample2.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(RequestRebalancingNode(nodeId: rootNodeId));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(bloc.state.mindMap.nodeMetaById(rootNodeId).center, Offset.zero);
        expect(
          bloc.state.mindMap.nodeMetaById('${rootNodeId}_0').center,
          closeToOffset(Offset(100, 0)),
        );
        expect(
          bloc.state.mindMap.nodeMetaById('${rootNodeId}_1').center,
          closeToOffset(Offset(-100, 0)),
        );
        expect(
          bloc.state.mindMap.nodeMetaById('${rootNodeId}_0_0').center,
          closeToOffset(Offset(100 + 100 * cos(-pi / 4), 100 * sin(-pi / 4))),
        );
        expect(
          bloc.state.mindMap.nodeMetaById('${rootNodeId}_0_1').center,
          closeToOffset(Offset(100 + 100 * cos(pi / 4), 100 * sin(pi / 4))),
        );
        bloc.close();
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'rebalances overlapped nodes',
      setUp: () {
        final sample = sampleChildren(
          DashboardState(
            minSpacing: 10,
            mindMap: MindMap(id: 'test', title: 'test'),
          ),
          nodeId: rootNodeId,
          count: 1,
        );
        testState = sample.newState.copyWith(
          mindMap: sample.newState.mindMap
              .updateNode(
                rootNodeId,
                NodeMeta(title: rootNodeId, size: Size(100, 50)),
              )
              .updateNode(
                '${rootNodeId}_0',
                NodeMeta(title: '${rootNodeId}_0', size: Size(100, 50)),
              ),
        );
        testChildren = sample.children;
      },
      build: () => DashboardBloc(testState),
      act: (bloc) {
        bloc.add(RequestRebalancingNode(nodeId: rootNodeId));
      },
      wait: Duration(milliseconds: 100),
      verify: (bloc) {
        expect(
          bloc.state.mindMap.nodeMetaOf(bloc.state.mindMap.root).center,
          Offset.zero,
        );
        expect(
          bloc.state.mindMap
              .nodeMetaOf(testChildren[0])
              .rect
              .overlaps(bloc.state.mindMap.nodeMetaById(rootNodeId).rect),
          false,
        );
      },
    );
  });
}
