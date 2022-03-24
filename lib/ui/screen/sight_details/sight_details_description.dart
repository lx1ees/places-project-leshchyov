import 'package:flutter/material.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения полного описания (деталей) [description] достопримечательности
class SightDetailsDescription extends StatelessWidget {
  final String description;

  const SightDetailsDescription({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Текст описания обернул в Flexible, чтобы так же не было overflow,
    /// если он слишком длинный. И еще в SingleChildScrollView вдобавок, чтобы
    /// его не обрезать, чтобы можно было прокручивать его в таком случае.
    /// 🆘 ВОПРОС: Здесь показываю скроллбар постоянно (только если текст слишком длинный),
    /// чтобы пользователь видел, что текст можно прокручивать. Нормальная ли это практика?
    return Flexible(
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Text(
            description,
            style: AppTypography.sightDetailsDescriptionTextStyle,
          ),
        ),
      ),
    );
  }
}
