import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';

import '../../../helpers/test_app.dart';

void main() {
  tearDown(AppToast.dismiss);

  testWidgets('shows and replaces a top success message', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => FilledButton(
            onPressed: () => AppToast.showSuccess(context, 'Saved'),
            child: const Text('Show success'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show success'));
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(tester.getSize(find.byType(Container).last).width, 313);

    final context = tester.element(find.text('Show success'));
    AppToast.showFailure(context, 'Could not save');
    await tester.pump();

    expect(find.text('Saved'), findsNothing);
    expect(find.text('Could not save'), findsOneWidget);
  });

  testWidgets('dismisses automatically after three seconds', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        Builder(
          builder: (context) => FilledButton(
            onPressed: () => AppToast.showFailure(context, 'Request failed'),
            child: const Text('Show failure'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show failure'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();

    expect(find.text('Request failed'), findsNothing);
  });
}
