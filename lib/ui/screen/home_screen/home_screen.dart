import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_constants.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';

/// Стартовый экран с навигацией
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _screens = <Widget>[
    SightListScreen(),
    VisitingScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            thickness: AppConstants.defaultDividerThickness,
            height: 0,
          ),
          BottomNavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            currentIndex: _selectedIndex,
            onTap: _onNavigationItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.listIconAssetPath,
                  color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.listFullIconAssetPath,
                  color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.heartIconAssetPath,
                  color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.heartFullIconAssetPath,
                  color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                ),
                label: '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
