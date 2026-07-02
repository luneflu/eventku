import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/event.dart';
import '../../../../data/repositories/event_repository.dart';

final publicEventsViewModelProvider = AsyncNotifierProvider<PublicEventsViewModel, List<Event>>(
  () => PublicEventsViewModel(),
);

class PublicEventsViewModel extends AsyncNotifier<List<Event>> {
  late EventRepository _repository;

  @override
  FutureOr<List<Event>> build() async {
    _repository = ref.watch(eventRepositoryProvider);
    return await _repository.getPublicEvents();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getPublicEvents());
  }
}

final myEventsViewModelProvider = AsyncNotifierProvider<MyEventsViewModel, List<Event>>(
  () => MyEventsViewModel(),
);

class MyEventsViewModel extends AsyncNotifier<List<Event>> {
  late EventRepository _repository;

  @override
  FutureOr<List<Event>> build() async {
    _repository = ref.watch(eventRepositoryProvider);
    return await _repository.getMyEvents();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getMyEvents());
  }
}

final attendedEventsViewModelProvider = AsyncNotifierProvider<AttendedEventsViewModel, List<Event>>(
  () => AttendedEventsViewModel(),
);

class AttendedEventsViewModel extends AsyncNotifier<List<Event>> {
  late EventRepository _repository;

  @override
  FutureOr<List<Event>> build() async {
    _repository = ref.watch(eventRepositoryProvider);
    return await _repository.getMyParticipations();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getMyParticipations());
  }
}
