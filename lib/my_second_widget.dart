import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  State<MySecondWidget> createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int buildCounter = 0;

  @override
  Widget build(BuildContext context) {
    _incrementBuildCount();
    if (kDebugMode) {
      /*
      * Поскольку это StatefulWidget, у него есть состояние, в котором могут
      * храниться какие-то значения. Соответственно объявленная переменная  в
      * классе стейта виджета при каждом ребилде виджета инкрементируется и
      * хранится в стейте.
      * */
      print(buildCounter);
    }
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }

  Future<void> _incrementBuildCount() async {
    setState(() {
      buildCounter++;
    });
  }

  Type _runtimeType(){
    /*
    * Здесь context доступен, поскольку класс State содержит Element он же context
    * */
    return context.runtimeType;
  }
}
