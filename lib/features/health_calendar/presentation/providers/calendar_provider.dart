import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../state/calendar_state.dart';

// 🔹 Provider<> для репозитория — поддерживает overrideWithValue
final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  throw UnimplementedError('Provide repository in main.dart via overrides');
});

// 🔹 StateNotifier для бизнес-логики
class CalendarNotifier extends StateNotifier<CalendarState> {
  final CalendarRepository _repository;

  CalendarNotifier(this._repository) : super(const CalendarState.loading()) {
    _loadEvents(DateTime.now());
  }

  Future<void> _loadEvents(DateTime month) async {
    try {
      state = const CalendarState.loading();
      final events = await _repository.getEventsForMonth(month);
      state = CalendarState.success(events, focusedMonth: month);
    } catch (e) {
      state = CalendarState.error(e.toString());
    }
  }

  Future<void> toggleCompletion(String eventId) async {
    await _repository.toggleEventCompletion(eventId);
    _loadEvents(state.focusedMonth ?? DateTime.now());
  }

  void changeMonth(DateTime month) => _loadEvents(month);
  void selectDate(DateTime date) => state = state.copyWith(selectedDate: date);
}

// 🔹 StateNotifierProvider для экрана
final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>(
  (ref) {
    final repository = ref.watch(calendarRepositoryProvider);
    return CalendarNotifier(repository);
  },
);
