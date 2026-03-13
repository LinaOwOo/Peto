import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/calendar_event_entity.dart';

class PawMarker extends StatelessWidget {
  final EventType type;
  final double size;

  const PawMarker({super.key, required this.type, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getColorForType(type),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getColorForType(EventType type) {
    switch (type) {
      case EventType.vet:
        return AppColors.error;
      case EventType.medication:
        return AppColors.warning;
      case EventType.grooming:
        return AppColors.info;
      case EventType.training:
        return AppColors.success;
      case EventType.other:
        return AppColors.secondary;
    }
  }
}
