import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/image_placeholder.dart';

/// Виджет для отображения верхней части карточки достопримечательности
/// с информацией о типе [type] и картинкой по ссылке [url]
class PlaceCardTop extends StatelessWidget {
  final String type;
  final String? url;

  const PlaceCardTop({
    required this.type,
    this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.cardBorderRadius),
          topRight: Radius.circular(AppConstants.cardBorderRadius),
        ),
        child: SizedBox(
          height: AppConstants.placeCardImageHeight,
          width: double.infinity,
          child: url != null
              ? Image.network(
                  url ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const ImagePlaceholder();
                  },
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : const ImagePlaceholder(),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppConstants.defaultPadding,
                top: AppConstants.defaultPadding,
              ),
              child: Text(
                type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.smallBoldTextStyle
                    .copyWith(color: Theme.of(context).white),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
