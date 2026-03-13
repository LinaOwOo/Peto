import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_provider.dart';
import 'task_card.dart';
import '../../../../core/themes/app_colors.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    final selectedDate = state.selectedDate ?? DateTime.now();
    final events = state.events
        .where((e) => DateUtils.isSameDay(e.date, selectedDate))
        .toList();

    final isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
    final title = isToday
        ? 'Сегодня'
        : DateFormat('d MMMM').format(selectedDate);
    final headerColor = isToday ? AppColors.primaryBright : AppColors.textDark;

    return Container(
      padding: const EdgeInsets.all(16),
      // Добавляем отступ снизу для навигационной панели
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textGrey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: headerColor,
            ),
          ),
          const SizedBox(height: 16),
          if (events.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Нет запланированных дел',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                ),
              ),
            )
          else
            ...events.map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TaskCard(
                  event: event,
                  onToggle: () => notifier.toggleCompletion(event.id),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddEventDialog(context, ref, selectedDate),
              icon: const Icon(Icons.add),
              label: const Text('Добавить план'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBright,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context, WidgetRef ref, DateTime date) {
    // Реализация диалога добавления события
  }
}
