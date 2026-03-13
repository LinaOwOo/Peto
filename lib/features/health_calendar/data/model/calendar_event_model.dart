import '../../domain/entities/calendar_event_entity.dart';

class CalendarEventModel {
  final String id;
  final String title;
  final String? description;
  final String date;
  final bool isCompleted;
  final String petId;
  final String type;

  CalendarEventModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.isCompleted,
    required this.petId,
    required this.type,
  });

  CalendarEventEntity toEntity() {
    return CalendarEventEntity(
      id: id,
      title: title,
      description: description,
      date: DateTime.parse(date),
      isCompleted: isCompleted,
      petId: petId,
      type: EventType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => EventType.other,
      ),
    );
  }

  factory CalendarEventModel.fromEntity(CalendarEventEntity entity) {
    return CalendarEventModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      date: entity.date.toIso8601String(),
      isCompleted: entity.isCompleted,
      petId: entity.petId,
      type: entity.type.name,
    );
  }

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['date'] as String,
      isCompleted: json['isCompleted'] as bool,
      petId: json['petId'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'isCompleted': isCompleted,
    'petId': petId,
    'type': type,
  };
}
