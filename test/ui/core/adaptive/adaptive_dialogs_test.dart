import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/adaptive/app_adaptive_date_picker.dart';
import 'package:rwa_interface/ui/core/adaptive/app_adaptive_dialogs.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('alert uses Material presentation on Android', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => FilledButton(
            onPressed: () => showAppAlert(
              context: context,
              title: 'Confirm',
              message: 'Continue?',
              confirmLabel: 'Yes',
              cancelLabel: 'No',
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('alert and action sheet use Cupertino presentation on iOS', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => Column(
            children: [
              FilledButton(
                onPressed: () => showAppAlert(
                  context: context,
                  title: 'Confirm',
                  message: 'Continue?',
                  confirmLabel: 'Yes',
                  cancelLabel: 'No',
                ),
                child: const Text('Alert'),
              ),
              FilledButton(
                onPressed: () => showAppActionSheet<int>(
                  context: context,
                  actions: const [('First', 1)],
                  cancelLabel: 'Cancel',
                ),
                child: const Text('Sheet'),
              ),
            ],
          ),
        ),
        platform: TargetPlatform.iOS,
      ),
    );
    await tester.tap(find.text('Alert'));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sheet'));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoActionSheet), findsOneWidget);
  });

  testWidgets('date picker respects platform presentation', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => FilledButton(
            onPressed: () => showAppDatePicker(
              context: context,
              initialDate: DateTime(2026, 9, 2),
              firstDate: DateTime(2026),
              lastDate: DateTime(2027),
              confirmLabel: 'Done',
            ),
            child: const Text('Date'),
          ),
        ),
        platform: TargetPlatform.iOS,
      ),
    );
    await tester.tap(find.text('Date'));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoDatePicker), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
  });
}
