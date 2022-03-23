import 'package:flutter/material.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

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
          padding: EdgeInsets.only(top: 40),
          child: Text(
            AppStrings.appBarTitle,
            style: AppTypography.appBarTitleTextStyle,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: mocks
                .map(
                  (sight) => Padding(
                    /// Указал внутренние отступы родителю (Column'у), так как посчитал, что
                    /// внешние отступы самой карточке ни к чему, вдруг мы захотим
                    /// переиспользовать карточку с другими отступами. Поправьте,
                    /// если неправильно мыслю.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
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
