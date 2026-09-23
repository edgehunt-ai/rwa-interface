import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/tpsl_risk_consent_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('persists TP/SL risk consent locally', () async {
    SharedPreferences.setMockInitialValues({});
    final service = const TpSlRiskConsentService();

    expect(await service.read(), isFalse);
    await service.record();
    expect(await service.read(), isTrue);
  });
}
