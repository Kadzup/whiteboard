/*
 * Module: whiteboard_event.dart
 *
 * Created on: Sat Jun 22 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

part of 'whiteboard_bloc.dart';

@immutable
sealed class WhiteboardEvent {
  const WhiteboardEvent();
}

class EnterPenMode extends WhiteboardEvent {}

class EnterViewMode extends WhiteboardEvent {}

class StartPenDrawing extends WhiteboardEvent {
  final WhiteboardPath path;

  const StartPenDrawing({required this.path});
}

class UpdatePenDrawing extends WhiteboardEvent {
  final WhiteboardPath path;

  const UpdatePenDrawing({required this.path});
}

class ZoomLevelChanged extends WhiteboardEvent {
  final double zoomLevel;

  const ZoomLevelChanged({required this.zoomLevel});
}
