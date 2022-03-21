import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello!'),
      ),
      /// Этот аттрибут [resizeToAvoidBottomInset] регулирует возможность
      /// Scaffold'а реагировать на изменение размера экрана.
      /// Если он установлен в false, то Scaffold не будет изменять свои размеры,
      /// например, при появлении клавиатуры, которая в этом случае перекроет
      /// весь контент под ней.
      resizeToAvoidBottomInset: false,
    );
  }
}
