import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/views/transfer_screen.dart';

void main() {
  testWidgets('matches the transfer design structure and interactions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 958);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const TransferScreen()),
    );

    expect(find.text('USDT'), findsOneWidget);
    expect(find.text('USDC'), findsNWidgets(2));
    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('Add token'), findsOneWidget);
    expect(find.text('Slippage'), findsOneWidget);
    expect(find.text('Your cross position risk will decrease'), findsOneWidget);
    expect(find.text('TSLA Liq. Price'), findsOneWidget);
    expect(find.text('Sign & Transfer'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
    await tester.pump();
    expect(find.text('TSLA Liq. Price'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pump();
    expect(find.text('Your cross position risk will increase'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
