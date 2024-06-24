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

      canvas.drawPath(path.path, path.paint);

      for (int i = 0; i < path.points.length - 1; i++) {
        canvas.drawCircle(path.points.elementAt(i), radius, path.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant WhiteboardPainter oldDelegate) => true;
}
