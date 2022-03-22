import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/constants.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 🆘 ВОПРОС: нужно ли было стилизовать статус бар? В макете он отличается
        // от того, что по-умолчанию (имеет такой же цвет как у AppBar).
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: toolbarHeight,
        title: const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'Список\nинтересных мест',
            maxLines: 2,
            style: appBarTitleTextStyle,
          ),
        ),
      ),
      body: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
