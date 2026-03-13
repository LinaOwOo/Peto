import 'package:go_router/go_router.dart';
import '../../features/health_calendar/presentation/screens/calendar_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/care_tracker/presentation/screens/care_tracker_screen.dart'; // ✅ Проверить путь
import '../../features/profile/presentation/screens/profile_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/care-tracker',
        name: 'care-tracker',
        builder: (context, state) =>
            const CareTrackerScreen(), // ✅ Без параметров
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
