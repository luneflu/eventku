import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'api_service.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Break dependency cycle by creating storage directly for the interceptor
        const storage = FlutterSecureStorage(
          mOptions: MacOsOptions(usesDataProtectionKeychain: true),
        );
        final token = await storage.read(key: 'auth_token');
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
