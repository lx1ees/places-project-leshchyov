import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/widget/common/custom_icon_with_background_button.dart';
import 'package:places/ui/widget/place_details/place_details_image_gallery.dart';
import 'package:places/utils/extensions.dart';

/// Аппбар для экрана деталей о месте
class PlaceDetailsScreenSliverAppBar extends StatefulWidget {
  final Place place;
  final ScrollController scrollController;
  final bool isBackButtonVisible;

  const PlaceDetailsScreenSliverAppBar({
    required this.place,
    required this.scrollController,
    this.isBackButtonVisible = false,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceDetailsScreenSliverAppBar> createState() =>
      _PlaceDetailsScreenSliverAppBarState();
}

class _PlaceDetailsScreenSliverAppBarState
    extends State<PlaceDetailsScreenSliverAppBar> {
  static const double _opacityThreshold = 100;
  double _appBarTitleOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScrolled);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrolled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      elevation: 0,
      leading: widget.isBackButtonVisible
          ? CustomIconWithBackgroundButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: AppConstants.defaultButtonIconSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : const SizedBox.shrink(),
      expandedHeight: AppConstants.placeDetailsGalleryHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: AppConstants.appbarHorizontalPadding,
          right: AppConstants.appbarHorizontalPadding,
          bottom: AppConstants.defaultPadding,
        ),
        title: Opacity(
          opacity: _appBarTitleOpacity,
          child: Text(
            widget.place.name.nbsp,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        // centerTitle: true,
        background: PlaceDetailsImageGallery(urls: widget.place.urls),
      ),
    );
  }

  void _onScrolled() {
    setState(() {
      _appBarTitleOpacity = _calculateAppBarTitleOpacity(
        scrollController: widget.scrollController,
        opacityThreshold: _opacityThreshold,
      );
    });
  }

  /// Метод вычисляет значение прозрачности для заголовка аппбара по мере скролла
  /// с помощью значения offset у [scrollController] и порогового значения [opacityThreshold],
  /// при котором прозрачнгсть меняется
  double _calculateAppBarTitleOpacity({
    required ScrollController scrollController,
    required double opacityThreshold,
  }) {
    final deltaHeight =
        AppConstants.placeDetailsGalleryHeight - scrollController.offset;
    final currentScrollOffset = deltaHeight > opacityThreshold
        ? opacityThreshold
        : deltaHeight < kToolbarHeight
            ? kToolbarHeight
            : deltaHeight;

    return 1 -
        (currentScrollOffset - kToolbarHeight) /
            (opacityThreshold - kToolbarHeight);
  }
}
