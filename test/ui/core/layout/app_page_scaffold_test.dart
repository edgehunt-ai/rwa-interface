import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/layout/app_page_scaffold.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('keeps long scrollable content usable at 200% text', (
    tester,
  ) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      buildTestApp(
        AppPageScaffold(
          scrollable: true,
          body: Text(
            List.filled(20, 'A deliberately long localized message.').join(' '),
          ),
          bottomAction: const FilledButton(
            onPressed: null,
            child: Text('Continue'),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Continue'), findsOneWidget);
  });
}
