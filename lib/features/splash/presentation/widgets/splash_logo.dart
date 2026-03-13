import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/themes/app_colors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/logo.svg',
          width: 30,
          height: 50,
          colorFilter: const ColorFilter.mode(
            AppColors.primaryBright,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pet + Todo',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryBright,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
