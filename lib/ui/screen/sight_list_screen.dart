import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: AppConstants.toolbarHeight,
        title: const Padding(
          padding: EdgeInsets.only(top: AppConstants.appbarTopPadding),
          child: Text(
            AppStrings.appBarTitle,
            style: AppTypography.appBarTitleTextStyle,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: AppConstants.defaultPaddingX0_5),
        child: SingleChildScrollView(
          child: Column(
            children: mocks
                .map(
                  (sight) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding,
                      vertical: AppConstants.defaultPaddingX0_5,
                    ),
                    child: SightCard(sight: sight),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
