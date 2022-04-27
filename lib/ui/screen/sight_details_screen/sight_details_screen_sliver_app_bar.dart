import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_image_gallery.dart';
import 'package:places/ui/widgets/custom_icon_with_background_button.dart';
import 'package:places/utils/extensions.dart';

/// Аппбар для экрана деталей о месте
class SightDetailsScreenSliverAppBar extends StatefulWidget {
  final Sight sight;
  final ScrollController scrollController;
  final bool isBackButtonVisible;

  const SightDetailsScreenSliverAppBar({
    required this.sight,
    required this.scrollController,
    this.isBackButtonVisible = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SightDetailsScreenSliverAppBar> createState() =>
      _SightDetailsScreenSliverAppBarState();
}

class _SightDetailsScreenSliverAppBarState
    extends State<SightDetailsScreenSliverAppBar> {
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
      expandedHeight: AppConstants.sightDetailsGalleryHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: AppConstants.appbarHorizontalPadding,
          right: AppConstants.appbarHorizontalPadding,
          bottom: AppConstants.defaultPadding,
        ),
        title: Opacity(
          opacity: _appBarTitleOpacity,
          child: Text(
            widget.sight.name.nbsp,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        // centerTitle: true,
        background: SightDetailsImageGallery(urls: widget.sight.urls),
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
        AppConstants.sightDetailsGalleryHeight - scrollController.offset;
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
