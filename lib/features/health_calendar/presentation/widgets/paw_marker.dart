import 'package:flutter/material.dart';
import '../../domain/entities/calendar_event.dart';
import '../../../../core/themes/app_colors.dart';

class PawMarker extends StatelessWidget {
  final EventType type;

  const PawMarker({super.key, required this.type});

  Color get _color {
    switch (type) {
      case EventType.grooming:
        return AppColors.primaryBright;
      case EventType.vet:
        return AppColors.success;
      case EventType.medicine:
        return AppColors.warning;
      case EventType.other:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.pets, size: 16, color: _color),
    );
  }
}
