import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/task_list.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../core/providers/navigation_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CalendarGrid(),
              ),
            ),
            const Expanded(flex: 5, child: TaskList()),
            const SizedBox(height: 20),
            BottomNavBar(
              selectedIndex: navIndex,
              onItemSelected: (index) => context.go(
                ['/home', '/care-tracker', '/calendar', '/profile'][index],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
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
            'Calendar',
            style: TextStyle(
              color: AppColors.primaryBright,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
