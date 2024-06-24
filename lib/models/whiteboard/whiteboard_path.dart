/*
 * Module: whiteboard_path.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'dart:math';

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

  void quadric(double x, double y) {
    final distance = sqrt(
      pow(x - points.last.dx, 2) + pow(y - points.last.dy, 2),
    );

    if (paint.strokeWidth <= 2) {
      return path.quadraticBezierTo(points.last.dx, points.last.dy, x, y);
    }

    if (distance > 3) {
      return path.quadraticBezierTo(points.last.dx, points.last.dy, x, y);
    }

    return path.moveTo(x, y);
  }

  List<Object?> get props => [paint];

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
