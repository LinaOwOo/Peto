// lib/features/care_tracker/data/models/care_task_model.dart
import '../../domain/entities/care_task_entity.dart';

class CareTaskModel extends CareTaskEntity {
  const CareTaskModel({
    required super.id,
    required super.type,
    required super.title,
    required super.iconPath,
    required super.metrics,
    super.lastCompleted,
    super.nextScheduled,
    required super.reminderInterval,
    required super.action,
  });

  @override
  CareTaskModel copyWith({
    String? id,
    CareTaskType? type,
    String? title,
    String? iconPath,
    List<CareMetricEntity>? metrics,
    DateTime? lastCompleted,
    DateTime? nextScheduled,
    Duration? reminderInterval,
    CareAction? action,
  }) {
    return CareTaskModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      metrics: metrics ?? this.metrics,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      nextScheduled: nextScheduled ?? this.nextScheduled,
      reminderInterval: reminderInterval ?? this.reminderInterval,
      action: action ?? this.action,
    );
  }
}

class CareMetricModel extends CareMetricEntity {
  const CareMetricModel({
    required super.id,
    required super.label,
    required super.value,
    required super.isCompleted,
  });

  @override
  CareMetricModel copyWith({
    String? id,
    String? label,
    String? value,
    bool? isCompleted,
  }) {
    return CareMetricModel(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
