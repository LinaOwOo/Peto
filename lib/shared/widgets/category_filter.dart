import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';
import '../../core/constants/app_icons.dart';
import 'app_icon.dart';

enum PetCategory { all, dog, cat, turtle, rabbit }

class CategoryFilter extends StatelessWidget {
  final PetCategory selectedCategory;
  final Function(PetCategory) onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final categories = [
            PetCategory.all,
            PetCategory.dog,
            PetCategory.cat,
            PetCategory.turtle,
            PetCategory.rabbit,
          ];

          final category = categories[index];
          final isSelected = selectedCategory == category;
          final isAll = category == PetCategory.all;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              width: isAll ? 70 : 56,
              decoration: BoxDecoration(
                color: isAll && isSelected
                    ? AppColors.primaryBright
                    : isSelected
                    ? AppColors.primary
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _buildIconForCategory(category, isSelected),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconForCategory(PetCategory category, bool isSelected) {
    if (category == PetCategory.all) {
      return Center(
        child: Text(
          'All',
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryBright,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      );
    }

    final iconMap = {
      PetCategory.dog: isSelected ? AppIcons.whiteDog : AppIcons.blueDog,
      PetCategory.cat: isSelected ? AppIcons.whiteCat : AppIcons.blueCat,
      PetCategory.turtle: isSelected
          ? AppIcons.whiteTurtle
          : AppIcons.blueTurtle,
      PetCategory.rabbit: isSelected
          ? AppIcons.whiteRabbit
          : AppIcons.blueRabbit,
    };

    return Center(
      child: AppIcon(
        iconPath: iconMap[category]!,
        size: 28,
        color: isSelected ? Colors.white : null,
      ),
    );
  }
}
