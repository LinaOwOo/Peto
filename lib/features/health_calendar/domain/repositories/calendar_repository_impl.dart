import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final List<CalendarEvent> _localCache = [];

  @override
  Future<List<CalendarEvent>> getEventsForMonth(DateTime month) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _localCache.where((event) {
      return event.date.year == month.year && event.date.month == month.month;
    }).toList();
  }

  @override
  Future<void> addEvent(CalendarEvent event) async {
    _localCache.add(event);
  }

  @override
  Future<void> toggleEventCompletion(String eventId) async {
    final index = _localCache.indexWhere((e) => e.id == eventId);
    if (index != -1) {
      final event = _localCache[index];
      _localCache[index] = event.copyWith(isCompleted: !event.isCompleted);
    }
  }
}
