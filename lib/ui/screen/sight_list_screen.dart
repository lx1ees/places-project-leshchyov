import 'package:flutter/material.dart';
import 'package:places/constants.dart';
import 'package:places/ui/widget/app_bar_title.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: toolbarHeight,
        title: const Padding(
          padding: EdgeInsets.only(top: 40),
          child: AppBarTitle(),
        ),
      ),
      body: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
