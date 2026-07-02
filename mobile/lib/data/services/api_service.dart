import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';
import '../models/auth_response.dart';
import '../models/event.dart';
import '../models/paginated_response.dart';

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

  @GET("/events")
  Future<PaginatedResponse<Event>> getEvents();

  @GET("/events/{id}")
  Future<Event> getEvent(@Path("id") int id);

  @POST("/events")
  Future<Event> createEvent(@Body() Map<String, dynamic> body);

  @PUT("/events/{id}")
  Future<Event> updateEvent(@Path("id") int id, @Body() Map<String, dynamic> body);

  @GET("/my-events")
  Future<PaginatedResponse<Event>> getMyEvents();

  @GET("/my-participations")
  Future<PaginatedResponse<Event>> getMyParticipations();

  @POST("/events/{id}/publish")
  Future<void> publishEvent(@Path("id") int id);

  @POST("/events/{id}/cancel")
  Future<void> cancelEvent(@Path("id") int id);

  @POST("/events/{id}/finish")
  Future<void> finishEvent(@Path("id") int id);

  @POST("/events/{id}/participate")
  Future<void> participate(@Path("id") int id);

  @DELETE("/events/{id}/participate")
  Future<void> cancelParticipation(@Path("id") int id);

  @GET("/events/{id}/certificate")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadCertificate(@Path("id") int id);

  @POST("/attend-by-token")
  Future<void> attendByToken(@Body() Map<String, dynamic> body);
}
