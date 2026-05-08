// lib/features/profile/providers/profile_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String name;
  final String email;
  final bool isVerified;

  ProfileSuccess({
    this.name = "Alexander Vance",
    this.email = "alex.vance@example.com",
    this.isVerified = true,
  });
}

class ProfileNotifier extends AsyncNotifier<ProfileState> {
  @override
  Future<ProfileState> build() async => ProfileSuccess();

  Future<void> loadProfile() async {
    state = AsyncData(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 600));
    state = AsyncData(ProfileSuccess());
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, ProfileState>(
      () => ProfileNotifier(),
);