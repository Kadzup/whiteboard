/*
 * Module: whiteboard_painter.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:whiteboard/models/whiteboard/whiteboard_drawing.dart';

class WhiteboardPainter extends CustomPainter {
  final WhiteboardDrawing drawing;

  WhiteboardPainter({
    required this.drawing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (drawing.whiteboardPaths.isEmpty) return;

    for (var path in drawing.whiteboardPaths) {
      final radius = sqrt(path.paint.strokeWidth) / 20;
      final paint = path.paint;

      canvas.drawPath(path.path, paint);

      if (path.points.isNotEmpty) {
        canvas.drawCircle(path.points.first, radius, paint);
      }

      for (int i = 1; i < path.points.length; i++) {
        final prevPoint = path.points[i - 1];
        final curPoint = path.points[i];
        final distance = (curPoint - prevPoint).distance;

        if (distance > radius * 2) canvas.drawCircle(curPoint, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant WhiteboardPainter oldDelegate) {
    return true;
  }
}
