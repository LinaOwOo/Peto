// lib/features/care_tracker/domain/use_cases/get_care_tasks_use_case.dart
import 'package:peto/features/care_tracker/domain/use_cases/care_tracker_repository.dart';
import '../entities/care_task_entity.dart';


class GetCareTasksUseCase {
  final CareTrackerRepository repository;

  const GetCareTasksUseCase(this.repository);

  Future<List<CareTaskEntity>> call() async {
    return await repository.getCareTasks(); // Было: await.repository (ошибка)
  }
}