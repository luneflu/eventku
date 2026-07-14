import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user.dart';
import '../../../../data/repositories/admin_repository.dart';

final adminUsersViewModelProvider = AsyncNotifierProvider<AdminUsersViewModel, List<User>>(
  () => AdminUsersViewModel(),
);

class AdminUsersViewModel extends AsyncNotifier<List<User>> {
  late AdminRepository _repository;

  @override
  FutureOr<List<User>> build() async {
    _repository = ref.watch(adminRepositoryProvider);
    return await _fetchUsers();
  }

  Future<List<User>> _fetchUsers() async {
    final response = await _repository.getUsers();
    return response.data;
  }

  Future<void> toggleUserBan(int id) async {
    final previousState = state;
    try {
      final updatedUser = await _repository.toggleUserBan(id);
      
      state = AsyncValue.data(
        state.value?.map((user) => user.id == id ? updatedUser : user).toList() ?? [],
      );
    } catch (e, st) {
      state = previousState;
      state = AsyncValue.error(e, st);
    }
  }
}
