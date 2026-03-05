import 'package:flutter/material.dart';
import '../../domain/entities/calendar_event.dart';
import 'paw_marker.dart';
import '../../../../core/themes/app_colors.dart';

class TaskCard extends StatelessWidget {
  final CalendarEvent event;
  final VoidCallback onToggle;

  const TaskCard({super.key, required this.event, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          PawMarker(type: event.type),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              event.title,
              style: TextStyle(
                decoration: event.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: event.isCompleted
                    ? AppColors.textGrey
                    : AppColors.textDark,
              ),
            ),
          ),
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: event.isCompleted,
              onChanged: (_) => onToggle(),
              activeColor: AppColors.primaryBright,
            ),
          ),
        ],
      ),
    );
  }
}
