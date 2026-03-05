import 'package:flutter/material.dart';
import '../../core/themes/app_colors.dart';

class MiniCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime currentDate;

  MiniCalendar({super.key, DateTime? selectedDate, DateTime? currentDate})
    : selectedDate = selectedDate ?? DateTime.now(),
      currentDate = currentDate ?? DateTime.now();

  List<DateTime> _getWeekDays() {
    final now = currentDate;
    final weekday = now.weekday;
    final monday = now.subtract(Duration(days: weekday - 1));

    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays();
    final dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final dayDate = weekDays[index];
          final dayName = dayNames[index];
          final dayNumber = dayDate.day;
          final isSelected = _isSameDay(dayDate, selectedDate);
          final isToday = _isSameDay(dayDate, currentDate);

          return Column(
            children: [
              Text(
                dayName,
                style: TextStyle(
                  color: AppColors.textDark.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$dayNumber',
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryBright
                      : isToday
                      ? AppColors.textDark
                      : AppColors.textDark.withValues(alpha: 0.6),
                  fontSize: 18,
                  fontWeight: isSelected || isToday
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
