import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_provider.dart';
import 'paw_marker.dart';
import '../../../../core/themes/app_colors.dart';

class CalendarGrid extends ConsumerWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    final firstDayOfMonth = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month + 1,
      0,
    );
    final daysInMonth = lastDayOfMonth.day;
    final startingWeekday = firstDayOfMonth.weekday;

    return Column(
      children: [
        _buildHeader(context, notifier, state),
        const SizedBox(height: 16),
        _buildWeekdaysHeader(),
        const SizedBox(height: 8),
        _buildDaysGrid(daysInMonth, startingWeekday, state, notifier),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    CalendarNotifier notifier,
    CalendarState state,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            notifier.changeMonth(
              DateTime(state.focusedMonth.year, state.focusedMonth.month - 1),
            );
          },
        ),
        Text(
          DateFormat('MMMM yyyy').format(state.focusedMonth),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBright,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            notifier.changeMonth(
              DateTime(state.focusedMonth.year, state.focusedMonth.month + 1),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdaysHeader() {
    const weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map(
            (day) => SizedBox(
              width: 40,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid(
    int daysInMonth,
    int startingWeekday,
    CalendarState state,
    CalendarNotifier notifier,
  ) {
    List<Widget> cells = [];

    for (var i = 1; i < startingWeekday; i++) {
      cells.add(const SizedBox(width: 40, height: 50));
    }

    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(
        state.focusedMonth.year,
        state.focusedMonth.month,
        day,
      );
      final isSelected =
          state.selectedDate != null &&
          DateUtils.isSameDay(state.selectedDate, date);

      final eventsOnDay = state.events
          .where((e) => DateUtils.isSameDay(e.date, date))
          .toList();
      final hasEvents = eventsOnDay.isNotEmpty;

      cells.add(
        GestureDetector(
          onTap: () => notifier.selectDate(date),
          child: SizedBox(
            width: 40,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textDark,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                if (hasEvents) ...[
                  const SizedBox(height: 4),
                  PawMarker(type: eventsOnDay.first.type),
                ],
              ],
            ),
          ),
        ),
      );
    }

    return Wrap(spacing: 4, runSpacing: 4, children: cells);
  }
}
