import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../providers/auth_provider.dart';

import '../../utils/error_handler.dart';

class ScanTab extends ConsumerStatefulWidget {
  const ScanTab({super.key});

  @override
  ConsumerState<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends ConsumerState<ScanTab> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isScanning = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (!_isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    setState(() {
      _isScanning = false;
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final api = ref.read(apiServiceProvider);
      await api.attendByToken({'qr_token': code});
      
      if (mounted) {
        setState(() {
          _successMessage = 'Attendance recorded successfully!';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = extractErrorMessage(e);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Add delay before allowing next scan to avoid spam
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) setState(() => _isScanning = true);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (_errorMessage != null)
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: FAlert(
                    title: const Text('Error'),
                    subtitle: Text(_errorMessage!),
                    style: context.theme.alertStyles.destructive,
                  ),
                )
              else if (_successMessage != null)
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: FAlert(
                    title: const Text('Success'),
                    subtitle: Text(_successMessage!),
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
