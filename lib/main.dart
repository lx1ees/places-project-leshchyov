import 'package:flutter/material.dart';
import 'package:places/app_scoped.dart';
import 'package:places/ui/screen/app/app.dart';
import 'package:places/ui/screen/app/app_widget_model.dart';

void main() {
  runApp(AppScoped(
    child: Builder(builder: (context) {
      return const App(
        widgetModelFactory: appWidgetModelFactory,
      );
    }),
  ));
}
