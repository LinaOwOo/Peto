import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../domain/repositories/calendar_repository_impl.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepositoryImpl();
});

class CalendarState {
  final DateTime focusedMonth;
  final DateTime? selectedDate;
  final List<CalendarEvent> events;
  final bool isLoading;

  CalendarState({
    DateTime? focusedMonth,
    this.selectedDate,
    List<CalendarEvent>? events,
    this.isLoading = false,
  }) : focusedMonth =
           focusedMonth ??
           DateTime(DateTime.now().year, DateTime.now().month, 1),
       events = events ?? const [];

  CalendarState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDate,
    List<CalendarEvent>? events,
    bool? isLoading,
  }) {
    return CalendarState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CalendarNotifier extends StateNotifier<CalendarState> {
  final CalendarRepository _repository;

  CalendarNotifier(this._repository) : super(CalendarState()) {
    loadEvents();
  }

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true);
    final events = await _repository.getEventsForMonth(state.focusedMonth);
    state = state.copyWith(events: events, isLoading: false);
  }

  void changeMonth(DateTime month) {
    state = state.copyWith(focusedMonth: month);
    loadEvents();
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  Future<void> addEvent(CalendarEvent event) async {
    await _repository.addEvent(event);
    loadEvents();
  }

  Future<void> toggleCompletion(String id) async {
    await _repository.toggleEventCompletion(id);
    loadEvents();
  }
}

final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>(
  (ref) {
    return CalendarNotifier(ref.watch(calendarRepositoryProvider));
  },
);
