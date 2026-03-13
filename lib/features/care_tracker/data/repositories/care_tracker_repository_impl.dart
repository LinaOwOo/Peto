import '../../domain/entities/care_task_entity.dart';
import '../../domain/repositories/care_tracker_repository.dart';

class CareTrackerStubRepository implements CareTrackerRepository {
  static final _mockTasks = <CareTaskEntity>[
    CareTaskEntity(
      id: '1',
      title: 'Покормить питомца',
      type: CareTaskType.feeding,
      iconPath: 'assets/icons/feeding.svg',
      metrics: {'portion': '150g'},
      reminderInterval: const Duration(hours: 8),
      action: 'feed',
      createdAt: DateTime.now(),
      petId: 'pet_1',
    ),
  ];

  @override
  Future<List<CareTaskEntity>> getTasks() async => _mockTasks;

  @override
  Future<void> completeTask(String taskId) async {}

  @override
  Future<void> addTask(CareTaskEntity task) async {}

  @override
  Future<void> updateTask(CareTaskEntity task) async {}
}
