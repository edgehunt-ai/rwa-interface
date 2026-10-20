import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/order.dart';

/// Reads historical client broadcast evidence without granting send authority.
/// An old pending marker remains uncertain and must never permit a new relay.
final class BstocksBroadcastJournal {
  /// No historical device evidence for focused tests and non-persistent callers.
  BstocksBroadcastJournal() : _preferences = null;

  BstocksBroadcastJournal.persistent()
    : _preferences = SharedPreferences.getInstance;

  final Future<SharedPreferences> Function()? _preferences;

  String _key(BstocksOrderAction action) =>
      'bstocks.broadcast.${action.chainId}.${action.from.toLowerCase()}.'
      '${action.orderId}.${action.actionId}';

  Future<String?> transactionHash(BstocksOrderAction action) async {
    final key = _key(action);
    final prefs = await _preferences?.call();
    final previous = prefs?.getString(key);
    if (previous == '') {
      throw const UnknownFailure(
        userAction: 'Wallet broadcast outcome is uncertain; track the original action before retrying',
      );
    }
    return previous;
  }

}
