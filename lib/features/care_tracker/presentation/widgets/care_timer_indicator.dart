// lib/features/care_tracker/presentation/widgets/care_timer_indicator.dart
import 'package:flutter/material.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_typography.dart';

class CareTimerIndicator extends StatelessWidget {
  final bool isOverdue;
  final Duration? timeUntilDue;
  final DateTime? lastCompleted;

  const CareTimerIndicator({
    super.key,
    required this.isOverdue,
    this.timeUntilDue,
    this.lastCompleted,
  });

  String _formatDuration(Duration? duration) {
    if (duration == null) return '';
    if (duration.inHours > 0) {
      return '${duration.inHours}ч ${duration.inMinutes.remainder(60)}м';
    }
    return '${duration.inMinutes}м';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOverdue ? AppColors.error : AppColors.success,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOverdue ? Icons.warning_rounded : Icons.access_time_rounded,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            isOverdue
                ? 'Просрочено на ${_formatDuration(timeUntilDue?.abs())}'
                : 'Через ${_formatDuration(timeUntilDue)}',
            style: AppTypography.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
