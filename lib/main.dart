import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/navigation_provider.dart';
import 'core/themes/app_theme.dart';
import 'features/care_tracker/data/repositories/care_tracker_stub_repository.dart';
import 'features/care_tracker/presentation/providers/care_tracker_provider.dart';
import 'features/health_calendar/data/repositories/calendar_stub_repository.dart';
import 'features/health_calendar/presentation/providers/calendar_provider.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        // ✅ overrideWithValue работает только с Provider<>, а не NotifierProvider<>
        careTrackerRepositoryProvider.overrideWithValue(
          CareTrackerStubRepository(),
        ),
        calendarRepositoryProvider.overrideWithValue(CalendarStubRepository()),
      ],
      child: const PetPlanetApp(),
    ),
  );
}

class PetPlanetApp extends ConsumerWidget {
  const PetPlanetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
