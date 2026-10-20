import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/features/funding/providers/native_execution_recovery_providers.dart';
import 'package:nobell/ui/features/funding/views/native_execution_recovery_screen.dart';

import '../../../../helpers/funding_execution_fixture.dart';

void main() {
  testWidgets(
    'original and ambiguous cancellation remain separately visible without success',
    (tester) async {
      final original = fundingExecution(includeAuthorization: false);
      final execution = WalletActionExecution(
        executionId: original.executionId,
        resourceId: original.resourceId,
        chainId: original.chainId,
        walletAddress: original.walletAddress,
        mode: original.mode,
        status: WalletActionExecutionState.ambiguous,
        gasPayment: original.gasPayment,
        transaction: original.transaction,
        executionProvider: 'privy_native',
        nativeNonce: '10',
        nativeDeliveryState: 'dispatching',
        txHash: '0x${'a' * 64}',
        nativeCancellation: NativeCancellation(
          cancellationId: 'cancel-1',
          nonce: '10',
          to: fundingTarget,
          status: 'ambiguous',
          txHash: '0x${'b' * 64}',
        ),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            walletExecutionEvidenceProvider('execution-1')
                .overrideWith((ref) async => execution),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: const NativeExecutionRecoveryScreen(
              executionId: 'execution-1',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('0x${'a' * 64}'), findsOneWidget);
      expect(find.textContaining('0x${'b' * 64}'), findsOneWidget);
      expect(
        find.textContaining('not a refund or business success'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('native-recovery-prepare')), findsNothing);
      expect(find.byKey(const Key('native-recovery-authorize')), findsNothing);
    },
  );
}
