import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/ui/screen/settings_screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/widgets/custom_divider.dart';

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
    SettingsScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomDivider(),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onNavigationItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.listIcon,
                  color: bottomNavigationBarTheme.unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.listFullIcon,
                  color: bottomNavigationBarTheme.selectedItemColor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.heartIcon,
                  color: bottomNavigationBarTheme.unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.heartFullIcon,
                  color: bottomNavigationBarTheme.selectedItemColor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.settingsIcon,
                  color: bottomNavigationBarTheme.unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.settingsFullIcon,
                  color: bottomNavigationBarTheme.selectedItemColor,
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
