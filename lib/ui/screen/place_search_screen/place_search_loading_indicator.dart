import 'package:flutter/material.dart';

/// Виджет индикатора загрузки для окна поиска мест
class PlaceSearchLoadingIndicator extends StatelessWidget {
  const PlaceSearchLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
