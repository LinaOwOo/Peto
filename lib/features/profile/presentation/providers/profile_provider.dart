import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/user_entity.dart';

class ProfileState {
  final UserEntity? user;
  final bool isLoading;

  const ProfileState({this.user, this.isLoading = false});

  ProfileState copyWith({UserEntity? user, bool? isLoading}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState(isLoading: true)) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(user: UserEntity.mock, isLoading: false);
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier();
});
