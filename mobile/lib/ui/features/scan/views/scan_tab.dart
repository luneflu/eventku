import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../view_models/scan_view_model.dart';

import '../../../core/utils/error_handler.dart';

class ScanTab extends ConsumerStatefulWidget {
  const ScanTab({super.key});

  @override
  ConsumerState<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends ConsumerState<ScanTab> {
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    final state = ref.read(scanViewModelProvider).value;
    if (state == null || !state.isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    try {
      await ref.read(scanViewModelProvider.notifier).attendByToken(code);
    } catch (e) {
      ref.read(scanViewModelProvider.notifier).setError(extractErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanStateAsync = ref.watch(scanViewModelProvider);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Scan Event QR Code to Record Attendance', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Stack(
            children: [
              MobileScanner(
                controller: _scannerController,
                onDetect: _handleBarcode,
              ),
              if (scanStateAsync.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (scanStateAsync.value?.errorMessage != null)
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: FAlert(
                    title: const Text('Error'),
                    subtitle: Text(scanStateAsync.value!.errorMessage!),
                    style: context.theme.alertStyles.destructive,
                  ),
                )
              else if (scanStateAsync.value?.successMessage != null)
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: FAlert(
                    title: const Text('Success'),
                    subtitle: Text(scanStateAsync.value!.successMessage!),
                    style: context.theme.alertStyles.primary,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

