/*
 * Module: whiteboard_state.dart
 *
 * Created on: Sat Jun 22 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

part of 'whiteboard_bloc.dart';

enum WhiteboardMode {
  view,
  pen;
}

extension WhiteboardModeX on WhiteboardMode {
  bool get isView => this == WhiteboardMode.view;
  bool get isPen => this == WhiteboardMode.pen;
}

class WhiteboardSettings {
  final double maxZoom;
  final double minZoom;

  final Color penColor;
  final double penWidth;

  const WhiteboardSettings({
    required this.maxZoom,
    required this.minZoom,
    required this.penColor,
    required this.penWidth,
  })  : assert(maxZoom >= 0, "maxZoom can't be negative"),
        assert(minZoom >= 0, "minZoom can't be negative"),
        assert(penWidth >= 0, "maxZoom can't be negative");

  const WhiteboardSettings.initial()
      : maxZoom = 2.5,
        minZoom = 0.2,
        penColor = const Color(0xFF0A0A0E),
        penWidth = 4;

  Paint get penPaint {
    return Paint()
      ..color = penColor
      ..strokeWidth = penWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.miter;
  }
}

@immutable
class WhiteboardState {
  final WhiteboardSettings settings;
  final WhiteboardMode mode;

  final List<WhiteboardPath> paths;

  final double zoomLevel;

  const WhiteboardState({
    required this.settings,
    required this.mode,
    required this.paths,
    required this.zoomLevel,
  });

  const WhiteboardState.initial()
      : settings = const WhiteboardSettings.initial(),
        mode = WhiteboardMode.view,
        paths = const [],
        zoomLevel = 1.0;

  List<Object?> get props => [settings, mode];

  WhiteboardState copyWith({
    WhiteboardSettings? settings,
    WhiteboardMode? mode,
    List<WhiteboardPath>? paths,
    double? zoomLevel,
  }) {
    return WhiteboardState(
      settings: settings ?? this.settings,
      mode: mode ?? this.mode,
      paths: paths ?? this.paths,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }
}
