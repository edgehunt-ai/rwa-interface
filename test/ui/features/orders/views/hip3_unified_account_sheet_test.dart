import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/ui/core/feedback/inline_error_notice.dart';
import 'package:nobell/ui/features/orders/views/hip3_unified_account_sheet.dart';

import '../../../../helpers/display_config.dart';
import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('shows a shared error notice 8px above the action', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(800, 800));
    await tester.pumpWidget(
      buildTestApp(
        Hip3UnifiedAccountSheet(
          onConfirm: () async => throw const ServerFailure(
            statusCode: 500,
            code: 'conversion_failed',
            message: 'Conversion failed',
          ),
        ),
      ),
    );

    final button = find.byKey(const Key('hip3-unified-account-confirm'));
    await tester.tap(button);
    await tester.pumpAndSettle();

    final notice = find.byKey(const Key('hip3-unified-account-error'));
    expect(notice, findsOneWidget);
    expect(find.byType(InlineErrorNotice), findsOneWidget);
    expect(tester.getTopLeft(button).dy - tester.getBottomLeft(notice).dy, 8);
  });
}
