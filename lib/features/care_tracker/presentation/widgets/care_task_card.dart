import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_typography.dart';
import '../../domain/entities/care_task_entity.dart';

class CareTaskCard extends StatelessWidget {
  final CareTaskEntity task;
  final VoidCallback? onToggle;

  const CareTaskCard({super.key, required this.task, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textDark,
              ),
            ),
          ),
          Icon(
            _getIconForType(task.type),
            color: AppColors.primaryBright,
            size: 20,
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(CareTaskType type) {
    switch (type) {
      case CareTaskType.feeding:
        return Icons.pets;
      case CareTaskType.walking:
        return Icons.directions_walk;
      case CareTaskType.grooming:
        return Icons.cleaning_services;
      case CareTaskType.medication:
        return Icons.medical_services;
      case CareTaskType.training:
        return Icons.psychology;
      case CareTaskType.other:
        return Icons.more_horiz;
    }
  }
}
