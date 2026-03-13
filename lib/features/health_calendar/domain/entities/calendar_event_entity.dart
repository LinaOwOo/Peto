import 'package:equatable/equatable.dart';

enum EventType { vet, medication, grooming, training, other }

class CalendarEventEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final bool isCompleted;
  final String petId;
  final EventType type;

  const CalendarEventEntity({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.isCompleted,
    required this.petId,
    required this.type,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    isCompleted,
    petId,
    type,
  ];

  CalendarEventEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
    String? petId,
    EventType? type,
  }) {
    return CalendarEventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      petId: petId ?? this.petId,
      type: type ?? this.type,
    );
  }
}
