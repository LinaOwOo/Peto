import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/complete_care_task_use_case.dart';
import '../../domain/use_cases/get_care_tasks_use_case.dart';
import 'care_tracker_state.dart';

class CareTrackerNotifier extends StateNotifier<CareTrackerState> {
  final GetCareTasksUseCase getCareTasksUseCase;
  final CompleteCareTaskUseCase completeCareTaskUseCase;

  CareTrackerNotifier({
    required this.getCareTasksUseCase,
    required this.completeCareTaskUseCase,
  }) : super(CareTrackerState.initial()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = state.copyWith(status: CareTrackerStatus.loading);
    try {
      final tasks = await getCareTasksUseCase();
      state = state.copyWith(status: CareTrackerStatus.success, tasks: tasks);
    } catch (e) {
      state = state.copyWith(
        status: CareTrackerStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> completeTask(String taskId) async {
    try {
      final updatedTask = await completeCareTaskUseCase(taskId);
      final updatedTasks = state.tasks.map((task) {
        if (task.id == taskId) return updatedTask;
        return task;
      }).toList();
      state = state.copyWith(tasks: updatedTasks);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
