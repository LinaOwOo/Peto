import 'package:equatable/equatable.dart';

enum EventType { grooming, vet, medicine, other }

extension EventTypeExtension on EventType {
  String get label {
    switch (this) {
      case EventType.grooming:
        return 'Груминг';
      case EventType.vet:
        return 'Ветеринар';
      case EventType.medicine:
        return 'Лекарства';
      case EventType.other:
        return 'Другое';
    }
  }
}

class CalendarEvent extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final EventType type;
  final bool isCompleted;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    this.isCompleted = false,
  });

  CalendarEvent copyWith({
    String? id,
    String? title,
    DateTime? date,
    EventType? type,
    bool? isCompleted,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, date, type, isCompleted];
}
