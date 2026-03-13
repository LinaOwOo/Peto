import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/care_tracker_repository.dart';
import '../state/care_tracker_state.dart';

// 🔹 Provider<> для репозитория — поддерживает overrideWithValue
final careTrackerRepositoryProvider = Provider<CareTrackerRepository>((ref) {
  throw UnimplementedError('Provide repository in main.dart via overrides');
});

// 🔹 StateNotifier для бизнес-логики
class CareTrackerNotifier extends StateNotifier<CareTrackerState> {
  final CareTrackerRepository _repository;

  CareTrackerNotifier(this._repository)
    : super(const CareTrackerState.loading()) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _repository.getTasks();
      state = CareTrackerState.success(tasks);
    } catch (e) {
      state = CareTrackerState.error(e.toString());
    }
  }

  Future<void> completeTask(String taskId) async {
    await _repository.completeTask(taskId);
    _loadTasks();
  }

  Future<void> refresh() async => _loadTasks();
}

// 🔹 StateNotifierProvider для экрана
final careTrackerNotifierProvider =
    StateNotifierProvider<CareTrackerNotifier, CareTrackerState>((ref) {
      final repository = ref.watch(careTrackerRepositoryProvider);
      return CareTrackerNotifier(repository);
    });
