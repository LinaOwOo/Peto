import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_typography.dart';
import '../../domain/entities/calendar_event_entity.dart';
import '../providers/calendar_provider.dart';
import 'paw_marker.dart';

class CalendarGrid extends ConsumerWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    final focusedMonth = state.focusedMonth ?? DateTime.now();
    final year = focusedMonth.year;
    final month = focusedMonth.month;
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday;

    final weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    final today = DateTime.now();

    return Column(
      children: [
        _buildHeader(context, ref, focusedMonth),
        const SizedBox(height: 16),
        _buildWeekDays(weekDays),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayNumber = index - firstWeekday + 1;
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }

              final date = DateTime(year, month, dayNumber);
              final isToday = DateUtils.isSameDay(date, today);
              final eventsForDay = state.events
                  .where((e) => DateUtils.isSameDay(e.date, date))
                  .toList();

              return GestureDetector(
                onTap: () => notifier.selectDate(date),
                child: _buildDayCell(
                  dayNumber: dayNumber,
                  isToday: isToday,
                  events: eventsForDay,
                  isSelected:
                      state.selectedDate != null &&
                      DateUtils.isSameDay(date, state.selectedDate!),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    DateTime focusedMonth,
  ) {
    final notifier = ref.read(calendarProvider.notifier);
    final monthName = DateFormat('MMMM yyyy', 'ru_RU').format(focusedMonth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.primaryBright),
          onPressed: () {
            final prevMonth = DateTime(
              focusedMonth.year,
              focusedMonth.month - 1,
              1,
            );
            notifier.changeMonth(prevMonth);
          },
        ),
        Text(
          monthName,
          style: AppTypography.heading.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: AppColors.primaryBright),
          onPressed: () {
            final nextMonth = DateTime(
              focusedMonth.year,
              focusedMonth.month + 1,
              1,
            );
            notifier.changeMonth(nextMonth);
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays(List<String> weekDays) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays.map((day) {
        return Text(
          day,
          style: AppTypography.caption.copyWith(
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDayCell({
    required int dayNumber,
    required bool isToday,
    required List<CalendarEventEntity> events,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.3)
            : isToday
            ? AppColors.primaryBright.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$dayNumber',
            style: AppTypography.bodySmall.copyWith(
              color: isToday || isSelected
                  ? AppColors.primaryBright
                  : AppColors.textDark,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (events.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: events.take(3).map((event) {
                return PawMarker(type: event.type, size: 6);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
