import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/domain/model/onboarding_item.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';
import 'package:places/ui/widget/common/custom_text_button.dart';
import 'package:places/ui/widget/onboarding/onboarding_indicator_line.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingItem> _onboardingItems = [
    const OnboardingItem(
      title: AppStrings.tutorial1Title,
      subtitle: AppStrings.tutorial1Subtitle,
      iconPath: AppAssets.tutorial1Icon,
    ),
    const OnboardingItem(
      title: AppStrings.tutorial2Title,
      subtitle: AppStrings.tutorial2Subtitle,
      iconPath: AppAssets.tutorial2Icon,
    ),
    const OnboardingItem(
      title: AppStrings.tutorial3Title,
      subtitle: AppStrings.tutorial3Subtitle,
      iconPath: AppAssets.tutorial3Icon,
    ),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.defaultPadding),
            child: CustomTextButton(
              label: AppStrings.skip,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: _onboardingItems.length,
              onPageChanged: (pageNumber) => setState(() {
                _currentPage = pageNumber;
              }),
              itemBuilder: (context, index) {
                final onboardingItem = _onboardingItems[index];

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          onboardingItem.iconPath,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(
                          height: AppConstants.onboardingIconBottomMargin,
                        ),
                        Text(
                          onboardingItem.title,
                          textAlign: TextAlign.center,
                          style: AppTypography.titleTextStyle.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPaddingX0_5),
                        Text(
                          onboardingItem.subtitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.smallTextStyle.copyWith(
                            color: colorScheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: index == _onboardingItems.length - 1,
                      child: Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.defaultPaddingX0_5,
                              horizontal: AppConstants.defaultPadding,
                            ),
                            child: CustomElevatedButton(
                              label: AppStrings.startButtonTitle,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: AppConstants.indicatorStartIndent,
              left: 0,
              right: 0,
              child: OnboardingIndicatorLine(
                currentPage: _currentPage,
                numberOfSegments: _onboardingItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
