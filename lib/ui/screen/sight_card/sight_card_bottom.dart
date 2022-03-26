import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения нижней части карточки достопримечательности
/// с наименованием достопримечательности [name] и кратким
/// описанием [shortDescription]
class SightCardBottom extends StatelessWidget {
  final String name;
  final String shortDescription;

  const SightCardBottom({
    required this.name,
    required this.shortDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        /// 🆘 ВОПРОС: поскольку у меня карточка состоит из двух частей, и каждая
        /// часть имеет внутренние отступы, то смысла в указании отступа между
        /// двумя частями SizedBox'ом нет. Пришлось здесь указать нулевой верхний
        /// отступ, чтобы задать его в родителе SizedBox'ом. Наверное, это имело бы
        /// смысл, если бы отдельные части карточки не имели внутренних отступов
        /// вообще и их устанавливал родитель, что в текущей верстке невозможно,
        /// так как отступы родителя затронут весь контент внутри, включая картинку и т.д.
        /// В таком случае нужно переверстывать на Stack и указывать отступы уже
        /// "наложенным" сверху на карточку текстовым виджетам и виджету кнопки
        /// избранное. Можно ли отказаться от отступа SizedBox'ом в родителе и вернуть
        /// здесь top padding? Или все переверстать на Stack?
        padding: const EdgeInsets.fromLTRB(
          AppConstants.defaultPadding,
          0,
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Касаемо 1-го задания:
            /// Если задавать половинную ширину виджета через ConstraintBox, нужно знать
            /// ширину родителя, то есть карточки. Если устанавливать ее родителю явно,
            /// то проблем не возникнет вычислить половину и назначить ConstraintBox'у
            /// в качестве ограничения maxWidth.
            /// Если ширина родителя неизвестна и занимает всю ширину экрана за исключением
            /// отступов (как сделано сейчас), то сначала нужно вычислить ее. Есть несколько
            /// способов, но они, мне кажется, избыточны. Проще всего сделать Row с двумя
            /// Expanded с flex = 1, в один из которых добавить наш текст.
            ///
            /// Ответ на вопрос "В виджете SightCard используйте ConstrainedBox,
            /// чтобы ограничить размер текста  по ширине до половины размера карточки.
            /// Посмотрите на результат. Почему размер виджета Text поменялся?":
            /// Размер виджета Text поменялся, потому что ConstrainedBox устанавливает
            /// дополнительные ограничения для своих чайлдов, которые не могут иметь
            /// ширину больше, чем ширина ограничения maxWidth ConstrainedBox'а в случае,
            /// если родитель ConstrainedBox'а устанавливает loose ограничения для него.
            /// Если бы родитель ConstrainedBox'а устанавливал ему tight ограничения, то
            /// чайлд ConstrainedBox'а проинорировал бы его ограничения и растянулся
            /// согласно ограничениям родителя ConstrainedBox'а. В данном случае родитель
            /// ConstraintBox'а - Column задает ему loose ограничения, следовательно
            /// текст подстраивается под ограничения ConstraintBox'а, а не Column'а.
            Text(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.sightCardNameTextStyle,
            ),
            Flexible(
              child: Text(
                shortDescription,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sightCardDetailsTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
