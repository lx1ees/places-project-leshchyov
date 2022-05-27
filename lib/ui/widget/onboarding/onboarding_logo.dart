import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/domain/model/onboarding_item.dart';

/// Виджет иконки-логотипа на экране онбординга
class OnboardingLogo extends StatefulWidget {
  final OnboardingItem onboardingItem;
  final ColorScheme colorScheme;

  const OnboardingLogo({
    Key? key,
    required this.onboardingItem,
    required this.colorScheme,
  }) : super(key: key);

  @override
  State<OnboardingLogo> createState() => _OnboardingLogoState();
}

class _OnboardingLogoState extends State<OnboardingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppConstants.onboardingAnimationDurationInMillis,
      ),
    );
    _animationScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 200),
      _animationController.forward,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ScaleTransition(
          scale: _animationScale,
          child: child,
        );
      },
      child: SvgPicture.asset(
        widget.onboardingItem.iconPath,
        color: widget.colorScheme.primary,
      ),
    );
  }
}
