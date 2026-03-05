// lib/features/care_tracker/data/repositories/care_tracker_repository_impl.dart
import '../../domain/entities/care_task_entity.dart';
import '../../domain/repositories/care_tracker_repository.dart';
import '../models/care_task_model.dart';

class CareTrackerRepositoryImpl implements CareTrackerRepository {
  final List<CareTaskModel> _localCache = [];

  @override
  Future<List<CareTaskEntity>> getCareTasks() async {
    if (_localCache.isEmpty) {
      await _initializeDefaultTasks();
    }
    // Конвертируем модели в сущности на границе слоя
    return _localCache.map((model) => model as CareTaskEntity).toList();
  }

  @override
  Future<CareTaskEntity> getTaskById(String id) async {
    final task = _localCache.firstWhere((task) => task.id == id);
    return task;
  }

  @override
  Future<CareTaskEntity> completeTask(String taskId) async {
    final index = _localCache.indexWhere((task) => task.id == taskId);
    if (index == -1) throw Exception('Task not found');

    final oldTask = _localCache[index];
    // Теперь copyWith возвращает CareTaskModel — ошибка устранена
    final updatedTask = oldTask.copyWith(
      lastCompleted: DateTime.now(),
      nextScheduled: DateTime.now().add(oldTask.reminderInterval),
      action: CareAction.completed,
    );

    _localCache[index] = updatedTask;
    return updatedTask;
  }

  @override
  Future<void> updateMetric(
    String taskId,
    String metricId,
    bool isCompleted,
  ) async {
    final index = _localCache.indexWhere((task) => task.id == taskId);
    if (index == -1) throw Exception('Task not found');

    final task = _localCache[index];
    final updatedMetrics = task.metrics.map((metric) {
      if (metric.id == metricId) {
        // metric.copyWith теперь возвращает CareMetricModel
        return metric.copyWith(isCompleted: isCompleted);
      }
      return metric;
    }).toList();

    _localCache[index] = task.copyWith(metrics: updatedMetrics);
  }

  @override
  Future<void> scheduleReminder(String taskId, DateTime scheduledTime) async {
    final index = _localCache.indexWhere((task) => task.id == taskId);
    if (index == -1) throw Exception('Task not found');

    _localCache[index] = _localCache[index].copyWith(
      nextScheduled: scheduledTime,
    );
  }

  Future<void> _initializeDefaultTasks() async {
    _localCache.addAll([
      CareTaskModel(
        id: '1',
        type: CareTaskType.feeding,
        title: 'Кормление',
        iconPath: 'assets/icons/feeding.svg',
        reminderInterval: const Duration(hours: 8),
        action: CareAction.pending,
        metrics: const [
          CareMetricModel(
            id: 'm1',
            label: 'Кормление',
            value: '1/3',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm2',
            label: 'Мыли',
            value: 'На неделе',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm3',
            label: 'Обновление',
            value: 'Каждый день',
            isCompleted: false,
          ),
        ],
      ),
      CareTaskModel(
        id: '2',
        type: CareTaskType.water,
        title: 'Вода',
        iconPath: 'assets/icons/water.svg',
        reminderInterval: const Duration(hours: 12),
        action: CareAction.pending,
        metrics: const [
          CareMetricModel(
            id: 'm4',
            label: 'Миска',
            value: '1 Миска',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm5',
            label: 'Мыли',
            value: 'На неделе',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm6',
            label: 'Обновление',
            value: 'Каждый день',
            isCompleted: false,
          ),
        ],
      ),
      CareTaskModel(
        id: '3',
        type: CareTaskType.litter,
        title: 'Лоток',
        iconPath: 'assets/icons/litter.svg',
        reminderInterval: const Duration(days: 1),
        action: CareAction.pending,
        metrics: const [
          CareMetricModel(
            id: 'm7',
            label: 'Наполнен',
            value: '',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm8',
            label: 'Убран',
            value: '',
            isCompleted: false,
          ),
          CareMetricModel(
            id: 'm9',
            label: 'Помыт',
            value: '',
            isCompleted: false,
          ),
        ],
      ),
    ]);
  }
}
