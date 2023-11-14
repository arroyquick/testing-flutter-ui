import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

enum WidgetType { widget, screen }

/// A wrapper to create a [MaterialApp] and pass it the widget that is to be
/// tested as the first argument
///
///The second argument [widgetType] is to specify that the widget
///in question is of type [widget] or a [screen] which consists of a Scaffold
MaterialApp materialMocker(Widget widget, WidgetType widgetType) {
  return MaterialApp(
    builder: (context, child) =>
        ResponsiveBreakpoints.builder(child: child!, breakpoints: [
      const Breakpoint(start: 0, end: 360, name: 'SMALL_MOBILE'),
      const Breakpoint(start: 361, end: 450, name: MOBILE),
      const Breakpoint(start: 451, end: 800, name: TABLET),
      const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      const Breakpoint(start: 1921, end: double.infinity, name: '4K')
    ]),
    home: widgetType == WidgetType.widget
        ? Scaffold(
            body: widget,
          )
        : widget,
  );
}
