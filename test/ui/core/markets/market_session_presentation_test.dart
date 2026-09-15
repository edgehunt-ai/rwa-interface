import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/ui/core/markets/market_session_presentation.dart';

import '../../../helpers/test_app.dart';

void main() {
  String badgeText(WidgetTester tester) {
    final text = tester.widget<Text>(find.byType(Text));
    return text.data ?? text.textSpan!.toPlainText();
  }

  MarketHours hours(MarketSessionKind kind, Duration untilNextSession) =>
      MarketHours(
        timezone: 'America/New_York',
        current: kind,
        nextTransitionAt: DateTime.now().add(untilNextSession),
      );

  testWidgets('market session badge counts down to the next session', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MarketSessionBadge(
          hours: hours(
            MarketSessionKind.overnight,
            const Duration(hours: 4, minutes: 30, seconds: 30),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey('market-status-icon-overnight')),
      findsOneWidget,
    );
    expect(badgeText(tester), 'Overnight 04:30');
    final decoration =
        tester.widget<Container>(find.byType(Container).first).decoration
            as BoxDecoration;
    expect(decoration.color, const Color(0xFF2690E6).withValues(alpha: .1));
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('market session badge tracks the session that is open now', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MarketSessionBadge(
          hours: hours(
            MarketSessionKind.regular,
            const Duration(hours: 2, seconds: 30),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey('market-status-icon-regular')),
      findsOneWidget,
    );
    expect(badgeText(tester), 'Regular Market 02:00');
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('market session badge falls back when hours are unavailable', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(const MarketSessionBadge(hours: null)),
    );

    expect(badgeText(tester), 'US Market');
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('compact market session badge uses the navigation-bar pill', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MarketSessionBadge(
          compact: true,
          hours: hours(MarketSessionKind.overnight, const Duration(hours: 1)),
        ),
      ),
    );

    final pill = tester.widget<Container>(find.byType(Container).first);
    expect(
      (pill.decoration! as BoxDecoration).borderRadius,
      BorderRadius.circular(8),
    );
    expect(
      pill.padding,
      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
