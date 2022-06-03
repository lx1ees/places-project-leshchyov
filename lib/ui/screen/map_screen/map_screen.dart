import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screen/map_screen/map_screen_widget_model.dart';
import 'package:places/ui/screen/place_list_screen/place_list_screen_widget_model.dart';
import 'package:places/ui/widget/common/gradient_extended_fab.dart';
import 'package:places/ui/widget/common/loading_indicator.dart';
import 'package:places/ui/widget/place_card/place_view_card.dart';
import 'package:places/ui/widget/place_list/place_list.dart';
import 'package:places/ui/widget/place_list/place_list_error_placeholder.dart';
import 'package:places/ui/widget/place_list/place_list_screen_sliver_app_bar.dart';
import 'package:places/ui/widget/place_search/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Виджет, описывающий экран с картой интересных мест
class MapScreen extends ElementaryWidget<IMapScreenWidgetModel> {
  static const String routeName = '/map';

  const MapScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(
          widgetModelFactory,
          key: key,
        );

  @override
  Widget build(IMapScreenWidgetModel wm) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientExtendedFab(
        icon: SvgPicture.asset(AppAssets.plusIcon),
        label: AppStrings.newPlaceTitle.toUpperCase(),
        startColor: wm.colorScheme.surfaceVariant,
        endColor: wm.colorScheme.secondary,
        onPressed: wm.onAddNewPlacePressed,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.mapScreenAppBarTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: wm.colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: wm.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: AppConstants.defaultPaddingX0_5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: SearchBar(
              isBlocked: true,
              onOpenFiltersPressed: wm.onFiltersPressed,
              onTap: wm.onSearchPressed,
              theme: wm.theme,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPaddingX1_5),
          Expanded(
            child: EntityStateNotifierBuilder<List<Place>>(
              listenableEntityState: wm.listPlacesState,
              builder: (_, places) {
                if (places == null) return const PlaceListErrorPlaceholder();

                return YandexMap(
                  nightModeEnabled: wm.theme.brightness == Brightness.dark,
                  onMapCreated: wm.onMapCreated,
                );
              },
              loadingBuilder: (_, __) {
                return const LoadingIndicator();
              },
              errorBuilder: (_, __, ___) => const PlaceListErrorPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}
