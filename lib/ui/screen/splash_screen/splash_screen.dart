import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/splash_screen/splash_screen_widget_model.dart';

/// Сплеш-экран
class SplashScreen extends ElementaryWidget<ISplashScreenWidgetModel> {
  static const String routeName = '/';

  const SplashScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(ISplashScreenWidgetModel wm) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.greenColor,
              AppColors.yellowColor,
            ],
            transform: GradientRotation(3),
          ),
        ),
        child: AnimatedBuilder(
          animation: wm.controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: wm.animationValue,
              child: child,
            );
          },
          child: SvgPicture.asset(
            AppAssets.splashLogo,
            width: AppConstants.splashLogoSize,
            height: AppConstants.splashLogoSize,
          ),
        ),
      ),
    );
  }
}
