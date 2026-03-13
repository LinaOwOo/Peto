import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, bool>((ref) {
  return SplashNotifier();
});

class SplashNotifier extends StateNotifier<bool> {
  SplashNotifier() : super(false) {
    _initSplash();
  }

  Future<void> _initSplash() async {
    state = false;
    await Future.delayed(const Duration(seconds: 2));
    state = true;
  }

  Future<void> reset() async {
    state = false;
    await Future.delayed(const Duration(seconds: 2));
    state = true;
  }
}
