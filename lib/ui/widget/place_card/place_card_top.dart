import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/common/image_placeholder.dart';

/// Виджет для отображения верхней части карточки достопримечательности
/// с информацией о типе [type] и картинкой по ссылке [url]
class PlaceCardTop extends StatefulWidget {
  final String type;
  final String? url;

  const PlaceCardTop({
    required this.type,
    this.url,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceCardTop> createState() => _PlaceCardTopState();
}

class _PlaceCardTopState extends State<PlaceCardTop> {
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
          child: widget.url != null
              ? Image.network(
                  widget.url ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const ImagePlaceholder();
                  },
                  frameBuilder: (_, child, frame, __) {
                    return AnimatedCrossFade(
                      firstChild: Center(
                        child: frame != null
                            ? const SizedBox.shrink()
                            : const CircularProgressIndicator(),
                      ),
                      secondChild: Row(
                        children: [
                          Expanded(child: child),
                        ],
                      ),
                      firstCurve: Curves.easeIn,
                      secondCurve: Curves.easeIn,
                      duration: const Duration(
                        milliseconds: AppConstants
                            .imageAppearanceAnimationDurationInMillis,
                      ),
                      crossFadeState: frame != null
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
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
                widget.type,
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
