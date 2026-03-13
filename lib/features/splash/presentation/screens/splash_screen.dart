import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_logo.dart';
import '../widgets/loading_spinner.dart';
import '../../../../core/themes/app_colors.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ Переменная isLoadingComplete удалена — она не использовалась

    ref.listen<bool>(splashProvider, (previous, next) {
      if (next == true) {
        context.go('/home');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SplashLogo(),
              SizedBox(height: 48),
              LoadingSpinner(),
            ],
          ),
        ),
      ),
    );
  }
}
