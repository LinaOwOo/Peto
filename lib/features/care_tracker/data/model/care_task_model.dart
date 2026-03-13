import '../../domain/entities/care_task_entity.dart';

class CareTaskModel {
  final String id;
  final String title;
  final String type;
  final String iconPath;
  final Map<String, dynamic> metrics;
  final int reminderIntervalSeconds;
  final String action;
  final DateTime createdAt;
  final String petId;

  CareTaskModel({
    required this.id,
    required this.title,
    required this.type,
    required this.iconPath,
    required this.metrics,
    required this.reminderIntervalSeconds,
    required this.action,
    required this.createdAt,
    required this.petId,
  });

  CareTaskEntity toEntity() {
    return CareTaskEntity(
      id: id,
      title: title,
      type: CareTaskType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => CareTaskType.other,
      ),
      iconPath: iconPath,
      metrics: metrics,
      reminderInterval: Duration(seconds: reminderIntervalSeconds),
      action: action,
      createdAt: createdAt,
      petId: petId,
    );
  }

  factory CareTaskModel.fromEntity(CareTaskEntity entity) {
    return CareTaskModel(
      id: entity.id,
      title: entity.title,
      type: entity.type.name,
      iconPath: entity.iconPath,
      metrics: entity.metrics,
      reminderIntervalSeconds: entity.reminderInterval.inSeconds,
      action: entity.action,
      createdAt: entity.createdAt,
      petId: entity.petId,
    );
  }

  factory CareTaskModel.fromJson(Map<String, dynamic> json) {
    return CareTaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      iconPath: json['iconPath'] as String,
      metrics: json['metrics'] as Map<String, dynamic>? ?? {},
      reminderIntervalSeconds: json['reminderIntervalSeconds'] as int? ?? 3600,
      action: json['action'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      petId: json['petId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'iconPath': iconPath,
      'metrics': metrics,
      'reminderIntervalSeconds': reminderIntervalSeconds,
      'action': action,
      'createdAt': createdAt.toIso8601String(),
      'petId': petId,
    };
  }
}
