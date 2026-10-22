import 'dart:math' as math;
import 'dart:ui';

import 'package:hs_coaching_core/sketch/sketch_element.dart';

/// Pure geometrie voor sketch-elementen, gedeeld door de app (bewerken) en het scherm (tekenen).
/// Alles werkt in doelscherm-coördinaten.

/// Draait [point] rond [center] over [angle] radialen.
Offset rotateAround(Offset point, Offset center, double angle) {
  if (angle == 0) return point;
  final cos = math.cos(angle);
  final sin = math.sin(angle);
  final d = point - center;
  return center + Offset(d.dx * cos - d.dy * sin, d.dx * sin + d.dy * cos);
}

/// Middelpunt van een rechthoek (rotatie verandert dit niet).
Offset rectangleCenter(RectangleElement rect) => (rect.start + rect.end) / 2;

/// De vier hoekpunten van een (eventueel gedraaide) rechthoek, in volgorde rond de rand:
/// start, (end.x, start.y), end, (start.x, end.y).
List<Offset> rectangleCorners(RectangleElement rect) {
  final center = rectangleCenter(rect);
  return [
    rect.start,
    Offset(rect.end.dx, rect.start.dy),
    rect.end,
    Offset(rect.start.dx, rect.end.dy),
  ].map((c) => rotateAround(c, center, rect.rotation)).toList();
}
