import '../../domain/entities/care_task_entity.dart';
import '../../domain/repositories/care_tracker_repository.dart';

class CareTrackerStubRepository implements CareTrackerRepository {
  static final _mockTasks = [
    CareTaskEntity(
      id: '1',
      title: 'Покормить питомца',
      type: CareTaskType.feeding,
      iconPath: 'assets/icons/feeding.svg',
      metrics: {'portion': '150g', 'calories': 300},
      reminderInterval: const Duration(hours: 8),
      action: 'feed',
      createdAt: DateTime.now(),
      petId: 'pet_1',
    ),
    CareTaskEntity(
      id: '2',
      title: 'Прогулка',
      type: CareTaskType.walking,
      iconPath: 'assets/icons/walking.svg',
      metrics: {'duration': '30min', 'distance': '2km'},
      reminderInterval: const Duration(hours: 6),
      action: 'walk',
      createdAt: DateTime.now(),
      petId: 'pet_1',
    ),
  ];

  @override
  Future<List<CareTaskEntity>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTasks;
  }

  @override
  Future<void> completeTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> addTask(CareTaskEntity task) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> updateTask(CareTaskEntity task) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
