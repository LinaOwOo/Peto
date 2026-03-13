import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/constants/app_icons.dart';
import 'app_icon.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      AppIcons.home,
      AppIcons.target,
      AppIcons.calendar,
      AppIcons.profile,
    ];

    final navLabels = ['Home', 'Care Tracker', 'Calendar', 'Profile'];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(navItems.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: Semantics(
              label: navLabels[index],
              selected: isSelected,
              button: true,
              child: Container(
                key: ValueKey('nav_item_$index'),
                padding: const EdgeInsets.all(8),
                child: AppIcon(
                  iconPath: navItems[index],
                  size: 28,
                  color: isSelected
                      ? AppColors.primaryBright
                      : AppColors.primary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
