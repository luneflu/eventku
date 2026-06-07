import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';
import '../models/auth_response.dart';

part 'api_service.g.dart';

const String _apiBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:8000/api',
);

@RestApi(baseUrl: _apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/register")
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST("/login")
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<void> logout();

  @GET("/profile")
  Future<User> profile();
}
