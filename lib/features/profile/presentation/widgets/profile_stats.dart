import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../domain/user_entity.dart';

class ProfileStats extends StatelessWidget {
  final UserEntity user;

  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: 'Active Pets',
            value: user.petCount.toString(),
            color: AppColors.success,
          ),
          _StatItem(label: 'Visits', value: '12', color: AppColors.info),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.pets, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
      ],
    );
  }
}
