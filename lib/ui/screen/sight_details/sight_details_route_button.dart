import 'package:flutter/material.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';

/// Виджет кнопки построения маршрута
class SightDetailsRouteButton extends StatelessWidget {
  const SightDetailsRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 🆘 ВОПРОС: Сначала сделал кнопку фиксированной ширины как в прототипе,
    /// но потом растянул на всю ширину экрана. Как в итоге лучше сделать?
    /// Кажется, что первый вариант предпочтительней, т.к. например на
    /// планшетах растянутая кнопка будет смотреться не очень...
    return Container(
      color: AppColors.sightButton2MockColor,
      width: double.infinity,
      height: AppConstants.sightDetailsRouteButtonHeight,
    );
  }
}
