import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_details/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';

void main() {
  initializeDateFormatting();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home:
      // const VisitingScreen(),
      const SightListScreen(),
      // home: SightDetailsScreen(
      //   sight: mocks[2],
      // ),
    );
  }
}
