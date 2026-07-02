import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/event_repository.dart';

class ScanState {
  final bool isScanning;
  final String? successMessage;
  final String? errorMessage;

  ScanState({
    this.isScanning = true,
    this.successMessage,
    this.errorMessage,
  });
}

final scanViewModelProvider =
    AsyncNotifierProvider<ScanViewModel, ScanState>(ScanViewModel.new);

class ScanViewModel extends AsyncNotifier<ScanState> {
  late EventRepository _repository;

  @override
  Future<ScanState> build() async {
    _repository = ref.watch(eventRepositoryProvider);
    return ScanState();
  }

  Future<void> attendByToken(String qrToken) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.attendByToken(qrToken);
      return ScanState(isScanning: false, successMessage: 'Attendance recorded successfully!');
    });

    await Future.delayed(const Duration(seconds: 2));
    state = AsyncValue.data(ScanState(isScanning: true));
  }

  void setError(String message) {
    state = AsyncValue.data(ScanState(isScanning: false, errorMessage: message));
    Future.delayed(const Duration(seconds: 2), () {
      state = AsyncValue.data(ScanState(isScanning: true));
    });
  }
}
