import 'package:flutter/material.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/widget/map/map_action_button.dart';

/// Виджет кнопок действий на карте
class MapActions extends StatelessWidget {
  final VoidCallback onRefreshPressed;
  final VoidCallback onGeoPressed;

  const MapActions({
    required this.onRefreshPressed,
    required this.onGeoPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppConstants.defaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MapActionButton(
            iconPath: AppAssets.refreshIcon,
            onPressed: onRefreshPressed,
          ),
          MapActionButton(
            iconPath: AppAssets.geolocationIcon,
            onPressed: onGeoPressed,
          ),
        ],
      ),
    );
  }
}
