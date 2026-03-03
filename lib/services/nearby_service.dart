import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:namecard/models/namecard.dart';
import 'package:namecard/providers/storage_provider.dart';

// Provides the NearbyService
final nearbyServiceProvider = Provider<NearbyService>((ref) {
  return NearbyService(ref);
});

// A provider to expose the list of discovered devices
final discoveredDevicesProvider = StateProvider<Map<String, String>>((ref) => {});

// Status of the nearby connection process
final nearbyStatusProvider = StateProvider<String>((ref) => 'Idle');

class NearbyService {
  final ProviderRef ref;
  final Strategy strategy = Strategy.P2P_STAR; // Best for 1-to-N or 1-to-1 high bandwidth

  NearbyService(this.ref);

  Future<void> startAdvertising(String userName) async {
    try {
      ref.read(nearbyStatusProvider.notifier).state = 'Advertising...';
      bool a = await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: _onConnectionInit,
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) {
            ref.read(nearbyStatusProvider.notifier).state = 'Connected to $id';
          } else {
            ref.read(nearbyStatusProvider.notifier).state = 'Connection failed: $status';
          }
        },
        onDisconnected: (id) {
          ref.read(nearbyStatusProvider.notifier).state = 'Disconnected from $id';
        },
      );
      if (!a) ref.read(nearbyStatusProvider.notifier).state = 'Failed to advertise';
    } catch (e) {
      ref.read(nearbyStatusProvider.notifier).state = 'Error advertising: $e';
    }
  }

  Future<void> startDiscovery() async {
    try {
      ref.read(discoveredDevicesProvider.notifier).state = {};
      ref.read(nearbyStatusProvider.notifier).state = 'Discovering...';
      
      bool a = await Nearby().startDiscovery(
        "namecard", // User's name is not required for discovery
        strategy,
        onEndpointFound: (id, name, serviceId) {
          final devices = Map<String, String>.from(ref.read(discoveredDevicesProvider));
          devices[id] = name;
          ref.read(discoveredDevicesProvider.notifier).state = devices;
        },
        onEndpointLost: (id) {
          final devices = Map<String, String>.from(ref.read(discoveredDevicesProvider));
          devices.remove(id);
          ref.read(discoveredDevicesProvider.notifier).state = devices;
        },
      );
      if (!a) ref.read(nearbyStatusProvider.notifier).state = 'Failed to discover';
    } catch (e) {
      ref.read(nearbyStatusProvider.notifier).state = 'Error discovering: $e';
    }
  }

  Future<void> stopAll() async {
    await Nearby().stopAdvertising();
    await Nearby().stopDiscovery();
    await Nearby().stopAllEndpoints();
    ref.read(discoveredDevicesProvider.notifier).state = {};
    ref.read(nearbyStatusProvider.notifier).state = 'Idle';
  }

  void requestConnection(String endpointId, String userName) {
    Nearby().requestConnection(
      userName,
      endpointId,
      onConnectionInitiated: _onConnectionInit,
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
           ref.read(nearbyStatusProvider.notifier).state = 'Connected to $id';
        } else {
           ref.read(nearbyStatusProvider.notifier).state = 'Connection failed: $status';
        }
      },
      onDisconnected: (id) {
        ref.read(nearbyStatusProvider.notifier).state = 'Disconnected from $id';
      },
    );
  }

  void _onConnectionInit(String id, ConnectionInfo info) async {
    // Auto-accept connection for simplicity in this demo Namecard logic.
    // In production, you might want to show a prompt: "Accept connection from ${info.endpointName}?"
    ref.read(nearbyStatusProvider.notifier).state = 'Connecting to ${info.endpointName}...';
    
    await Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endpointId, payload) {
        if (payload.type == PayloadType.BYTES) {
          _handleReceivedPayload(payload.bytes!);
        }
      },
      onPayloadTransferUpdate: (endpointId, payloadTransferUpdate) {
        // Optional: show progress
        if (payloadTransferUpdate.status == PayloadStatus.SUCCESS) {
          ref.read(nearbyStatusProvider.notifier).state = 'Transfer complete';
        }
      },
    );
  }

  void _handleReceivedPayload(Uint8List bytes) async {
    try {
      final str = String.fromCharCodes(bytes);
      final Map<String, dynamic> data = jsonDecode(str);

      if (data.containsKey('uuid') && data.containsKey('name')) {
        final receivedCard = Namecard.fromJson(data);
        await ref.read(storageServiceProvider).saveReceivedNamecard(receivedCard, 'nearby');
        ref.invalidate(receivedNamecardsProvider);
        ref.invalidate(shareHistoryProvider);
        
        ref.read(nearbyStatusProvider.notifier).state = 'Successfully received namecard from ${receivedCard.name}!';
      }
    } catch (e) {
      ref.read(nearbyStatusProvider.notifier).state = 'Invalid Namecard logic received.';
    }
  }

  Future<void> sendMyNamecard(String endpointId) async {
    final myCard = await ref.read(storageServiceProvider).getMyNamecard();
    if (myCard == null) return;

    final jsonStr = jsonEncode(myCard.toJson());
    final bytes = Uint8List.fromList(jsonStr.codeUnits);

    await Nearby().sendBytesPayload(endpointId, bytes);
    ref.read(nearbyStatusProvider.notifier).state = 'Sent my Namecard!';
    
    // Record history
    await ref.read(storageServiceProvider).recordShareHistory(myCard, 'nearby');
    ref.invalidate(shareHistoryProvider);
  }
}
