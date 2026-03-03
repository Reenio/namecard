import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:namecard/providers/storage_provider.dart';

class QrDisplayScreen extends ConsumerWidget {
  const QrDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCardAsync = ref.watch(myNamecardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My QR Code')),
      body: Center(
        child: myCardAsync.when(
          data: (myCard) {
            if (myCard == null) {
              return const Text('Please setup your profile first.');
            }
            
            // Encode the namecard as a JSON string for the QR code payload.
            // In a real production app with large amounts of data, we would compress this
            // or use a short-link URL that points to a backend containing the data. 
            // Here, we store it inline for pure offline functionality.
            final qrData = jsonEncode(myCard.toJson());
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Scan to receive my Namecard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  myCard.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                if (myCard.title != null && myCard.title!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      myCard.title!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error loading profile: $err'),
        ),
      ),
    );
  }
}
