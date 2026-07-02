import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user.dart';
import '../../../../data/repositories/auth_repository.dart';

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, User?>(
  () => AuthViewModel(),
);

class AuthViewModel extends AsyncNotifier<User?> {
  late AuthRepository _repository;

  @override
  FutureOr<User?> build() async {
    _repository = ref.watch(authRepositoryProvider);
    return await _repository.getUserProfile();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.login(email, password));
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.register(name, email, password));
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _repository.logout();
    state = const AsyncValue.data(null);
  }
}
