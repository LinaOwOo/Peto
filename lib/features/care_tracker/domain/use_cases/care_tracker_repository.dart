import '../entities/care_task_entity.dart';

abstract class CareTrackerRepository {
  Future<List<CareTaskEntity>> getCareTasks();
  Future<CareTaskEntity> getTaskById(String id);
  Future<CareTaskEntity> completeTask(String taskId);
  Future<void> updateMetric(String taskId, String metricId, bool isCompleted);
  Future<void> scheduleReminder(String taskId, DateTime scheduledTime);
}
