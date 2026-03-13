import '../entities/care_task_entity.dart';

abstract class CareTrackerRepository {
  Future<List<CareTaskEntity>> getTasks();
  Future<void> completeTask(String taskId);
  Future<void> addTask(CareTaskEntity task);
  Future<void> updateTask(CareTaskEntity task);
}
