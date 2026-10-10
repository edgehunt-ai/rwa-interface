import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/l10n/generated/app_localizations_zh.dart';
import 'package:nobell/ui/features/funding/hip3_withdrawal_blocker_message.dart';

void main() {
  final l10n = AppLocalizationsZh();

  test('explains insufficient withdrawable balance with the server limit', () {
    final preview = _preview(
      // This is the value exposed by BuiltValue EnumClass.name after the
      // repository maps the generated client enum into the domain model.
      blockers: const ['insufficientWithdrawableBalance'],
      maximumTransferable: '1.5',
    );

    expect(
      hip3WithdrawalBlockerMessage(preview, l10n),
      '可提现余额不足，当前最多可转出 1.5 USDC。',
    );
  });

  test('limits precision in the server limit shown to the user', () {
    final preview = _preview(
      blockers: const ['insufficientWithdrawableBalance'],
      maximumTransferable: '0.0000123456789',
    );

    expect(
      hip3WithdrawalBlockerMessage(preview, l10n),
      '可提现余额不足，当前最多可转出 0.0000123457 USDC。',
    );
  });

  test('keeps unknown future blockers safe and generic', () {
    final preview = _preview(blockers: const ['future_blocker']);

    expect(hip3WithdrawalBlockerMessage(preview, l10n), '此次转账当前被阻止。');
  });

  test('does not show an error when preview has no blockers', () {
    expect(hip3WithdrawalBlockerMessage(_preview(), l10n), isNull);
  });
}

Hip3WithdrawalPreview _preview({
  List<String> blockers = const [],
  String maximumTransferable = '100',
}) => Hip3WithdrawalPreview(
  amount: '2',
  fee: '1',
  minimumReceived: '1',
  rail: 'bridge2',
  destinationAddress: '0x1111111111111111111111111111111111111111',
  chainId: '42161',
  maximumTransferable: maximumTransferable,
  blockers: blockers,
  estimatedArrivalSeconds: 300,
  feeDetails: const [],
  crossLiquidationImpacts: const [],
  riskStatus: 'available',
);
