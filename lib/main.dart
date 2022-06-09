import 'package:flutter/material.dart';
import 'package:places/app_scoped.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';
import 'package:places/ui/screen/app/app.dart';
import 'package:places/ui/screen/app/app_widget_model.dart';

void main() {
  _defineEnvironment(buildConfig: _setupConfig());

  runApp(AppScoped(
    child: Builder(builder: (context) {
      return const App(
        widgetModelFactory: appWidgetModelFactory,
      );
    }),
  ));
}

void _defineEnvironment({
  required BuildConfig buildConfig,
}) {
  Environment.init(
    buildConfig: buildConfig,
    buildType: BuildType.dev,
  );
}

BuildConfig _setupConfig() {
  return const BuildConfig(
    envString: 'Debug',
    envTitle: 'Debug сборка приложения',
  );
}
