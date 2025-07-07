import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/dashboard/LayoutService.dart';
import 'package:teno_mindmap/dashboard/bloc/DashboardState.dart';
import 'package:teno_mindmap/models/Node.dart';

import '../testUtils.dart';

main() {
  late DashboardState rootState;
  setUp(() {
    rootState = DashboardState.empty
        .newRoot(id: 'root')
        .withRadialAngleStart(0);
  });

  test('Root node has span of full angle', () {
    expect(LayoutService(rootState).getNodeAngularSpan(Node(id: 'root')), (
      start: 0,
      end: 2 * pi,
    ));
  });

  test('Fist child of root has span of 0 to pi', () {
    final sample = sampleChildren(rootState, nodeId: 'root', count: 1);
    expect(
      LayoutService(sample.newState).getNodeAngularSpan(sample.children[0]),
      (start: 0, end: pi),
    );
  });

  test('Second child of root has span of pi to 2pi', () {
    final sample = sampleChildren(rootState, nodeId: 'root', count: 2);
    expect(
      LayoutService(sample.newState).getNodeAngularSpan(sample.children[1]),
      (start: pi, end: 2 * pi),
    );
  });
  test('Fifth child of root has span of 9/5*pi to 2*pi', () {
    final sample = sampleChildren(rootState, nodeId: 'root', count: 5);
    expect(
      LayoutService(sample.newState).getNodeAngularSpan(sample.children[4]),
      (start: 8 * pi / 5, end: 2 * pi),
    );
  });
  test('Multi levels of singular line', () {
    var sample = sampleChildren(rootState, nodeId: 'root', count: 1);
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
    final sample = sampleChildren(rootState, nodeId: 'root', count: 2);
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
    final sample = sampleChildren(rootState, nodeId: 'root', count: 3);
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
}
