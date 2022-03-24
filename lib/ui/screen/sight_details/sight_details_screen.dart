import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details/sight_details_action_button.dart';
import 'package:places/ui/screen/sight_details/sight_details_description.dart';
import 'package:places/ui/screen/sight_details/sight_details_image_gallery.dart';
import 'package:places/ui/screen/sight_details/sight_details_route_button.dart';
import 'package:places/ui/screen/sight_details/sight_details_title.dart';

/// Виджет-окно для отображения полной информации о [sight] достопримечательности
/// и выполнения действий с ней
class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final sight = widget.sight;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SightDetailsImageGallery(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.defaultPaddingX1_5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SightDetailsTitle(
                      name: sight.name,
                      type: sight.type,

                      /// 🆘 ВОПРОС: в модельке нет подходящего поля, появится позже?
                      shortDescription: AppStrings.sightShortDescriptionMock,
                    ),
                    const SizedBox(height: AppConstants.defaultPaddingX1_5),
                    SightDetailsDescription(description: sight.details),
                    const SizedBox(height: AppConstants.defaultPaddingX1_5),
                    const SightDetailsRouteButton(),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Divider(
                      thickness: AppConstants.defaultDividerThickness,
                      height: AppConstants.defaultPadding,
                    ),

                    /// 🆘 ВОПРОС: Здесь же наоборот - сделал кнопки 'Запланировать' и 'В Избранное'
                    /// фиксированной ширины и расположил по центру рядом друг с другом. В прототипе
                    /// не совсем понятно, должны ли они располагатсья так или быть выравнены относительно
                    /// краёв слева и справа.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SightDetailsActionButton(
                          title: AppStrings.sightDetailsPlanActionButtonTitle,
                        ),
                        SightDetailsActionButton(
                          title: AppStrings.sightDetailsInFavActionButtonTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
