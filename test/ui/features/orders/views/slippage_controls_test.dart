import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/orders/views/slippage_controls.dart';

import '../../../../helpers/display_config.dart';
import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('slippage sheet matches presets layout and confirms selection', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    double? result;
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => Center(
            child: FilledButton(
              key: const Key('open-slippage'),
              onPressed: () async {
                result = await showSlippageSheet(
                  context: context,
                  initialValue: 0.12,
                  inputKey: const Key('test-slippage-input'),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('open-slippage')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('slippage-back')), findsOneWidget);
    expect(find.text('Slippage tolerance'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('slippage-sheet'))),
      const Size(393, 282),
    );
    expect(
      tester.getSize(find.byKey(const Key('slippage-input-card'))),
      const Size(353, 66),
    );
    expect(
      tester.getSize(find.byKey(const Key('slippage-cancel'))),
      const Size(160, 48),
    );
    expect(
      tester.getSize(find.byKey(const Key('slippage-confirm'))),
      const Size(181, 48),
    );
    expect(
      tester.getRect(find.byKey(const Key('slippage-confirm'))).left -
          tester.getRect(find.byKey(const Key('slippage-cancel'))).right,
      12,
    );
    expect(tester.testTextInput.hasAnyClients, isFalse);

    final preset = find.byKey(const Key('slippage-preset-0.5'));
    expect(tester.getSize(preset).height, 38);
    await tester.tap(preset);
    await tester.pump();

    expect(tester.widget<ChoiceChip>(preset).selected, isTrue);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('test-slippage-input')))
          .controller!
          .text,
      '0.5',
    );
    expect(
      tester.widget<ChoiceChip>(preset).selectedColor,
      AppTheme.light.extension<AppRwaColors>()!.primaryAction,
    );

    await tester.tap(find.byKey(const Key('slippage-confirm')));
    await tester.pumpAndSettle();

    expect(result, 0.5);
  });

  testWidgets('manual preset value updates selection and invalid input stays', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => SlippageSheet(
            initialValue: 0.12,
            inputKey: const Key('test-slippage-input'),
          ),
        ),
      ),
    );

    final input = find.byKey(const Key('test-slippage-input'));
    await tester.enterText(input, '1');
    await tester.pump();
    expect(
      tester
          .widget<ChoiceChip>(find.byKey(const Key('slippage-preset-1.0')))
          .selected,
      isTrue,
    );

    await tester.enterText(input, '100.01');
    await tester.tap(find.byKey(const Key('slippage-confirm')));
    await tester.pump();

    expect(find.byKey(const Key('slippage-error')), findsOneWidget);
    expect(
      find.text('Enter a slippage percentage from 0% to 100%.'),
      findsOneWidget,
    );
  });
}
