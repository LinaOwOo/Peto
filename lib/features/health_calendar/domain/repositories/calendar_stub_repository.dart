import '../../domain/entities/calendar_event_entity.dart';
import '../../domain/repositories/calendar_repository.dart';

class CalendarStubRepository implements CalendarRepository {
  static final _mockEvents = <CalendarEventEntity>[
    CalendarEventEntity(
      id: 'evt_1',
      title: 'Визит к ветеринару',
      description: 'Плановый осмотр',
      date: DateTime.now(),
      isCompleted: false,
      petId: 'pet_1',
      type: EventType.vet,
    ),
  ];

  @override
  Future<List<CalendarEventEntity>> getEventsForMonth(DateTime month) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockEvents
        .where((e) => e.date.year == month.year && e.date.month == month.month)
        .toList();
  }

  @override
  Future<void> addEvent(CalendarEventEntity event) async {}

  @override
  Future<void> updateEvent(CalendarEventEntity event) async {}

  @override
  Future<void> toggleEventCompletion(String eventId) async {}
}
