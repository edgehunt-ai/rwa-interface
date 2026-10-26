import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/widgets/app_filter_menu.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('filter selection stays readable in ${mode.name} mode', (
      tester,
    ) async {
      String? selected;
      final changes = <String?>[];
      await tester.pumpWidget(
        buildTestApp(
          StatefulBuilder(
            builder: (context, setState) => Align(
              alignment: Alignment.topLeft,
              child: AppFilterMenu<String?>(
                value: selected,
                label: selected ?? '全部网络',
                options: const [
                  AppFilterOption(value: null, label: '全部网络'),
                  AppFilterOption(value: 'Arbitrum', label: 'Arbitrum'),
                ],
                onChanged: (value) {
                  changes.add(value);
                  setState(() => selected = value);
                },
              ),
            ),
          ),
          themeMode: mode,
        ),
      );

      Future<void> openAndCheck() async {
        await tester.tap(find.byType(AppFilterMenu<String?>));
        await tester.pumpAndSettle();
        final items = find.byType(PopupMenuItem<int>);
        expect(items, findsNWidgets(2));
        for (var index = 0; index < 2; index++) {
          final item = items.at(index);
          final richText = tester.widget<RichText>(
            find.descendant(of: item, matching: find.byType(RichText)),
          );
          final foreground = richText.text.style!.color!;
          final decoration =
              tester
                      .widget<Container>(
                        find.descendant(
                          of: item,
                          matching: find.byType(Container),
                        ),
                      )
                      .decoration!
                  as BoxDecoration;
          final background =
              decoration.color ?? Theme.of(tester.element(item)).canvasColor;
          final light = math.max(
            foreground.computeLuminance(),
            background.computeLuminance(),
          );
          final dark = math.min(
            foreground.computeLuminance(),
            background.computeLuminance(),
          );
          expect(
            (light + 0.05) / (dark + 0.05),
            greaterThanOrEqualTo(4.5),
            reason: '${richText.text.toPlainText()} in ${mode.name} mode',
          );
        }
      }

      await openAndCheck();
      await tester.tap(find.widgetWithText(PopupMenuItem<int>, 'Arbitrum'));
      await tester.pumpAndSettle();
      expect(selected, 'Arbitrum');
      await openAndCheck();
      await tester.tap(find.widgetWithText(PopupMenuItem<int>, '全部网络'));
      await tester.pumpAndSettle();
      expect(selected, isNull);
      expect(changes, ['Arbitrum', null]);
      expect(find.byType(PopupMenuItem<int>), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
