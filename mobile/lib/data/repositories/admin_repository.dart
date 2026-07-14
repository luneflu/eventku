import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import '../models/user.dart';
import '../models/paginated_response.dart';
import '../services/providers.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(ref);
});

class AdminRepository {
  final Ref ref;

  AdminRepository(this.ref);

  Future<PaginatedResponse<User>> getUsers() async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getAdminUsers();
  }

  Future<User> toggleUserBan(int id) async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.toggleUserBan(id);
  }

  Future<PaginatedResponse<Event>> getEvents() async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getAdminEvents();
  }

  Future<Event> toggleEventBan(int id) async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.toggleEventBan(id);
  }
}
