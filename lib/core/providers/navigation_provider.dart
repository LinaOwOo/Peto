import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/care_tracker/presentation/screens/care_tracker_screen.dart';
import '../../features/health_calendar/presentation/screens/calendar_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((
  ref,
) {
  return NavigationNotifier();
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final navigationNotifier = ref.read(navigationProvider.notifier);

  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigationNotifier.setIndex(0);
          });
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/care-tracker',
        name: 'care-tracker',
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigationNotifier.setIndex(1);
          });
          return const CareTrackerScreen();
        },
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigationNotifier.setIndex(2);
          });
          return const CalendarScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigationNotifier.setIndex(3);
          });
          return const ProfileScreen();
        },
      ),
    ],
  );
});
