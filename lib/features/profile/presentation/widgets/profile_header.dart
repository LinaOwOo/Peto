import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  final UserEntity user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBright,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
        ),
      ],
    );
  }
}
