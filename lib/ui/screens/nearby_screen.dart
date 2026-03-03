import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namecard/providers/storage_provider.dart';

// nearby_connections is Android-only. All calls are guarded with Platform.isAndroid.
// On iOS, this screen shows a "not supported" message instead.
class NearbyScreen extends ConsumerStatefulWidget {
  const NearbyScreen({super.key});

  @override
  ConsumerState<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends ConsumerState<NearbyScreen> {
  bool _isAdvertising = false;
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _checkPermissionsAndroid();
    }
  }

  Future<void> _checkPermissionsAndroid() async {
    // Permissions for Nearby Connections on Android are declared in AndroidManifest.xml.
    // Runtime permission requests for Location and Bluetooth are handled automatically
    // by the nearby_connections library when startAdvertising/startDiscovery is called.
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      _stopAll();
    }
    super.dispose();
  }

  void _stopAll() {
    // Only accessed on Android
    ref.read(nearbyServiceProvider).stopAll();
  }

  void _toggleAdvertise(String userName) async {
    if (!Platform.isAndroid) return;
    final service = ref.read(nearbyServiceProvider);
    if (_isAdvertising) {
      await service.stopAdvertising();
      setState(() => _isAdvertising = false);
      ref.read(nearbyStatusProvider.notifier).state = 'Stopped advertising';
    } else {
      await service.startAdvertising(userName);
      setState(() => _isAdvertising = true);
    }
  }

  void _toggleDiscover() async {
    if (!Platform.isAndroid) return;
    final service = ref.read(nearbyServiceProvider);
    if (_isDiscovering) {
      await service.stopDiscovery();
      setState(() => _isDiscovering = false);
      ref.read(nearbyStatusProvider.notifier).state = 'Stopped discovering';
    } else {
      await service.startDiscovery();
      setState(() => _isDiscovering = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // The Nearby Connections feature is Android-only.
    if (!Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nearby Radar')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.radar, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nearby Radar is Android only',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'The Google Nearby Connections API is not available on iOS.\nUse QR Code sharing instead.',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final status = ref.watch(nearbyStatusProvider);
    final devices = ref.watch(discoveredDevicesProvider);
    final myCardAsync = ref.watch(myNamecardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Radar')),
      body: myCardAsync.when(
        data: (myCard) {
          final userName = myCard?.name ?? 'Unknown Device';
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Row(
                  children: [
                    const Icon(Icons.info),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Status: $status',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _toggleAdvertise(userName),
                      icon: Icon(_isAdvertising ? Icons.stop : Icons.sensors),
                      label: Text(_isAdvertising ? 'Stop Advertising' : 'Advertise Card'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isAdvertising ? Colors.red.shade100 : null,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _toggleDiscover,
                      icon: Icon(_isDiscovering ? Icons.stop : Icons.radar),
                      label: Text(_isDiscovering ? 'Stop Discovering' : 'Discover Devices'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isDiscovering ? Colors.red.shade100 : null,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: devices.isEmpty
                    ? const Center(
                        child: Text(
                          'No devices found.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final endpointId = devices.keys.elementAt(index);
                          final name = devices.values.elementAt(index);

                          return ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.smartphone)),
                            title: Text(name),
                            subtitle: Text('ID: $endpointId'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.link, color: Colors.blue),
                                  tooltip: 'Connect',
                                  onPressed: () {
                                    ref
                                        .read(nearbyServiceProvider)
                                        .requestConnection(endpointId, userName);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send, color: Colors.green),
                                  tooltip: 'Send My Card',
                                  onPressed: () {
                                    ref
                                        .read(nearbyServiceProvider)
                                        .sendMyNamecard(endpointId);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
