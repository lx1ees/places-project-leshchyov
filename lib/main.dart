import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/theme_mode_holder.dart';
import 'package:places/ui/screen/home_screen/home_screen.dart';
import 'package:places/ui/screen/res/themes.dart';

void main() {
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeModeHolder.addListener(_themeModeHolderListener);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeHolder.currentThemeMode,
      home: const HomeScreen(),
    );
  }

  @override
  void dispose() {
    themeModeHolder.removeListener(_themeModeHolderListener);
    super.dispose();
  }

  void _themeModeHolderListener() {
    setState(() {});
  }
}
