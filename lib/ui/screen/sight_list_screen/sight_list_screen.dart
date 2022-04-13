import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/constants/app_typography.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/custom_app_bar.dart';
import 'package:places/ui/screen/sight_card/sight_view_card.dart';
import 'package:places/ui/screen/sight_list.dart';
import 'package:places/ui/widgets/gradient_extended_fab.dart';

/// Виджет, описывающий экран списка интересных мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          AppStrings.appBarTitle,
          style: AppTypography.largeTitleTextStyle.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientExtendedFab(
        icon: SvgPicture.asset(AppAssets.plusIcon),
        label: AppStrings.newPlaceTitle.toUpperCase(),
        startColor: colorScheme.surfaceVariant,
        endColor: colorScheme.secondary,
        onPressed: () {
          _openAddNewPlaceScreen(context);
        },
      ),
      body: SightList(
        sightCards: sightsMock
            .map((sight) => SightViewCard(
                  sight: sight,
                  onFavoritePressed: () {},
                  onCardTapped: () {},
                ))
            .toList(),
      ),
    );
  }

  /// Метод открытия окна добавления нового места
  Future<void> _openAddNewPlaceScreen(
      BuildContext context,
      ) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSightScreen(),
      ),
    );

    setState(() {});
  }
}
