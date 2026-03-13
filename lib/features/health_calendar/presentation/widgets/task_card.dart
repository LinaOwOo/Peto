import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_typography.dart';
import '../../domain/entities/calendar_event_entity.dart';

Color getColorForEventType(EventType type) {
  switch (type) {
    case EventType.vet:
      return AppColors.error;
    case EventType.medication:
      return AppColors.warning;
    case EventType.grooming:
      return AppColors.info;
    case EventType.training:
      return AppColors.success;
    case EventType.other:
      return AppColors.secondary;
  }
}

class TaskCard extends StatelessWidget {
  final CalendarEventEntity event;
  final VoidCallback? onToggle;

  const TaskCard({super.key, required this.event, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: getColorForEventType(event.type).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: event.isCompleted
                      ? AppColors.success
                      : AppColors.primary,
                  width: 2,
                ),
                color: event.isCompleted
                    ? AppColors.success
                    : Colors.transparent,
              ),
              child: event.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: AppTypography.bodySmall.copyWith(
                    decoration: event.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (event.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 4),
                  Text(
                    event.description!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            _getIconForType(event.type),
            color: getColorForEventType(event.type),
            size: 18,
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(EventType type) {
    switch (type) {
      case EventType.vet:
        return Icons.local_hospital;
      case EventType.medication:
        return Icons.medication;
      case EventType.grooming:
        return Icons.cleaning_services;
      case EventType.training:
        return Icons.psychology;
      case EventType.other:
        return Icons.more_horiz;
    }
  }
}
