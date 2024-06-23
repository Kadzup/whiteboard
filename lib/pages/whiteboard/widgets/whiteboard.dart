/*
 * Module: whiteboard.dart
 *
 * Created on: Sun Jun 23 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/material.dart';

import 'package:whiteboard/pages/whiteboard/widgets/whiteboard_canvas.dart';
import 'package:whiteboard/pages/whiteboard/widgets/zoom_indicator.dart';

class Whiteboard extends StatelessWidget {
  const Whiteboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(child: WhiteboardCanvas()),
        Positioned(bottom: 8, child: ZoomIndicator()),
      ],
    );
  }
}
