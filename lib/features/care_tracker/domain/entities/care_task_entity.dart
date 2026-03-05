import 'package:equatable/equatable.dart';

enum CareTaskType { feeding, water, litter }

enum CareAction { completed, inProgress, pending }

class CareTaskEntity extends Equatable {
  final String id;
  final CareTaskType type;
  final String title;
  final String iconPath;
  final List<CareMetricEntity> metrics;
  final DateTime? lastCompleted;
  final DateTime? nextScheduled;
  final Duration reminderInterval;
  final CareAction action;

  const CareTaskEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.iconPath,
    required this.metrics,
    this.lastCompleted,
    this.nextScheduled,
    required this.reminderInterval,
    required this.action,
  });

  bool get isOverdue {
    if (nextScheduled == null) return false;
    return DateTime.now().isAfter(nextScheduled!);
  }

  Duration? get timeUntilDue {
    if (nextScheduled == null) return null;
    return nextScheduled!.difference(DateTime.now());
  }

  String get formattedTimeStatus {
    if (lastCompleted == null) return 'Never';
    final difference = DateTime.now().difference(lastCompleted!);
    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    }
    return '${difference.inDays}d ago';
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    iconPath,
    metrics,
    lastCompleted,
    nextScheduled,
    reminderInterval,
    action,
  ];

  CareTaskEntity copyWith({
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
    return CareTaskEntity(
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

class CareMetricEntity extends Equatable {
  final String id;
  final String label;
  final String value;
  final bool isCompleted;

  const CareMetricEntity({
    required this.id,
    required this.label,
    required this.value,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, label, value, isCompleted];

  CareMetricEntity copyWith({
    String? id,
    String? label,
    String? value,
    bool? isCompleted,
  }) {
    return CareMetricEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      value: value ?? this.value,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
