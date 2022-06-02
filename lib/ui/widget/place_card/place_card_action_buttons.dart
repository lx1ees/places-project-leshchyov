import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/common/custom_icon_button.dart';

/// Виджет кнопок действий на карточке достопримечательности, для каждого типа карточки свой
abstract class PlaceCardActionButtons extends StatefulWidget {
  const PlaceCardActionButtons({Key? key}) : super(key: key);
}

class PlaceToVisitCardActionButtons extends PlaceCardActionButtons {
  final VoidCallback onDeletePressed;
  final VoidCallback onPlanPressed;

  const PlaceToVisitCardActionButtons({
    required this.onDeletePressed,
    required this.onPlanPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceToVisitCardActionButtons> createState() =>
      _PlaceToVisitCardActionButtonsState();
}

class _PlaceToVisitCardActionButtonsState
    extends State<PlaceToVisitCardActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onPressed: widget.onPlanPressed,
          icon: SvgPicture.asset(
            AppAssets.calendarIcon,
            height: AppConstants.defaultIconSize,
            width: AppConstants.defaultIconSize,
            color: Theme.of(context).white,
          ),
        ),
        CustomIconButton(
          onPressed: widget.onDeletePressed,
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).white,
          ),
        ),
      ],
    );
  }
}

class PlaceVisitedCardActionButtons extends PlaceCardActionButtons {
  final VoidCallback onSharePressed;

  const PlaceVisitedCardActionButtons({
    required this.onSharePressed,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceVisitedCardActionButtons> createState() =>
      _PlaceVisitedCardActionButtonsState();
}

class _PlaceVisitedCardActionButtonsState
    extends State<PlaceVisitedCardActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onPressed: widget.onSharePressed,
          icon: SvgPicture.asset(
            AppAssets.shareIcon,
            height: AppConstants.defaultIconSize,
            width: AppConstants.defaultIconSize,
            color: Theme.of(context).white,
          ),
        ),
        CustomIconButton(
          onPressed: () {},
          icon: Icon(
            Icons.close_rounded,
            color: Theme.of(context).white,
          ),
        ),
      ],
    );
  }
}

class PlaceViewCardActionButtons extends PlaceCardActionButtons {
  final ValueChanged<Place> onFavoritePressed;
  final Place place;

  const PlaceViewCardActionButtons({
    required this.onFavoritePressed,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceViewCardActionButtons> createState() =>
      _PlaceViewCardActionButtonsState();
}

class _PlaceViewCardActionButtonsState
    extends State<PlaceViewCardActionButtons> {
  final StreamController<bool> _favoritesStreamController = StreamController();
  bool currentFavValue = false;

  @override
  void initState() {
    currentFavValue = widget.place.isInFavorites;
    super.initState();
  }

  @override
  void dispose() {
    _favoritesStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _favoritesStreamController.stream,
      initialData: widget.place.isInFavorites,
      builder: (context, snapshot) {
        final isInFavorites = snapshot.data;
        if (snapshot.hasData && isInFavorites != null) {
          return CustomIconButton(
            onPressed: () {
              currentFavValue = !currentFavValue;
              _favoritesStreamController.sink.add(currentFavValue);
              widget.onFavoritePressed(widget.place);
              // setState(() {});
            },
            icon: AnimatedSwitcher(
              duration: const Duration(
                milliseconds:
                    AppConstants.favoriteButtonAnimationDurationInMillis,
              ),
              child: SvgPicture.asset(
                isInFavorites ? AppAssets.heartFullIcon : AppAssets.heartIcon,
                key: UniqueKey(),
                height: AppConstants.defaultIconSize,
                width: AppConstants.defaultIconSize,
                color: Theme.of(context).white,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
