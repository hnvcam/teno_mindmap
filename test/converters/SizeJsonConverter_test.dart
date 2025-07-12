import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/converters/SizeJsonConverter.dart';

void main() {
  group('SizeJsonConverter', () {
    final converter = SizeJsonConverter();

    test('fromJson returns correct Size', () {
      final json = {'width': 100.0, 'height': 50.0};
      final size = converter.fromJson(json);
      expect(size.width, 100.0);
      expect(size.height, 50.0);
    });

    test('fromJson handles missing width or height with default 0', () {
      final json1 = {'height': 30.0};
      final size1 = converter.fromJson(json1);
      expect(size1.width, 0.0);
      expect(size1.height, 30.0);

      final json2 = {'width': 80.0};
      final size2 = converter.fromJson(json2);
      expect(size2.width, 80.0);
      expect(size2.height, 0.0);

      final json3 = <String, double>{};
      final size3 = converter.fromJson(json3);
      expect(size3.width, 0.0);
      expect(size3.height, 0.0);
    });

    test('toJson returns correct map', () {
      final size = Size(123.4, 567.8);
      final json = converter.toJson(size);
      expect(json, {'width': 123.4, 'height': 567.8});
    });
  });
}
