import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/task_list.dart';
import '../../../../core/themes/app_colors.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBright),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pets, color: AppColors.primaryBright),
            ),
            const SizedBox(width: 8),
            const Text(
              'Name',
              style: TextStyle(
                color: AppColors.primaryBright,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CalendarGrid(),
            ),
          ),
          Expanded(flex: 5, child: TaskList()),
        ],
      ),
    );
  }
}
