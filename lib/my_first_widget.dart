import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyFirstWidget extends StatelessWidget {
  final String title;
  int buildCounter = 0;

  MyFirstWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildCounter++;
    if (kDebugMode) {
      /*
      * Поскольку это StatelessWidget, у него нет состояния, в котором могли бы
      * храниться какие-то значения. Соответственно объявленная переменная
      * при ребилде виджета инициализируется снова значением 0, поэтому инкремент
      * этой переменной при ребилде виджета всегда даст значение 1.
      * Так как Widget сам по себе иммутабельный, то объявлять не константные или
      * не final поля не рекомендуется, это не приведет ни к чему, так как они все
      * равно не изменят своего значения после ребилда виджета.
      * */
      print(buildCounter);
    }
    return Container(
      child: Center(
        child: Text(title),
      ),
    );
  }

  Type _runtimeType() {
    /*
    * Здесь context недоступен, поскольку класс Widget не содержит контекст,
    * он передается в метод build.
    * */
    return context.runtimeType;
  }
}
