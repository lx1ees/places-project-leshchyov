import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/constants/app_assets.dart';
import 'package:places/ui/screen/res/routes.dart';
import 'package:places/ui/widget/common/custom_divider.dart';

/// Стартовый экран с навигацией
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarTheme = Theme.of(context).bottomNavigationBarTheme;

    return Scaffold(
      body: Navigator(
        key: AppRoutes.navigators[AppRoutes.bottomNavigatorKey],
        initialRoute: AppRoutes.bottomNavigationRoutes.keys.elementAt(0),
        onGenerateRoute: (settings) {
          final builder = AppRoutes.bottomNavigationRoutes[settings.name];

          return PageRouteBuilder<void>(
            pageBuilder: (context, __, ___) {
              return builder != null
                  ? builder(context)
                  : const SizedBox.shrink();
            },
            transitionDuration: Duration.zero,
          );
        },
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
    if (_selectedIndex == index) return;
    final route = AppRoutes.bottomNavigationRoutes.keys.elementAt(index);
    final navigator = AppRoutes.navigators[AppRoutes.bottomNavigatorKey];
    AppRoutes.navigateTo(route, navigator);
    setState(() {
      _selectedIndex = index;
    });
  }
}
