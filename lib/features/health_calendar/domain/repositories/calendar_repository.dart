import '../entities/calendar_event.dart';

abstract class CalendarRepository {
  Future<List<CalendarEvent>> getEventsForMonth(DateTime month);
  Future<void> addEvent(CalendarEvent event);
  Future<void> toggleEventCompletion(String eventId);
}
