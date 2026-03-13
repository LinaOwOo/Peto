import 'package:equatable/equatable.dart';

class CareMetricEntity extends Equatable {
  final String id;
  final String label;
  final dynamic value;
  final bool isCompleted;

  const CareMetricEntity({
    required this.id,
    required this.label,
    required this.value,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, label, value, isCompleted];
}
