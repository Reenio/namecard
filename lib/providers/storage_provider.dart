import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namecard/services/storage_service.dart';
import 'package:namecard/models/namecard.dart';
import 'package:namecard/models/share_history.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('storageServiceProvider must be overridden in ProviderScope');
});

final myNamecardProvider = FutureProvider<Namecard?>((ref) async {
  final storage = ref.watch(storageServiceProvider);
  return await storage.getMyNamecard();
});

final receivedNamecardsProvider = FutureProvider<List<Namecard>>((ref) async {
  final storage = ref.watch(storageServiceProvider);
  return await storage.getReceivedNamecards();
});

final shareHistoryProvider = FutureProvider<List<ShareHistory>>((ref) async {
  final storage = ref.watch(storageServiceProvider);
  return await storage.getHistory();
});
