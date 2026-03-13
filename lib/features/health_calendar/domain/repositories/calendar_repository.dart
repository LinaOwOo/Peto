import '../entities/calendar_event_entity.dart'; // ← исправленный путь

abstract class CalendarRepository {
  Future<List<CalendarEventEntity>> getEventsForMonth(DateTime month);
  Future<void> addEvent(CalendarEventEntity event);
  Future<void> updateEvent(CalendarEventEntity event);
  Future<void> toggleEventCompletion(String eventId);
}
