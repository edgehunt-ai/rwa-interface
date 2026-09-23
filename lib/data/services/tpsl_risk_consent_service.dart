import 'package:shared_preferences/shared_preferences.dart';

final class TpSlRiskConsentService {
  static const key = 'hip3_tpsl_risk_consent_v1';

  const TpSlRiskConsentService({SharedPreferencesResolver? resolvePreferences})
    : _resolvePreferences = resolvePreferences ?? SharedPreferences.getInstance;

  final SharedPreferencesResolver _resolvePreferences;

  Future<bool> read() async {
    final preferences = await _resolvePreferences();
    return preferences.getBool(key) ?? false;
  }

  Future<void> record() async {
    final preferences = await _resolvePreferences();
    await preferences.setBool(key, true);
  }
}

typedef SharedPreferencesResolver = Future<SharedPreferences> Function();
