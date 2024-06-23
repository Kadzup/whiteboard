/*
 * Module: whiteboard_bloc.dart
 *
 * Created on: Sat Jun 22 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/painting.dart'
    show Color, Paint, PaintingStyle, StrokeJoin;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whiteboard/models/whiteboard/whiteboard_path.dart';

part 'whiteboard_event.dart';
part 'whiteboard_state.dart';

class WhiteboardBloc extends Bloc<WhiteboardEvent, WhiteboardState> {
  WhiteboardBloc() : super(const WhiteboardState.initial()) {
    on<EnterPenMode>(_onEnterPenMode);
    on<EnterViewMode>(_onEnterViewMode);
    on<StartPenDrawing>(_onStartPenDrawing);
    on<UpdatePenDrawing>(_onUpdatePenDrawing);
    on<ZoomLevelChanged>(_onZoomLevelChanged);
  }

  void _onEnterPenMode(_, Emitter<WhiteboardState> emit) {
    emit(state.copyWith(mode: WhiteboardMode.pen));
  }

  void _onEnterViewMode(_, Emitter<WhiteboardState> emit) {
    emit(state.copyWith(mode: WhiteboardMode.view));
  }

  void _onStartPenDrawing(
    StartPenDrawing event,
    Emitter<WhiteboardState> emit,
  ) {
    final updatedPaths = List.of(state.paths);
    updatedPaths.add(event.path);

    emit(state.copyWith(paths: updatedPaths));
  }

  void _onUpdatePenDrawing(
    UpdatePenDrawing event,
    Emitter<WhiteboardState> emit,
  ) {
    final updatedPaths = List.of(state.paths);

    final index = updatedPaths.indexWhere((path) => path == event.path);
    if (index != -1) updatedPaths[index] = event.path;

    emit(state.copyWith(paths: updatedPaths));
  }

  void _onZoomLevelChanged(
    ZoomLevelChanged event,
    Emitter<WhiteboardState> emit,
  ) {
    emit(state.copyWith(zoomLevel: event.zoomLevel));
  }
}
