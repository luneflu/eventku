import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    apiClient: ref.watch(apiServiceProvider),
    secureStorage: const FlutterSecureStorage(
      mOptions: MacOsOptions(usesDataProtectionKeychain: true),
    ),
  );
});

class AuthRepository {
  final ApiService _apiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({
    required ApiService apiClient,
    required FlutterSecureStorage secureStorage,
  })  : _apiClient = apiClient,
        _secureStorage = secureStorage;

  Future<User?> getUserProfile() async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token == null) return null;

    try {
      return await _apiClient.profile();
    } catch (e) {
      await _secureStorage.delete(key: 'auth_token');
      return null;
    }
  }

  Future<User> login(String email, String password) async {
    final response = await _apiClient.login({'email': email, 'password': password});
    await _secureStorage.write(key: 'auth_token', value: response.token);
    return response.user;
  }

  Future<User> register(String name, String email, String password) async {
    final response = await _apiClient.register({
      'name': name,
      'email': email,
      'password': password,
    });
    await _secureStorage.write(key: 'auth_token', value: response.token);
    return response.user;
  }

  Future<void> logout() async {
    try {
      await _apiClient.logout();
    } catch (_) {
      // Suppress API errors to ensure local logout succeeds
    } finally {
      await _secureStorage.delete(key: 'auth_token');
    }
  }

  Future<String?> getToken() => _secureStorage.read(key: 'auth_token');
}
