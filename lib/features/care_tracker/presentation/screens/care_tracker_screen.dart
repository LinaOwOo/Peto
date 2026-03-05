// lib/features/care_tracker/presentation/screens/care_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_typography.dart';
import '../providers/care_tracker_provider.dart';
import '../state/care_tracker_state.dart';
import '../widgets/care_task_card.dart';

class CareTrackerScreen extends ConsumerWidget {
  const CareTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(careTrackerNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryBright,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Трекер ухода', style: AppTypography.heading),
        centerTitle: true,
      ),
      body: state.status == CareTrackerStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(careTrackerNotifierProvider.notifier).loadTasks(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  return CareTaskCard(task: state.tasks[index]);
                },
              ),
            ),
    );
  }
}
