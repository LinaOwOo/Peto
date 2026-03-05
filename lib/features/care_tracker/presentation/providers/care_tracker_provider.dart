import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peto/features/care_tracker/domain/use_cases/care_tracker_repository.dart';
import '../../domain/use_cases/complete_care_task_use_case.dart';
import '../../domain/use_cases/get_care_tasks_use_case.dart';
import '../state/care_tracker_state.dart';
import '../state/care_tracker_notifier.dart';

final careTrackerRepositoryProvider = Provider<CareTrackerRepository>((ref) {
  throw UnimplementedError('Repository must be provided at app startup');
});

final getCareTasksUseCaseProvider = Provider<GetCareTasksUseCase>((ref) {
  return GetCareTasksUseCase(ref.watch(careTrackerRepositoryProvider));
});

final completeCareTaskUseCaseProvider = Provider<CompleteCareTaskUseCase>((
  ref,
) {
  return CompleteCareTaskUseCase(ref.watch(careTrackerRepositoryProvider));
});

final careTrackerNotifierProvider =
    StateNotifierProvider<CareTrackerNotifier, CareTrackerState>((ref) {
      return CareTrackerNotifier(
        getCareTasksUseCase: ref.watch(getCareTasksUseCaseProvider),
        completeCareTaskUseCase: ref.watch(completeCareTaskUseCaseProvider),
      );
    });
