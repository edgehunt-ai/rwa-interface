import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/feedback/failure_state.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    final brightness = mode == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light;
    final colors = AppTheme.tokensFor(brightness);

    testWidgets('$mode retry button labels with the inverse text token', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          FailureState(description: 'Server unavailable', onRetry: () {}),
          themeMode: mode,
        ),
      );
      await tester.pumpAndSettle();

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      final style = button.style!;

      expect(
        style.backgroundColor!.resolve(<WidgetState>{}),
        colors.actionPrimary,
      );
      expect(
        style.foregroundColor!.resolve(<WidgetState>{}),
        colors.textInverse,
      );
      // The label is painted with the resolved foreground, not inherited text.
      expect(
        DefaultTextStyle.of(tester.element(find.text('Retry'))).style.color,
        colors.textInverse,
      );
      expect(
        _contrast(colors.actionPrimary, colors.textInverse),
        greaterThan(4.5),
      );
      // A lost foreground fallback used to leave the label on `textPrimary`,
      // which is unreadable on the primary button in the dark appearance.
      expect(colors.textInverse, isNot(colors.textPrimary));
    });
  }

  testWidgets('dark retry button keeps its label while retrying', (
    tester,
  ) async {
    final colors = AppTheme.tokensFor(Brightness.dark);
    final pending = Completer<void>();

    await tester.pumpWidget(
      buildTestApp(
        FailureState(
          description: 'Server unavailable',
          onRetry: () => pending.future,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Retry'));
    await tester.pump();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    final style = button.style!;
    expect(button.onPressed, isNull);
    expect(
      style.backgroundColor!.resolve(<WidgetState>{WidgetState.disabled}),
      colors.actionPrimary.withValues(alpha: 0.7),
    );
    expect(
      style.foregroundColor!.resolve(<WidgetState>{WidgetState.disabled}),
      colors.textInverse,
    );

    final spinner = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );
    expect(spinner.color, colors.textInverse);

    pending.complete();
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
  });
}

/// WCAG contrast ratio between two opaque colours.
double _contrast(Color a, Color b) {
  final lighter = [a.computeLuminance(), b.computeLuminance()]..sort();
  return (lighter.last + 0.05) / (lighter.first + 0.05);
}
