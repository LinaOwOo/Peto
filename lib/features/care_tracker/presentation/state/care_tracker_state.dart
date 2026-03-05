import 'package:equatable/equatable.dart';
import '../../domain/entities/care_task_entity.dart';

enum CareTrackerStatus { initial, loading, success, failure }

class CareTrackerState extends Equatable {
  final CareTrackerStatus status;
  final List<CareTaskEntity> tasks;
  final String? errorMessage;

  const CareTrackerState({
    required this.status,
    required this.tasks,
    this.errorMessage,
  });

  factory CareTrackerState.initial() {
    return const CareTrackerState(status: CareTrackerStatus.initial, tasks: []);
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage];

  CareTrackerState copyWith({
    CareTrackerStatus? status,
    List<CareTaskEntity>? tasks,
    String? errorMessage,
  }) {
    return CareTrackerState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
    );
  }
}
