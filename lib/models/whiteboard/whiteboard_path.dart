/*
 * Module: whiteboard_path.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WhiteboardPath {
  final path = Path();
  final List<Offset> points;

  Paint paint;

  WhiteboardPath({
    required this.paint,
    required this.points,
  });

  void moveTo(double x, double y) => path.moveTo(x, y);

  void lineTo(double x, double y) {
    path.lineTo(x, y);
    path.moveTo(x, y);
  }

  void quadric(double x, double y) =>
      path.quadraticBezierTo(points.last.dx, points.last.dy, x, y);

  void addDot(double x, double y) {
    path.addOval(
        Rect.fromCircle(center: Offset(x, y), radius: paint.strokeWidth / 2));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WhiteboardPath &&
        listEquals(other.points, points) &&
        other.paint == paint;
  }

  @override
  int get hashCode => points.hashCode ^ paint.hashCode;
}
