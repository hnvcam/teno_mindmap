import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class OffsetJsonConverter extends JsonConverter<Offset, Map<String, double>> {
  const OffsetJsonConverter();

  @override
  Offset fromJson(Map<String, double> json) {
    return Offset(json['dx'] ?? 0, json['dy'] ?? 0);
  }

  @override
  Map<String, double> toJson(Offset object) {
    return {'dx': object.dx, 'dy': object.dy};
  }
}
