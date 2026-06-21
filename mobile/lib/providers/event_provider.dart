import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import 'auth_provider.dart';

final publicEventsProvider = FutureProvider<List<Event>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.getEvents();
  return response.data;
});

final myEventsProvider = FutureProvider<List<Event>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.getMyEvents();
  return response.data;
});

final myParticipationsProvider = FutureProvider<List<Event>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final response = await api.getMyParticipations();
  return response.data;
});
