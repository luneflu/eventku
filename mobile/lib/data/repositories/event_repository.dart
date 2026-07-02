import 'dart:typed_data';
import '../models/event.dart';
import '../services/api_service.dart';
import '../services/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository(apiClient: ref.watch(apiServiceProvider));
});

class EventRepository {
  final ApiService _apiClient;

  EventRepository({required ApiService apiClient}) : _apiClient = apiClient;

  Future<List<Event>> getPublicEvents() async {
    final response = await _apiClient.getEvents();
    return response.data;
  }

  Future<List<Event>> getMyEvents() async {
    final response = await _apiClient.getMyEvents();
    return response.data;
  }

  Future<List<Event>> getMyParticipations() async {
    final response = await _apiClient.getMyParticipations();
    return response.data;
  }

  Future<Event> getEvent(String id) async {
    return await _apiClient.getEvent(int.parse(id));
  }

  Future<void> createEvent(Map<String, dynamic> data) async {
    await _apiClient.createEvent(data);
  }

  Future<void> publishEvent(String id) async {
    await _apiClient.publishEvent(int.parse(id));
  }

  Future<void> cancelEvent(String id) async {
    await _apiClient.cancelEvent(int.parse(id));
  }

  Future<void> finishEvent(String id) async {
    await _apiClient.finishEvent(int.parse(id));
  }

  Future<void> participate(String id) async {
    await _apiClient.participate(int.parse(id));
  }

  Future<void> cancelParticipation(String id) async {
    await _apiClient.cancelParticipation(int.parse(id));
  }

  Future<void> attendByToken(String qrToken) async {
    await _apiClient.attendByToken({'qr_token': qrToken});
  }

  Future<Uint8List> downloadCertificate(String id) async {
    final bytes = await _apiClient.downloadCertificate(int.parse(id));
    return Uint8List.fromList(bytes);
  }
}
