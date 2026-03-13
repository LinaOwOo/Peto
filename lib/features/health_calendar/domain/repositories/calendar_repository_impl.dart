import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/model/calendar_event_model.dart';
import '../../domain/entities/calendar_event_entity.dart';
import '../../domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'calendar_events';

  CalendarRepositoryImpl(this._firestore);

  @override
  Future<List<CalendarEventEntity>> getEventsForMonth(DateTime month) async {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
    final snapshot = await _firestore
        .collection(_collection)
        .where('date', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('date', isLessThanOrEqualTo: end.toIso8601String())
        .get();
    return snapshot.docs
        .map((doc) => CalendarEventModel.fromJson(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<void> addEvent(CalendarEventEntity event) async {
    final model = CalendarEventModel.fromEntity(event);
    await _firestore.collection(_collection).doc(event.id).set(model.toJson());
  }

  @override
  Future<void> updateEvent(CalendarEventEntity event) async {
    final model = CalendarEventModel.fromEntity(event);
    await _firestore
        .collection(_collection)
        .doc(event.id)
        .update(model.toJson());
  }

  @override
  Future<void> toggleEventCompletion(String eventId) async {
    final doc = await _firestore.collection(_collection).doc(eventId).get();
    final current = doc.data()?['isCompleted'] as bool? ?? false;
    await doc.reference.update({'isCompleted': !current});
  }
}
