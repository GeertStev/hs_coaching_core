import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart' show Colors;
import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/sketch/sketch_element.dart';
import 'package:hs_coaching_core/sketch/sketch_geometry.dart';

void expectOffset(Offset actual, Offset expected) {
  expect(actual.dx, closeTo(expected.dx, 1e-9));
  expect(actual.dy, closeTo(expected.dy, 1e-9));
}

RectangleElement rect({double rotation = 0}) => RectangleElement(
  id: 'r',
  color: Colors.white,
  strokeWidth: 2,
  start: const Offset(0, 0),
  end: const Offset(20, 10),
  rotation: rotation,
);

void main() {
  test('hoekpunten zonder rotatie', () {
    final corners = rectangleCorners(rect());
    expect(corners, const [
      Offset(0, 0),
      Offset(20, 0),
      Offset(20, 10),
      Offset(0, 10),
    ]);
  });

  test('hoekpunten na een kwartslag rond het middelpunt', () {
    final corners = rectangleCorners(rect(rotation: math.pi / 2));
    // Middelpunt (10, 5); breedte 20 wordt verticaal.
    expectOffset(corners[0], const Offset(15, -5));
    expectOffset(corners[1], const Offset(15, 15));
    expectOffset(corners[2], const Offset(5, 15));
    expectOffset(corners[3], const Offset(5, -5));
  });

  test('oud document zonder rotation leest als 0', () {
    final json = jsonDecode(jsonEncode(rect().toJson())) as Map<String, dynamic>
      ..remove('rotation');
    final parsed = SketchElement.fromJson(json) as RectangleElement;
    expect(parsed.rotation, 0);
  });

  test('rotation gaat mee in toJson', () {
    final json = jsonDecode(jsonEncode(rect(rotation: 1.5).toJson()));
    expect(json['rotation'], 1.5);
  });
}
