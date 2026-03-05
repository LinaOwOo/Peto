import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/constants/app_icons.dart';
import 'app_icon.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': AppIcons.injection, 'color': AppColors.success},
      {'icon': AppIcons.shower, 'color': AppColors.info},
      {'icon': AppIcons.tooth, 'color': AppColors.secondary},
      {'icon': AppIcons.plus, 'color': AppColors.warning},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: action['color'] as Color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: AppIcon(
              iconPath: action['icon'] as String,
              size: 28,
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
