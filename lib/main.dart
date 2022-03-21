import 'package:flutter/material.dart';
import 'package:places/constants.dart';
import 'package:places/my_first_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstWidget(
        title: 'Places',
      ),
    );
  }
}
