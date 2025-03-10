import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/utlis/appbar_title.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.textPrimary, width: 1.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => _onTap(context, index),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: Sizes.size36,
          items: [
            BottomNavigationBarItem(
              icon:
                  navigationShell.currentIndex == 0
                      ? const Icon(Icons.home)
                      : const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:
                  navigationShell.currentIndex == 1
                      ? const Icon(Icons.edit)
                      : const Icon(Icons.edit_outlined),
              label: 'Write',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(index);
  }
}
