import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/theme_mode_holder.dart';
import 'package:places/ui/widgets/custom_divider.dart';

/// Экран с настройками
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
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
              value: themeModeHolder.currentThemeMode == ThemeMode.dark,
              onChanged: (value) {
                themeModeHolder.setThemeMode(isDark: value);
              },
            ),
          ),
          const CustomDivider(hasIndent: true),
          ListTile(
            title: const Text(AppStrings.watchTutorialOption),
            trailing: Padding(
              padding: const EdgeInsets.all(AppConstants.infoIconPadding),
              child: SvgPicture.asset(
                AppAssets.infoIconAssetPath,
                color: colorScheme.secondary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
          ),
          const CustomDivider(hasIndent: true),
        ],
      ),
    );
  }
}
