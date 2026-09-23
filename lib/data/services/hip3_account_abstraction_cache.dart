import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/hip3_account_abstraction.dart';

final class Hip3AccountAbstractionCache {
  const Hip3AccountAbstractionCache({
    this.resolvePreferences = SharedPreferences.getInstance,
  });

  final Future<SharedPreferences> Function() resolvePreferences;

  Future<Hip3AccountAbstractionStatus?> read({
    required String accountId,
    required String ownerAddress,
  }) async {
    final prefs = await resolvePreferences();
    final prefix = _prefix(accountId, ownerAddress);
    if (prefs.getBool('$prefix/unified') != true) return null;
    final cachedOwner = prefs.getString('$prefix/owner');
    if (cachedOwner != _normalize(ownerAddress)) return null;
    return Hip3AccountAbstractionStatus(
      ownerAddress: cachedOwner!,
      currentMode: Hip3AccountAbstractionMode.unifiedAccount,
      switchAvailable: false,
    );
  }

  Future<void> write({
    required String accountId,
    required Hip3AccountAbstractionStatus status,
  }) async {
    final prefs = await resolvePreferences();
    final prefix = _prefix(accountId, status.ownerAddress);
    if (!status.isUnifiedAccount) {
      await prefs.remove('$prefix/unified');
      await prefs.remove('$prefix/owner');
      return;
    }
    await prefs.setBool('$prefix/unified', true);
    await prefs.setString('$prefix/owner', _normalize(status.ownerAddress));
  }

  String _prefix(String accountId, String ownerAddress) =>
      'hip3.account-abstraction.${Uri.encodeComponent(accountId)}.${_normalize(ownerAddress)}';

  String _normalize(String value) => value.trim().toLowerCase();
}
