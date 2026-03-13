import 'package:equatable/equatable.dart';
import '../../domain/entities/calendar_event_entity.dart';

enum CalendarStatus { initial, loading, success, error }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<CalendarEventEntity> events;
  final DateTime? focusedMonth;
  final DateTime? selectedDate;
  final String? error;

  const CalendarState._({
    required this.status,
    required this.events,
    this.focusedMonth,
    this.selectedDate,
    this.error,
  });

  const CalendarState.initial()
    : this._(status: CalendarStatus.initial, events: const []);

  const CalendarState.loading()
    : this._(status: CalendarStatus.loading, events: const []);

  const CalendarState.success(this.events, {this.focusedMonth})
    : this._(status: CalendarStatus.success, error: null);

  const CalendarState.error(this.error)
    : this._(status: CalendarStatus.error, events: const []);

  CalendarState copyWith({
    CalendarStatus? status,
    List<CalendarEventEntity>? events,
    DateTime? focusedMonth,
    DateTime? selectedDate,
    String? error,
  }) {
    return CalendarState._(
      status: status ?? this.status,
      events: events ?? this.events,
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    events,
    focusedMonth,
    selectedDate,
    error,
  ];
}
