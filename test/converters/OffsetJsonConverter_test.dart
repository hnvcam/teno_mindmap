import 'package:flutter_test/flutter_test.dart';
import 'package:teno_mindmap/converters/OffsetJsonConverter.dart';

void main() {
  group('OffsetJsonConverter', () {
    final converter = OffsetJsonConverter();

    test('fromJson returns correct Offset', () {
      final json = {'dx': 10.0, 'dy': 20.0};
      final offset = converter.fromJson(json);
      expect(offset.dx, 10.0);
      expect(offset.dy, 20.0);
    });

    test('fromJson with missing dx or dy defaults to 0', () {
      final json1 = {'dy': 15.0};
      final offset1 = converter.fromJson(json1);
      expect(offset1.dx, 0.0);
      expect(offset1.dy, 15.0);

      final json2 = {'dx': 5.0};
      final offset2 = converter.fromJson(json2);
      expect(offset2.dx, 5.0);
      expect(offset2.dy, 0.0);

      final json3 = <String, double>{};
      final offset3 = converter.fromJson(json3);
      expect(offset3.dx, 0.0);
      expect(offset3.dy, 0.0);
    });

    test('toJson returns correct map', () {
      final offset = Offset(3.5, 7.2);
      final json = converter.toJson(offset);
      expect(json, {'dx': 3.5, 'dy': 7.2});
    });
  });
}
