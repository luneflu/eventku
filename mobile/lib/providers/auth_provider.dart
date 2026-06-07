import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user.dart';
import '../services/api_service.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    mOptions: MacOsOptions(usesDataProtectionKeychain: true),
  );
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final secureStorage = ref.read(secureStorageProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      },
    ),
  );

  return dio;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  final envUrl = dotenv.env['API_URL'];
  if (envUrl != null && envUrl.isNotEmpty) {
    return ApiService(dio, baseUrl: envUrl);
  }
  String baseUrl = "http://localhost:8000/api";
  if (!kIsWeb && Platform.isAndroid) {
    baseUrl = "http://10.0.2.2:8000/api";
  }
  return ApiService(dio, baseUrl: baseUrl);
});

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final secureStorage = ref.watch(secureStorageProvider);
    final token = await secureStorage.read(key: 'auth_token');
    if (token == null) {
      return null;
    }

    try {
      final api = ref.watch(apiServiceProvider);
      return await api.profile();
    } catch (e) {
      await secureStorage.delete(key: 'auth_token');
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      final response = await api.login({'email': email, 'password': password});
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.write(key: 'auth_token', value: response.token);

      return response.user;
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      final response = await api.register({
        'name': name,
        'email': email,
        'password': password,
      });

      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.write(key: 'auth_token', value: response.token);

      return response.user;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final api = ref.read(apiServiceProvider);
        await api.logout();
      } catch (_) {
        // Suppress API logout errors to allow local logout to succeed
      }
      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.delete(key: 'auth_token');
      return null;
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
