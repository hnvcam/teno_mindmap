import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class SizeJsonConverter extends JsonConverter<Size, Map<String, double>> {
  const SizeJsonConverter();

  @override
  Size fromJson(Map<String, double> json) {
    return Size(json['width'] ?? 0, json['height'] ?? 0);
  }

  @override
  Map<String, double> toJson(Size object) {
    return {'width': object.width, 'height': object.height};
  }
}
