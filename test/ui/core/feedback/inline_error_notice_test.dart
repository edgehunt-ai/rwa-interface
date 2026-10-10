import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/feedback/inline_error_notice.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

void main() {
  testWidgets('uses semantic red text and translucent red background', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: InlineErrorNotice(message: 'Something went wrong'),
        ),
      ),
    );

    final semantic = AppTheme.light.extension<AppSemanticColors>()!;
    final notice = tester.widget<Container>(
      find.descendant(
        of: find.byType(InlineErrorNotice),
        matching: find.byType(Container),
      ),
    );
    final decoration = notice.decoration! as BoxDecoration;
    expect(decoration.color, semantic.loss.withValues(alpha: 0.1));
    expect(
      tester.widget<Text>(find.text('Something went wrong')).style?.color,
      semantic.loss,
    );
  });
}
