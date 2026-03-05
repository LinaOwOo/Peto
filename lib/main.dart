import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/themes/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: PetPlanetApp()));
}

class PetPlanetApp extends StatelessWidget {
  const PetPlanetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPlanet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
