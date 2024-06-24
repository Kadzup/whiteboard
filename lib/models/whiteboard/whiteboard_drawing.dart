/*
 * Module: whiteboard_drawing.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/foundation.dart';

import 'package:whiteboard/models/whiteboard/whiteboard_path.dart';

class WhiteboardDrawing {
  final List<WhiteboardPath> whiteboardPaths;

  const WhiteboardDrawing({
    required this.whiteboardPaths,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WhiteboardDrawing &&
        listEquals(other.whiteboardPaths, whiteboardPaths);
  }

  @override
  int get hashCode => whiteboardPaths.hashCode;
}
