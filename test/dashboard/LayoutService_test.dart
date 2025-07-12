import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teno_mindmap/constants.dart';
import 'package:teno_mindmap/dashboard/LayoutService.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardBloc.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/MindMap.dart';
import 'package:teno_mindmap/models/NodeMeta.dart';

import '../testUtils.dart';

main() {
  group('getNodeAngularSpan', () {
    late DashboardState rootState;
    setUp(() {
      rootState = DashboardState(
        mindMap: MindMap(id: 'test', title: 'root'),
        radialAngleStart: 0,
      );
    });

    test('Root node has span of full angle', () {
      expect(
        LayoutService(rootState).getNodeAngularSpan(rootState.mindMap.root),
        (start: 0, end: 2 * pi),
      );
    });

    test('Fist child of root has span of 0 to pi', () {
      final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 1);
      expect(
        LayoutService(sample.newState).getNodeAngularSpan(sample.children[0]),
        (start: 0, end: pi),
      );
    });

    test('Second child of root has span of pi to 2pi', () {
      final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 2);
      expect(
        LayoutService(sample.newState).getNodeAngularSpan(sample.children[1]),
        (start: pi, end: 2 * pi),
      );
    });
    test('Fifth child of root has span of 9/5*pi to 2*pi', () {
      final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 5);
      expect(
        LayoutService(sample.newState).getNodeAngularSpan(sample.children[4]),
        (start: 8 * pi / 5, end: 2 * pi),
      );
    });
    test('Multi levels of singular line', () {
      var sample = sampleChildren(rootState, nodeId: rootNodeId, count: 1);
      for (int i = 0; i < 10; i++) {
        sample = sampleChildren(
          sample.newState,
          nodeId: sample.children[0].id,
          count: 1,
        );
        expect(
          LayoutService(sample.newState).getNodeAngularSpan(sample.children[0]),
          (start: 0, end: pi),
        );
      }
    });

    test('There levels balance', () {
      final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 2);
      final sample2 = sampleChildren(
        sample.newState,
        nodeId: sample.children[0].id,
        count: 2,
      );
      final layoutService = LayoutService(sample2.newState);
      expect(layoutService.getNodeAngularSpan(sample.children[0]), (
        start: 0,
        end: pi,
      ));
    });

    test('Third child of 3rd child of root', () {
      final sample = sampleChildren(rootState, nodeId: rootNodeId, count: 3);
      final sample2 = sampleChildren(
        sample.newState,
        nodeId: sample.children[2].id,
        count: 3,
      );
      final layoutService = LayoutService(sample2.newState);

      /// We have total span of 5 from root view, but this makes the 3rd root's child span bigger than pi
      /// So the function must lower the 3rd root's child span to 2, which means we have 4 span
      /// step = pi / 2;
      /// root_0: 0 -> pi / 2
      expect(layoutService.getNodeAngularSpan(sample.children[0]), (
        start: 0,
        end: pi / 2,
      ));

      /// root_1: end of root_0 -> pi
      expect(layoutService.getNodeAngularSpan(sample.children[1]), (
        start: pi / 2,
        end: pi,
      ));

      /// root_2: end of root_1 -> 2 * pi
      expect(layoutService.getNodeAngularSpan(sample.children[2]), (
        start: pi,
        end: 2 * pi,
      ));

      final start = pi;
      final end = 2 * pi;
      final angleStep = (end - start) / 3;
      for (int i = 0; i < 3; i++) {
        expect(layoutService.getNodeAngularSpan(sample2.children[i]), (
          start: start + angleStep * i,
          end: start + angleStep * (i + 1),
        ));
      }
    });
  });

  group('integration with DashboardBloc', () {
    late DashboardState rootState;
    late LayoutService layoutService;
    late StreamController<DashboardState> dashboardStateStream;
    late Stream<RequestUpdateNodeCenter> nodeCenterStream;

    void initializeWithRootState() {
      layoutService = LayoutService(rootState);
      dashboardStateStream = StreamController<DashboardState>.broadcast();
      layoutService.listen(dashboardStateStream.stream);
      nodeCenterStream = layoutService.stream;
    }

    tearDown(() {
      dashboardStateStream.close();
      layoutService.close();
    });

    test('A node changes in size, its center will be rebalanced', () async {
      rootState = DashboardState.withRoot('test');

      initializeWithRootState();

      var mindMap = rootState.mindMap.updateNode(
        rootNodeId,
        NodeMeta(title: 'test', size: Size(100, 50)),
      );
      mindMap = mindMap.addNode(
        parentId: rootNodeId,
        nodeMeta: NodeMeta(id: 'node1', size: Size(100, 50), title: 'node1'),
      );

      dashboardStateStream.add(rootState.copyWith(mindMap: mindMap));

      final event = await nodeCenterStream.first;
      expect(event.nodeId, 'node1');
      expect(event.center, const Offset(100, 0));
    });

    test(
      'A node changes in children count, then its center will be rebalanced',
      () async {
        /// because non of child node can span more than pi angle, so we need 3 nodes
        /// also make sure the size is small enough so it won't overlap, otherwise the rebalancing will do its job
        rootState = DashboardState(
          mindMap: MindMap(id: 'test', title: 'test', size: Size(100, 50))
              .addNode(
                parentId: rootNodeId,
                nodeMeta: NodeMeta(
                  id: 'node1',
                  title: 'node1',
                  size: Size(50, 50),
                  center: Offset(86.6, -50.0),
                ),
              )
              .addNode(
                parentId: rootNodeId,
                nodeMeta: NodeMeta(
                  id: 'node2',
                  title: 'node2',
                  size: Size(50, 50),
                  center: Offset(0.0, 100.0),
                ),
              )
              .addNode(
                parentId: rootNodeId,
                nodeMeta: NodeMeta(
                  id: 'node3',
                  title: 'node3',
                  size: Size(50, 50),
                  center: Offset(-86.6, -50.0),
                ),
              ),
        );
        initializeWithRootState();

        /// add single child to node1, does not change any centers of node1,2,3
        final newState = rootState.copyWith(
          mindMap: rootState.mindMap.addNode(
            parentId: 'node1',
            nodeMeta: NodeMeta(
              id: 'node1_child1',
              title: 'child1',
              size: Size(100, 50),
            ),
          ),
        );
        dashboardStateStream.add(newState);

        var collectedEvents =
            await nodeCenterStream
                .bufferTime(const Duration(milliseconds: 100))
                .first;

        /// just the node1_child1 is relayouted
        expect(collectedEvents, hasLength(1));
        expect(collectedEvents.first.nodeId, 'node1_child1');

        dashboardStateStream.add(
          newState.copyWith(
            mindMap: newState.mindMap.addNode(
              parentId: 'node1',
              nodeMeta: NodeMeta(
                id: 'node1_child2',
                title: 'child2',
                size: Size(50, 50),
              ),
            ),
          ),
        );

        /// now all nodes, except root must be relayouted
        collectedEvents =
            await nodeCenterStream
                .bufferTime(const Duration(milliseconds: 100))
                .first;

        expect(collectedEvents, hasLength(5));
        expect(
          collectedEvents,
          contains(
            predicate<RequestUpdateNodeCenter>(
              /// it has 2 children so it takes a pi span.
              (event) =>
                  event.nodeId == 'node1' &&
                  event.center.closeTo(Offset(100, 0)),
            ),
          ),
        );
        expect(
          collectedEvents,
          contains(
            predicate<RequestUpdateNodeCenter>(
              /// it shares remaining pi span with node 3.
              (event) =>
                  event.nodeId == 'node2' &&
                  event.center.closeTo(Offset(-70.7, 70.7)),
            ),
          ),
        );
        expect(
          collectedEvents,
          contains(
            predicate<RequestUpdateNodeCenter>(
              (event) =>
                  event.nodeId == 'node3' &&
                  event.center.closeTo(Offset(-70.7, -70.7)),
            ),
          ),
        );
      },
    );
  });
}
