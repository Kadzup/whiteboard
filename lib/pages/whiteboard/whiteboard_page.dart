/*
 * Module: whiteboard_page.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whiteboard/bloc/whiteboard/whiteboard_bloc.dart';

import 'package:whiteboard/pages/whiteboard/widgets/whiteboard.dart';

class WhiteboardPage extends StatelessWidget {
  static const routeName = '/whiteboard';

  const WhiteboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WhiteboardBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            tooltip: 'Back',
            icon: const Icon(CupertinoIcons.arrow_left),
          ),
          title: const Text('4338-0234-45'),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Settings',
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<WhiteboardBloc, WhiteboardState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () => context.read<WhiteboardBloc>().add(
                    state.mode.isView ? EnterPenMode() : EnterViewMode(),
                  ),
              tooltip: state.mode.isView ? 'Enter pen mode' : 'Exit pen mode',
              child: Icon(
                state.mode.isView
                    ? CupertinoIcons.hand_draw
                    : CupertinoIcons.clear,
              ),
            );
          },
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Positioned.fill(child: Whiteboard()),
            Positioned(
              top: 0,
              child: Text(
                'Describe the site and location on the map',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'MacPaw',
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
