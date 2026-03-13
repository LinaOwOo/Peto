import 'package:peto/features/care_tracker/domain/use_cases/care_tracker_repository.dart';

import '../entities/care_task_entity.dart';

class CompleteCareTaskUseCase {
  final CareTrackerRepository repository;

  const CompleteCareTaskUseCase(this.repository);

  Future<CareTaskEntity> call(String taskId) async {
    return await repository.completeTask(taskId);
  }
}