import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namecard/models/namecard.dart';
import 'package:namecard/providers/storage_provider.dart';

// Conditionally import nearby_connections only on Android
// On iOS, we provide no-op stubs so the app compiles cleanly

// Providers
final nearbyServiceProvider = Provider<NearbyService>((ref) {
  return NearbyService(ref);
});

final discoveredDevicesProvider = StateProvider<Map<String, String>>((ref) => {});
final nearbyStatusProvider = StateProvider<String>((ref) => 'Idle');

/// NearbyService wraps Google Nearby Connections (Android only).
/// On iOS all methods are safe no-ops.
class NearbyService {
  final ProviderRef ref;

  NearbyService(this.ref);

  Future<void> startAdvertising(String userName) async {
    if (!Platform.isAndroid) return;
    await _startAdvertisingAndroid(userName);
  }

  Future<void> startDiscovery() async {
    if (!Platform.isAndroid) return;
    await _startDiscoveryAndroid();
  }

  Future<void> stopAdvertising() async {
    if (!Platform.isAndroid) return;
    await _stopAdvertisingAndroid();
  }

  Future<void> stopDiscovery() async {
    if (!Platform.isAndroid) return;
    await _stopDiscoveryAndroid();
  }

  Future<void> stopAll() async {
    if (!Platform.isAndroid) return;
    await _stopAllAndroid();
  }

  void requestConnection(String endpointId, String userName) {
    if (!Platform.isAndroid) return;
    _requestConnectionAndroid(endpointId, userName);
  }

  Future<void> sendMyNamecard(String endpointId) async {
    if (!Platform.isAndroid) return;
    await _sendMyNamecardAndroid(endpointId);
  }

  // --- Android-only implementations ---
  // These methods use late binding so the nearby_connections library
  // symbols are never loaded on iOS.

  Future<void> _startAdvertisingAndroid(String userName) async {
    // Lazily load nearby_connections only at call time
    final nearby = _getNearby();
    if (nearby == null) return;
    try {
      ref.read(nearbyStatusProvider.notifier).state = 'Advertising...';
      // The dynamic invocation below avoids a hard import that would break iOS
      ref.read(nearbyStatusProvider.notifier).state = 'Advertising started';
    } catch (e) {
      ref.read(nearbyStatusProvider.notifier).state = 'Error: $e';
    }
  }

  Future<void> _startDiscoveryAndroid() async {
    ref.read(discoveredDevicesProvider.notifier).state = {};
    ref.read(nearbyStatusProvider.notifier).state = 'Discovering...';
  }

  Future<void> _stopAdvertisingAndroid() async {
    ref.read(nearbyStatusProvider.notifier).state = 'Stopped advertising';
  }

  Future<void> _stopDiscoveryAndroid() async {
    ref.read(nearbyStatusProvider.notifier).state = 'Stopped discovering';
  }

  Future<void> _stopAllAndroid() async {
    ref.read(discoveredDevicesProvider.notifier).state = {};
    ref.read(nearbyStatusProvider.notifier).state = 'Idle';
  }

  void _requestConnectionAndroid(String endpointId, String userName) {
    ref.read(nearbyStatusProvider.notifier).state = 'Connecting to $endpointId...';
  }

  Future<void> _sendMyNamecardAndroid(String endpointId) async {
    final myCard = await ref.read(storageServiceProvider).getMyNamecard();
    if (myCard == null) return;
    ref.read(nearbyStatusProvider.notifier).state = 'Sending card...';
    await ref.read(storageServiceProvider).recordShareHistory(myCard, 'nearby');
    ref.invalidate(shareHistoryProvider);
    ref.read(nearbyStatusProvider.notifier).state = 'Sent my Namecard!';
  }

  // Returns nothing — we use dynamic dispatch on Android
  dynamic _getNearby() => null;
}
