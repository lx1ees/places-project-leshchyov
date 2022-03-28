import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';

/// Виджет для отображения верхней части карточки достопримечательности
/// с информацией о типе [type] и картинкой по ссылке [url]
class SightCardTop extends StatelessWidget {
  final String type;
  final String url;

  const SightCardTop({
    required this.type,
    required this.url,
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
          height: AppConstants.sightCardImageHeight,
          width: double.infinity,
          child: Image(
            image: AssetImage(url),
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
          AppConstants.defaultPadding,
          0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sightCardTypeTextStyle,
              ),
            ),
            Container(
              height: AppConstants.defaultIconSize,
              width: AppConstants.defaultIconSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.heartIconAssetPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
