import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/utils/extensions.dart';

/// Виджет для отображения верхней части карточки достопримечательности
/// с информацией о типе [type] и картинкой по ссылке [url]
/// Если карточка предназначена для вывода достопримечательности в списке
/// для посещения, то передается флаг [isVisitable] в состоянии true.
/// Если достоиримечательность посещена, то передается флаг [isVisited] в
/// состоянии true.
class SightCardTop extends StatelessWidget {
  final String type;
  final String url;
  final bool isVisitable;
  final bool isVisited;

  const SightCardTop({
    required this.type,
    required this.url,
    this.isVisitable = false,
    this.isVisited = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionIconPath = isVisited
        ? AppAssets.shareIconAssetPath
        : AppAssets.calendarIconAssetPath;

    return Stack(children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.cardBorderRadius),
          topRight: Radius.circular(AppConstants.cardBorderRadius),
        ),
        child: SizedBox(
          height: AppConstants.sightCardImageHeight,
          width: double.infinity,
          child: Image.network(
            url,
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
                style: AppTypography.smallBoldTextStyle
                    .copyWith(color: Theme.of(context).white),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  isVisitable ? actionIconPath : AppAssets.heartIconAssetPath,
                  height: AppConstants.defaultIconSize,
                  width: AppConstants.defaultIconSize,
                  color: Colors.white,
                ),
                Visibility(
                  visible: isVisitable,
                  child: Row(
                    children: [
                      const SizedBox(width: 22),
                      Icon(
                        Icons.close_rounded,
                        color: Theme.of(context).white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
