import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:namecard/models/namecard.dart';
import 'package:namecard/providers/storage_provider.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        setState(() => _isProcessing = true);
        
        try {
          final Map<String, dynamic> data = jsonDecode(barcode.rawValue!);
          
          // Verify it's a valid Namecard payload
          if (data.containsKey('uuid') && data.containsKey('name')) {
            final receivedCard = Namecard.fromJson(data);
            
            // Save it
            await ref.read(storageServiceProvider).saveReceivedNamecard(receivedCard, 'qr');
            ref.invalidate(receivedNamecardsProvider);
            ref.invalidate(shareHistoryProvider);
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Received Namecard from ${receivedCard.name} !')),
              );
              Navigator.of(context).pop(); // Go back after success
            }
          } else {
             _showError('Invalid QR Code data format.');
          }
        } catch (e) {
          _showError('Failed to parse QR code.');
        }
        
        return; // Process only the first valid one
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isProcessing = false);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Namecard QR')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),
          // A scanning overlay frame could go here
          Center(
             child: Container(
               width: 250,
               height: 250,
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.green, width: 2),
                 color: Colors.transparent,
               ),
             ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
