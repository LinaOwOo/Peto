import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../core/providers/navigation_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final navIndex = ref.watch(navigationProvider);

    if (profileState.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = profileState.user;

    if (user == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('Error loading profile')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ProfileHeader(user: user),
              const SizedBox(height: 30),
              ProfileStats(user: user),
              const Spacer(),
              Center(
                child: Text(
                  'PetPlanet v1.0',
                  style: TextStyle(
                    color: AppColors.textGrey.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BottomNavBar(
                selectedIndex: navIndex,
                onItemSelected: (index) => context.go(
                  ['/home', '/care-tracker', '/calendar', '/profile'][index],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
