import 'package:equatable/equatable.dart';
import '../../domain/entities/care_task_entity.dart';

enum CareTrackerStatus { initial, loading, success, error }

class CareTrackerState extends Equatable {
  final CareTrackerStatus status;
  final List<CareTaskEntity> tasks;
  final String? error;

  const CareTrackerState._({
    required this.status,
    required this.tasks,
    this.error,
  });

  const CareTrackerState.initial()
    : this._(status: CareTrackerStatus.initial, tasks: const []);

  const CareTrackerState.loading()
    : this._(status: CareTrackerStatus.loading, tasks: const []);

  const CareTrackerState.success(this.tasks)
    : this._(status: CareTrackerStatus.success, error: null);

  const CareTrackerState.error(this.error)
    : this._(status: CareTrackerStatus.error, tasks: const []);

  CareTrackerState copyWith({
    CareTrackerStatus? status,
    List<CareTaskEntity>? tasks,
    String? error,
  }) {
    return CareTrackerState._(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, tasks, error];
}
