// lib/features/care_tracker/presentation/widgets/care_task_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_typography.dart';
import '../../domain/entities/care_task_entity.dart';
import '../providers/care_tracker_provider.dart';
import 'care_timer_indicator.dart';

class CareTaskCard extends ConsumerWidget {
  final CareTaskEntity task;

  const CareTaskCard({super.key, required this.task});

  Color _getCardColor() {
    switch (task.type) {
      case CareTaskType.feeding:
        return AppColors.success;
      case CareTaskType.water:
        return AppColors.info;
      case CareTaskType.litter:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardColor = _getCardColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Image.asset(
                    task.iconPath,
                    height: 80,
                    width: 80,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.pets, size: 80),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CareTimerIndicator(
                    isOverdue: task.isOverdue,
                    timeUntilDue: task.timeUntilDue,
                    lastCompleted: task.lastCompleted,
                  ),
                  const SizedBox(height: 12),
                  ...task.metrics.map((metric) => _buildMetricItem(metric)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _buildCheckBox(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(dynamic metric) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(metric.label, style: AppTypography.caption),
          Text(
            metric.value.isEmpty ? '—' : metric.value,
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBox(WidgetRef ref) {
    final isCompleted = task.action == CareAction.completed;

    return GestureDetector(
      onTap: () =>
          ref.read(careTrackerNotifierProvider.notifier).completeTask(task.id),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted ? AppColors.primaryBright : AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: isCompleted ? AppColors.primaryBright : AppColors.primary,
            width: 2,
          ),
        ),
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }
}
