import 'package:isar/isar.dart';
import 'package:namecard/models/namecard.dart';

part 'share_history.g.dart';

enum ExchangeType {
  shared, // I shared my card with them
  received, // I received their card
}

@collection
class ShareHistory {
  Id id = Isar.autoIncrement;

  @enumerated
  late ExchangeType exchangeType;

  late DateTime exchangedAt;

  // The method of exchange (e.g. "bluetooth", "qr")
  late String method;

  // A link to the namecard we received or shared (if available)
  final namecard = IsarLink<Namecard>();
}
