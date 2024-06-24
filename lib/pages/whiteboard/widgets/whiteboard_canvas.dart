/*
 * Module: whiteboard_canvas.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whiteboard/bloc/whiteboard/whiteboard_bloc.dart';

import 'package:whiteboard/models/whiteboard/whiteboard_drawing.dart';
import 'package:whiteboard/models/whiteboard/whiteboard_path.dart';

import 'package:whiteboard/pages/whiteboard/common/whiteboard_painter.dart';

extension _XTransformationController on TransformationController {
  Offset toCurrentScene(Offset viewportPoint) {
    final inverseMatrix = Matrix4.tryInvert(value);

    if (inverseMatrix is! Matrix4) return viewportPoint;

    return MatrixUtils.transformPoint(inverseMatrix, viewportPoint);
  }
}

class WhiteboardCanvas extends StatefulWidget {
  const WhiteboardCanvas({super.key});

  @override
  State<WhiteboardCanvas> createState() => _WhiteboardCanvasState();
}

class _WhiteboardCanvasState extends State<WhiteboardCanvas> {
  final _transformationController = TransformationController();

  int _activePointerCount = 0;
  Offset _lastFocalPoint = Offset.zero;

  WhiteboardPath _tempPath = WhiteboardPath(
    paint: Paint(),
    points: [],
  );

  void _onInteractionStart(
    ScaleStartDetails details,
    WhiteboardBloc bloc,
    WhiteboardState state,
  ) {
    _activePointerCount = details.pointerCount;
    _lastFocalPoint = details.focalPoint;

    if (state.mode.isView || _activePointerCount > 1) return;

    final localPosition = _transformationController.toCurrentScene(
      details.localFocalPoint,
    );

    _tempPath = WhiteboardPath(
      paint: state.settings.penPaint,
      points: [localPosition],
    );

    _tempPath.moveTo(localPosition.dx, localPosition.dy);

    bloc.add(StartPenDrawing(path: _tempPath));
  }

  void _onInteractionUpdate(
    ScaleUpdateDetails details,
    WhiteboardBloc bloc,
    WhiteboardState state,
  ) {
    _activePointerCount = details.pointerCount;
    final currentScale = _transformationController.value.getMaxScaleOnAxis();

    bloc.add(ZoomLevelChanged(zoomLevel: currentScale));

    if (_activePointerCount > 1) return;

    if (state.mode.isPen) {
      _handleDrawing(details, bloc);
    } else {
      _handleMoving(details, currentScale);
    }
  }

  void _onInteractionEnd(
    ScaleEndDetails details,
    WhiteboardBloc bloc,
    WhiteboardState state,
  ) {
    final prevPointerCount = _activePointerCount;
    _activePointerCount = 0;

    if (state.mode.isView || prevPointerCount > 1) return;

    bloc.add(UpdatePenDrawing(path: _tempPath));
  }

  void _handleDrawing(ScaleUpdateDetails details, WhiteboardBloc bloc) {
    final point = _transformationController.toCurrentScene(
      details.localFocalPoint,
    );

    _tempPath.quadric(point.dx, point.dy);
    _tempPath.points.add(point);

    bloc.add(UpdatePenDrawing(path: _tempPath));
  }

  void _handleMoving(ScaleUpdateDetails details, double currentScale) {
    final translationDelta = details.focalPoint - _lastFocalPoint;
    _lastFocalPoint = details.focalPoint;

    _transformationController.value.translate(
      translationDelta.dx / currentScale,
      translationDelta.dy / currentScale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhiteboardBloc, WhiteboardState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<WhiteboardBloc>(context);

        return InteractiveViewer(
          transformationController: _transformationController,
          minScale: state.settings.minZoom,
          maxScale: state.settings.maxZoom,
          panEnabled: false,
          scaleEnabled: true,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          onInteractionStart: (details) {
            _onInteractionStart(details, bloc, state);
          },
          onInteractionUpdate: (details) {
            _onInteractionUpdate(details, bloc, state);
          },
          onInteractionEnd: (details) {
            _onInteractionEnd(details, bloc, state);
          },
          child: CustomPaint(
            isComplex: true,
            willChange: true,
            size: Size.infinite,
            foregroundPainter: WhiteboardPainter(
              drawing: WhiteboardDrawing(whiteboardPaths: state.paths),
            ),
          ),
        );
      },
    );
  }
}
