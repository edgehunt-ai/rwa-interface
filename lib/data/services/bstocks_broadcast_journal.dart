import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/order.dart';

/// Stores only public broadcast evidence, never private keys or signatures.
/// A pending marker is written before the wallet call: process loss or an SDK
/// error cannot be interpreted as permission to broadcast again.
final class BstocksBroadcastJournal {
  /// In-memory storage for focused tests and non-persistent callers.
  BstocksBroadcastJournal() : _preferences = null;

  BstocksBroadcastJournal.persistent()
    : _preferences = SharedPreferences.getInstance;

  final Future<SharedPreferences> Function()? _preferences;
  final _records = <String, String>{};
  final _inFlight = <String, Future<String>>{};

  String _key(BstocksOrderAction action) =>
      'bstocks.broadcast.${action.chainId}.${action.from.toLowerCase()}.'
      '${action.orderId}.${action.actionId}';

  Future<String?> transactionHash(BstocksOrderAction action) async {
    final key = _key(action);
    final prefs = await _preferences?.call();
    final previous = _records[key] ?? prefs?.getString(key);
    if (previous == '') {
      throw const UnknownFailure(
        userAction: 'Wallet broadcast outcome is uncertain; track the original action before retrying',
      );
    }
    return previous;
  }

  Future<String> broadcast(
    BstocksOrderAction action,
    Future<String> Function() send,
  ) {
    final key = _key(action);
    if (_inFlight[key] case final active?) return active;
    final request = _broadcast(key, send);
    _inFlight[key] = request;
    return request.whenComplete(() => _inFlight.remove(key));
  }

  Future<String> _broadcast(String key, Future<String> Function() send) async {
    final prefs = await _preferences?.call();
    final previous = _records[key] ?? prefs?.getString(key);
    if (previous != null) {
      if (previous.isNotEmpty) return previous;
      throw const UnknownFailure(
        userAction: 'Wallet broadcast outcome is uncertain; track the original action before retrying',
      );
    }
    _records[key] = '';
    if (prefs != null && !await prefs.setString(key, '')) {
      _records.remove(key);
      throw const UnknownFailure(
        userAction: 'Cannot save wallet broadcast evidence',
      );
    }
    String hash;
    try {
      hash = await send();
    } on CancelledFailure {
      // Explicit rejection is known to precede broadcast.
      if (prefs != null && !await prefs.remove(key)) rethrow;
      _records.remove(key);
      rethrow;
    } on WalletTransactionNotBroadcastFailure {
      if (prefs != null && !await prefs.remove(key)) rethrow;
      _records.remove(key);
      rethrow;
    }
    _records[key] = hash;
    if (prefs != null && !await prefs.setString(key, hash)) {
      throw const UnknownFailure(
        userAction: 'Cannot save wallet transaction hash',
      );
    }
    return hash;
  }
}
