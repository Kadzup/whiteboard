/*
 * Module: app.dart
 *
 * Created on: Fri Jun 21 2024
 *
 * Copyright (C) 2024 Dmytro Stefurak
 * Author: Dmytro Stefurak
 */

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whiteboard/pages/whiteboard/whiteboard_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFEF9),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFFFFFEF9),
              foregroundColor: const Color(0xFF0A0A0E),
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: const Color(0xFF0A0A0E),
                fontSize: 24.sp,
                height: 1.7,
                fontWeight: FontWeight.w600,
                fontFamily: 'MacPaw',
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 4,
              backgroundColor: Color(0xFFEDE9F9),
              foregroundColor: Color(0xFF0A0A0E),
              shape: CircleBorder(
                side: BorderSide(color: Color(0xFFD5CBF0)),
              ),
            ),
          ),
          initialRoute: WhiteboardPage.routeName,
          routes: {
            WhiteboardPage.routeName: (context) => const WhiteboardPage(),
          },
        );
      },
    );
  }
}
