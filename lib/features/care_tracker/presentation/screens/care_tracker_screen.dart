import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_typography.dart';
import '../../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../../core/providers/navigation_provider.dart';
import '../providers/care_tracker_provider.dart';
import '../state/care_tracker_state.dart';
import '../widgets/care_task_card.dart';

class CareTrackerScreen extends ConsumerWidget {
  const CareTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(careTrackerNotifierProvider);
    final navIndex = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            Expanded(
              child: state.status == CareTrackerStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => ref
                          .read(careTrackerNotifierProvider.notifier)
                          .refresh(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return CareTaskCard(
                            task: state.tasks[index],
                            onToggle: () => ref
                                .read(careTrackerNotifierProvider.notifier)
                                .completeTask(state.tasks[index].id),
                          );
                        },
                      ),
                    ),
            ),
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
          Text('Трекер ухода', style: AppTypography.heading),
        ],
      ),
    );
  }
}
