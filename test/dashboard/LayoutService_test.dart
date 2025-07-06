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
  test('Third child of 3rd child of root', () {
    final sample = sampleChildren(rootState, nodeId: 'root', count: 3);
    final sample2 = sampleChildren(
      sample.newState,
      nodeId: sample.children[2].id,
      count: 3,
    );
    expect(
      LayoutService(sample2.newState).getNodeAngularSpan(sample2.children[2]),
      (start: 4 * pi / 3 + 2 * 2 * pi / 9, end: 2 * pi),
    );
  });
}
