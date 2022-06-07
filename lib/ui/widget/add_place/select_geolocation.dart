import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/utils/dialog_utils.dart';
import 'package:places/utils/ui_utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Экран выбора геолокации при создании нового места
/// [selectedLocationPoint] - текущая выбранная геопозиция
class SelectGeolocationScreen extends StatefulWidget {
  static const String routeName = '/selectGeolocation';
  final LocationPoint? selectedLocationPoint;

  const SelectGeolocationScreen({
    this.selectedLocationPoint,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectGeolocationScreen> createState() =>
      _SelectGeolocationScreenState();
}

class _SelectGeolocationScreenState extends State<SelectGeolocationScreen> {
  /// Текущая выбранная геопозиция
  LocationPoint? selectedLocationPoint;

  /// Измененная геопозиция
  LocationPoint? newLocationPoint;

  YandexMapController? _mapController;

  PlacemarkMapObject? _selectedGeoPlacemark;

  @override
  void initState() {
    super.initState();
    selectedLocationPoint = widget.selectedLocationPoint;
    newLocationPoint = widget.selectedLocationPoint;

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateGeo());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(milliseconds: 200), _setSelectedGeo);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedLocationPlacemark = _selectedGeoPlacemark;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, selectedLocationPoint);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.geolocationTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
          leadingWidth: AppConstants.defaultAppBarButtonLeadingWidth,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context, selectedLocationPoint);
            },
            style: TextButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              primary: colorScheme.secondaryContainer,
              textStyle: AppTypography.textTextStyle,
            ),
            child: const Text(AppStrings.cancel),
            // child: const Text('vwvw'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, newLocationPoint);
              },
              style: TextButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize:
                    const Size(0, AppConstants.defaultTextButtonHeight),
                primary: Theme.of(context).colorScheme.secondary,
                textStyle: AppTypography.textTextStyle,
              ),
              child: const Text(AppStrings.confirm),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: AppConstants.defaultPaddingX1_5),
            child: YandexMap(
              nightModeEnabled: Theme.of(context).brightness == Brightness.dark,
              onMapCreated: _onMapCreated,
              onUserLocationAdded: _onUserLocationAdded,
              fastTapEnabled: true,
              mapObjects: selectedLocationPlacemark != null
                  ? [selectedLocationPlacemark]
                  : [],
              // fastTapEnabled: true,
              onMapTap: _onMapTap,
              onMapLongTap: _onMapTap,
              // fastTapEnabled: true,
            ),
          ),
        ),
      ),
    );
  }

  void _setSelectedGeo() {
    final selectedGeo = selectedLocationPoint;
    if (selectedGeo != null) {
      _onMapTap(
        Point(
          latitude: selectedGeo.lat,
          longitude: selectedGeo.lon,
        ),
      );
    }
  }

  void _onMapTap(Point point) {
    newLocationPoint = LocationPoint(
      lat: point.latitude,
      lon: point.longitude,
    );
    _moveCameraTo(newLocationPoint);
    setState(() {
      _selectedGeoPlacemark = PlacemarkMapObject(
        mapId: MapObjectId(point.toString()),
        point: point,
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              UiUtils.getValueByTheme<String>(
                context: context,
                defaultValue: AppAssets.placemarkSelectedIcon,
                darkValue: AppAssets.placemarkSelectedIconDark,
              ),
            ),
            scale: 0.75,
          ),
        ),
      );
    });
  }

  Future<UserLocationView>? _onUserLocationAdded(
    UserLocationView userLocationView,
  ) async {
    final customIconAssetName = UiUtils.getValueByTheme<String>(
      context: context,
      defaultValue: AppAssets.currentLocationIcon,
      darkValue: AppAssets.currentLocationIconDark,
    );

    return userLocationView.copyWith(
      pin: userLocationView.pin.copyWith(
        opacity: 1.0,
      ),
      arrow: userLocationView.arrow.copyWith(
        opacity: 1.0,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(customIconAssetName),
            scale: 2,
          ),
        ),
      ),
      accuracyCircle: userLocationView.accuracyCircle.copyWith(
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
      ),
    );
  }

  Future<void> _onMapCreated(YandexMapController mapController) async {
    _mapController = mapController;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    await mapController.setMapStyle(
      isDark ? AppConstants.mapDarkStyle : AppConstants.mapStyle,
    );

    await mapController.toggleUserLayer(visible: true, autoZoomEnabled: true);
  }

  Future<void> _updateGeo() async {
    try {
      final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(
          seconds: 5,
        ),
      );
      if (selectedLocationPoint == null) {
        await _moveCameraTo(
          LocationPoint(
            lat: location.latitude,
            lon: location.longitude,
          ),
        );
      }
    } on PermissionDeniedException catch (_) {
      if (!mounted) return;
      DialogUtils.showSnackBar(
        context: context,
        title: AppStrings.errorLocationPermissionDenied,
        actionTitle: AppStrings.allow,
        onPressedAction: _onRequestForLocationPermission,
      );
    }
  }

  Future<void> _onRequestForLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _updateGeo();
    }
  }

  Future<void> _moveCameraTo(LocationPoint? point) async {
    if (point != null) {
      await _mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: point.lat,
              longitude: point.lon,
            ),
            // zoom: 13,
          ),
        ),
        animation: const MapAnimation(
          // type: MapAnimationType.smooth,
          duration: 0.3,
        ),
      );
    }
  }
}
