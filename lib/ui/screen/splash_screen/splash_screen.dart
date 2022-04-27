import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_colors.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/res/routes.dart';

/// Сплеш-экран
class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SvgPicture.asset(
          AppAssets.splashLogo,
          width: AppConstants.splashLogoSize,
          height: AppConstants.splashLogoSize,
        ),
      ),
    );
  }

  /// Метод для навигации на следующий экран с логикой: ожидаем инициализацию,
  /// ожидаем минимальное время показа сплеша, не позволяем закрыть сплеш до тех пор,
  /// пока не будут выполнены все условия.
  Future<void> _navigateToNext() async {
    final isInitialized =
        Future.delayed(const Duration(seconds: 2), () => true);
    final isMinSplashTimeOver = Future.delayed(
      const Duration(seconds: AppConstants.minSplashTimeInSec),
      () => true,
    );

    try {
      final isNavigationAllowed =
          !(await Future.wait([isInitialized, isMinSplashTimeOver]))
              .contains(false);

      if (isNavigationAllowed) {
        await AppRoutes.navigateToHomeScreen(context: context);
      }
    } on Exception catch (_) {
      /// Обработка ошибки выполнения Future
    }
  }
}
