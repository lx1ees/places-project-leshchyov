import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/common/custom_divider.dart';
import 'package:provider/provider.dart';

/// Экран с настройками
class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsInteractor = context.read<SettingsInteractor>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.settingsScreenAppBarTitle,
            style: AppTypography.subtitleTextStyle.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: AppConstants.defaultPaddingX1_5),
          ListTile(
            title: const Text(AppStrings.darkThemeOption),
            trailing: CupertinoSwitch(
              value: settingsInteractor.themeModeHolder.currentThemeMode ==
                  ThemeMode.dark,
              onChanged: (value) {
                settingsInteractor.themeModeHolder.setThemeMode(isDark: value);
              },
            ),
          ),
          const CustomDivider(hasIndent: true),
          ListTile(
            title: const Text(AppStrings.watchTutorialOption),
            trailing: Padding(
              padding: const EdgeInsets.all(AppConstants.infoIconPadding),
              child: SvgPicture.asset(
                AppAssets.infoIcon,
                color: colorScheme.secondary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            onTap: () => _openOnboardingScreen(context),
          ),
          const CustomDivider(hasIndent: true),
        ],
      ),
    );
  }

  /// Метод открытия окна  с онбордингом
  Future<void> _openOnboardingScreen(
    BuildContext context,
  ) async {
    await AppRoutes.navigateToOnboardingScreen(context: context);
    setState(() {});
  }
}
