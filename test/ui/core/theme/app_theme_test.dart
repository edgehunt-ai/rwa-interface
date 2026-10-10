import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

void main() {
  test('semantic colors exist in both appearances', () {
    final light = AppTheme.light.extension<AppSemanticColors>();
    final dark = AppTheme.dark.extension<AppSemanticColors>();

    expect(light, isNotNull);
    expect(dark, isNotNull);
    expect(light!.success, isNot(dark!.success));
  });

  for (final theme in [AppTheme.light, AppTheme.dark]) {
    testWidgets(
      'input placeholders inherit their field text size in ${theme.brightness.name} mode',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: Column(
                children: [
                  TextField(
                    style: theme.textTheme.titleLarge,
                    decoration: const InputDecoration(
                      hintText: 'Large placeholder',
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Default placeholder',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(
          tester.widget<Text>(find.text('Large placeholder')).style?.fontSize,
          theme.textTheme.titleLarge?.fontSize,
        );
        expect(
          tester.widget<Text>(find.text('Default placeholder')).style?.fontSize,
          theme.textTheme.bodyLarge?.fontSize,
        );
      },
    );
  }
}
