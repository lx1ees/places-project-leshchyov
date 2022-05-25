import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_widget_model.dart';
import 'package:places/ui/widget/common/custom_elevated_button.dart';
import 'package:places/ui/widget/common/custom_text_button.dart';
import 'package:places/ui/widget/onboarding/onboarding_indicator_line.dart';
import 'package:places/ui/widget/onboarding/onboarding_logo.dart';

class OnboardingScreen extends ElementaryWidget<IOnboardingScreenWidgetModel> {
  static const String routeName = '/onboarding';

  const OnboardingScreen({
    required WidgetModelFactory widgetModelFactory,
    Key? key,
  }) : super(widgetModelFactory, key: key);

  @override
  Widget build(IOnboardingScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.defaultPadding),
            child: CustomTextButton(
              label: AppStrings.skip,
              foregroundColor: wm.colorScheme.secondary,
              onPressed: wm.onClose,
            ),
          ),
        ],
        backgroundColor: wm.theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: wm.onboardingItems.length,
              onPageChanged: wm.onPageChanged,
              itemBuilder: (context, index) {
                final onboardingItem = wm.onboardingItems[index];

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OnboardingLogo(
                          onboardingItem: onboardingItem,
                          colorScheme: wm.colorScheme,
                        ),
                        const SizedBox(
                          height: AppConstants.onboardingIconBottomMargin,
                        ),
                        Text(
                          onboardingItem.title,
                          textAlign: TextAlign.center,
                          style: AppTypography.titleTextStyle.copyWith(
                            color: wm.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: AppConstants.defaultPaddingX0_5),
                        Text(
                          onboardingItem.subtitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.smallTextStyle.copyWith(
                            color: wm.colorScheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: index == wm.onboardingItems.length - 1,
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
                              onPressed: wm.onClose,
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
              child: StateNotifierBuilder<int>(
                listenableState: wm.currentPageState,
                builder: (_, currentPage) {
                  if (currentPage == null) return const SizedBox.shrink();

                  return OnboardingIndicatorLine(
                    currentPage: currentPage,
                    numberOfSegments: wm.onboardingItems.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
