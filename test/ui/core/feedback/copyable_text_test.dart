import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/feedback/copyable_text.dart';

import '../../../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('copies complete value when display is shortened', (
    tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map<Object?, Object?>)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    const value = '0x1234567890abcdef1234567890abcdef';
    await tester.pumpWidget(
      buildTestApp(const CopyableText(value: value, semanticLabel: 'Wallet')),
    );

    await tester.tap(find.byIcon(Icons.copy));
    await tester.pump();
    expect(copied, value);
    expect(find.text('Copied'), findsOneWidget);
  });

  testWidgets('prohibited value has no copy action', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const CopyableText(
          value: 'secret',
          semanticLabel: 'Secret',
          sensitivity: CopySensitivity.prohibited,
        ),
      ),
    );
    expect(find.byIcon(Icons.copy), findsNothing);
    expect(find.text('secret'), findsNothing);
  });
}
