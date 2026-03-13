import 'package:equatable/equatable.dart';

enum CareTaskType { feeding, walking, grooming, medication, training, other }

class CareTaskEntity extends Equatable {
  final String id;
  final String title;
  final CareTaskType type;
  final String iconPath;
  final Map<String, dynamic> metrics;
  final Duration reminderInterval;
  final String action;
  final DateTime createdAt;
  final String petId;

  const CareTaskEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.iconPath,
    required this.metrics,
    required this.reminderInterval,
    required this.action,
    required this.createdAt,
    required this.petId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    type,
    iconPath,
    metrics,
    reminderInterval,
    action,
    createdAt,
    petId,
  ];

  CareTaskEntity copyWith({
    String? id,
    String? title,
    CareTaskType? type,
    String? iconPath,
    Map<String, dynamic>? metrics,
    Duration? reminderInterval,
    String? action,
    DateTime? createdAt,
    String? petId,
  }) {
    return CareTaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      iconPath: iconPath ?? this.iconPath,
      metrics: metrics ?? this.metrics,
      reminderInterval: reminderInterval ?? this.reminderInterval,
      action: action ?? this.action,
      createdAt: createdAt ?? this.createdAt,
      petId: petId ?? this.petId,
    );
  }
}
