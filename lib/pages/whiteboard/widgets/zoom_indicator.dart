/*
 * Module: zoom_indicator.dart
 *
 * Created on: Sat Jun 22 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whiteboard/bloc/whiteboard/whiteboard_bloc.dart';

class ZoomIndicator extends StatefulWidget {
  const ZoomIndicator({super.key});

  @override
  State<ZoomIndicator> createState() => _ZoomIndicatorState();
}

class _ZoomIndicatorState extends State<ZoomIndicator> {
  double _zoomLevel = 1.0;
  bool _isVisible = false;

  Timer? _hideTimer;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _showZoomLevel(double zoomLevel) {
    if (zoomLevel == _zoomLevel) return;

    setState(() {
      _zoomLevel = zoomLevel;
      _isVisible = true;
    });

    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BlocListener<WhiteboardBloc, WhiteboardState>(
        listener: (context, state) => _showZoomLevel(state.zoomLevel),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Material(
            color: const Color(0xFF0A0A0E).withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 16.w,
              ),
              child: Text(
                'Zoom ${(_zoomLevel * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'MacPaw',
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
