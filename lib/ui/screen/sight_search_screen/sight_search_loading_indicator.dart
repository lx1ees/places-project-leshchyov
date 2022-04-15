import 'package:flutter/material.dart';

/// Виджет индикатора загрузки для окна поиска мест
class SightSearchLoadingIndicator extends StatelessWidget {
  const SightSearchLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
