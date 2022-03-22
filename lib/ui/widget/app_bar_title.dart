import 'package:flutter/material.dart';
import 'package:places/constants.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: appBarTitleTextStyle,
        children: [
          TextSpan(
            text: 'С',
            style: appBarTitleTextStyle.copyWith(
              color: appBarTitleFirstLetterOneColor,
            ),
          ),
          const TextSpan(
            text: 'писок\n',
          ),
          TextSpan(
            text: 'и',
            style: appBarTitleTextStyle.copyWith(
              color: appBarTitleFirstLetterTwoColor,
            ),
          ),
          const TextSpan(
            text: 'нтересных мест',
          ),
        ],
      ),
    );
  }
}
