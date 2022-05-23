import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/settings_screen/settings_screen_widget_model.dart';
import 'package:places/ui/widget/common/custom_divider.dart';

/// Экран с настройками
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  static const String routeName = '/settings';

  const SettingsScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(
          widgetModelFactory,
          key: key,
        );

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            AppStrings.settingsScreenAppBarTitle,
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
          const SizedBox(height: AppConstants.defaultPaddingX1_5),
          ListTile(
            title: const Text(AppStrings.darkThemeOption),
            trailing: CupertinoSwitch(
              value: wm.isDarkMode,
              onChanged: wm.onThemeChanged,
            ),
          ),
          const CustomDivider(hasIndent: true),
          ListTile(
            title: const Text(AppStrings.watchTutorialOption),
            trailing: Padding(
              padding: const EdgeInsets.all(AppConstants.infoIconPadding),
              child: SvgPicture.asset(
                AppAssets.infoIcon,
                color: wm.colorScheme.secondary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            onTap: wm.onShowOnboardingPressed,
          ),
          const CustomDivider(hasIndent: true),
        ],
      ),
    );
  }
}
