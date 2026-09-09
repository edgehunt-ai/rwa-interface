import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/features/markets/views/market_screen.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('renders the closed-market status treatment', (tester) async {
    await tester.pumpWidget(
      buildTestApp(MarketStatusSheet(isOpen: false, onDismiss: () {})),
    );

    expect(find.text('US markets are closed. Trading isn’t.'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
  });

  testWidgets('renders the open-market status treatment', (tester) async {
    await tester.pumpWidget(
      buildTestApp(MarketStatusSheet(isOpen: true, onDismiss: () {})),
    );

    expect(find.text('US markets are open. So are we.'), findsOneWidget);
    expect(find.textContaining('currently open'), findsOneWidget);
  });

  testWidgets('market ranking tabs remain usable at 200% text scale', (
    tester,
  ) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      buildTestApp(MarketRankingTabs(active: 'Favorites', onSelected: (_) {})),
    );

    expect(tester.takeException(), isNull);
    await tester.drag(find.text('Favorites'), const Offset(-160, 0));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
