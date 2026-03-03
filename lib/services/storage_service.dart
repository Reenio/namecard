import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:namecard/models/namecard.dart';
import 'package:namecard/models/share_history.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  late Isar isar;
  
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NamecardSchema, ShareHistorySchema],
      directory: dir.path,
    );
    await _ensureMyNamecardExists();
  }

  Future<void> _ensureMyNamecardExists() async {
    final myCard = await getMyNamecard();
    if (myCard == null) {
      final newCard = Namecard()
        ..uuid = const Uuid().v4()
        ..name = 'My Name'
        ..isMine = true
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
      
      await isar.writeTxn(() async {
        await isar.namecards.put(newCard);
      });
    }
  }

  Future<Namecard?> getMyNamecard() async {
    return await isar.namecards.filter().isMineEqualTo(true).findFirst();
  }

  Future<void> updateMyNamecard(Namecard updatedCard) async {
    updatedCard.isMine = true;
    updatedCard.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.namecards.put(updatedCard);
    });
  }

  Future<void> saveReceivedNamecard(Namecard card, String method) async {
    card.isMine = false;
    card.createdAt = card.createdAt ?? DateTime.now();
    card.updatedAt = DateTime.now();
    
    await isar.writeTxn(() async {
      final cardId = await isar.namecards.put(card);
      final history = ShareHistory()
        ..exchangeType = ExchangeType.received
        ..exchangedAt = DateTime.now()
        ..method = method;
      history.namecard.value = card;
      
      await isar.shareHistorys.put(history);
      await history.namecard.save();
    });
  }
  
  Future<void> recordShareHistory(Namecard myCard, String method) async {
    await isar.writeTxn(() async {
       final history = ShareHistory()
        ..exchangeType = ExchangeType.shared
        ..exchangedAt = DateTime.now()
        ..method = method;
      history.namecard.value = myCard;
      await isar.shareHistorys.put(history);
      await history.namecard.save();
    });
  }

  Future<List<Namecard>> getReceivedNamecards() async {
    return await isar.namecards.filter().isMineEqualTo(false).findAll();
  }

  Future<List<ShareHistory>> getHistory() async {
    return await isar.shareHistorys.where().sortByExchangedAtDesc().findAll();
  }
}
