import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/financial_obligation.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/features/funding/providers/financial_obligation_providers.dart';
import 'package:nobell/ui/features/funding/views/funds_obligations_screen.dart';

void main() {
  testWidgets('native recovery links only exact wallet execution references', (tester) async {
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('native-reference', relatedReferences: const [
        FinancialBusinessReference(type: 'wallet_action_execution', id: 'execution-1'),
        FinancialBusinessReference(type: 'wallet_action_execution', id: 'execution-1'),
        FinancialBusinessReference(type: 'unknown_execution', id: 'do-not-route'),
      ]),
      onObserve: () {},
    )));
    expect(find.byKey(const ValueKey('native-recovery-execution-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('native-recovery-do-not-route')), findsNothing);
    expect(find.byKey(const ValueKey('native-recovery-order-1')), findsNothing);
  });

  testWidgets('hashless hold shows exact amount, unknown fee and support ownership', (tester) async {
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('hashless-hold'), onObserve: () {},
    )));
    expect(find.text('hashless-hold'), findsOneWidget);
    expect(find.text('Reserved: 2.500970232991173395 USDT'), findsOneWidget);
    expect(find.text('Raw amount: 2500970232991173395'), findsOneWidget);
    expect(find.text('Actual fees: Unknown amount · fee_not_observed'), findsOneWidget);
    expect(find.textContaining('support-case-1'), findsWidgets);
    expect(find.text('Technical status: manual_review'), findsOneWidget);
    expect(find.text('Economic status: Reserved'), findsOneWidget);
    expect(find.textContaining('Completed'), findsNothing);
  });

  testWidgets('unknown identity renders raw funds without inventing decimals', (tester) async {
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('orphan', unknownAsset: true), onObserve: () {},
    )));
    expect(find.text('Unknown asset: historical_identity_missing'), findsOneWidget);
    expect(find.text('Reserved: Raw amount: 2500970232991173395'), findsOneWidget);
    expect(find.textContaining('2.500970232991173395 USDT'), findsNothing);
    expect(find.text('legacy-asset-reference'), findsOneWidget);
  });

  testWidgets('refund pending and partial refund never render settled', (tester) async {
    for (final status in ['refundPending', 'partiallyRefunded']) {
      await tester.pumpWidget(_app(FinancialObligationCard(
        key: ValueKey(status),
        obligation: _obligation(status, economicStatus: status), onObserve: () {},
      )));
      expect(find.text('Economic status: ${status == 'refundPending' ? 'Refund pending' : 'Partially refunded'}'), findsOneWidget);
      expect(find.text('Economic status: Settled'), findsNothing);
      expect(find.text('Unresolved'), findsOneWidget);
    }
  });

  testWidgets('actions never invent retry signing or release permission', (tester) async {
    var observations = 0;
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('review'), onObserve: () => observations++,
    )));
    await tester.ensureVisible(find.widgetWithText(TextButton, 'Refresh evidence'));
    await tester.tap(find.widgetWithText(TextButton, 'Refresh evidence'));
    expect(observations, 1);
    expect(find.widgetWithText(TextButton, 'Retry'), findsNothing);
    expect(find.widgetWithText(TextButton, 'Refund'), findsNothing);
    expect(find.widgetWithText(TextButton, 'Release'), findsNothing);
  });

  testWidgets('all obligation pages remain reachable independently of activity', (tester) async {
    final requested = <String?>[];
    await tester.pumpWidget(ProviderScope(
      overrides: [financialObligationsProvider.overrideWith((ref, query) async {
        requested.add(query.cursor);
        return DomainPage(
          items: [_obligation(query.cursor == null ? 'first-hold' : 'second-hold')],
          nextCursor: query.cursor == null ? 'next-page' : null,
          hasMore: query.cursor == null,
        );
      })],
      child: _app(const FundsObligationsScreen(), scaffold: false),
    ));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Load more').hitTestable(), 300,
        scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('Load more'));
    await tester.pumpAndSettle();
    expect(requested, [null, 'next-page']);
    await tester.scrollUntilVisible(find.text('second-hold').hitTestable(), 300,
        scrollable: find.byType(Scrollable).first);
    expect(find.text('second-hold'), findsOneWidget);
  });

  testWidgets('query failure does not claim funds are settled', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [financialObligationsProvider.overrideWith((ref, query) async {
        throw StateError('unavailable');
      })],
      child: _app(const FundsObligationsScreen(), scaffold: false),
    ));
    await tester.pumpAndSettle();
    expect(find.textContaining('This does not mean your funds are settled.'), findsOneWidget);
    expect(find.text('No unresolved funds reported'), findsNothing);
  });

  testWidgets('refund evidence keeps full transaction and event coordinates', (tester) async {
    final hash = '0x${List.filled(64, 'a').join()}';
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('refund-evidence', evidence: [
        FinancialSettlementEvidence(
          id: 'immutable-refund-event', kind: 'refund', status: 'finalized',
          reference: const FinancialBusinessReference(type: 'cross_chain_transfer', id: 'transfer-1'),
          observedAt: DateTime.utc(2026, 10, 19, 11),
          chainId: 56, txHash: hash, logIndex: 7,
        ),
      ]),
      onObserve: () {},
    )));
    expect(find.textContaining('tx_hash: $hash'), findsOneWidget);
    expect(find.textContaining('log_index: 7'), findsOneWidget);
    expect(find.textContaining('2026-10-19T11:00:00.000Z'), findsOneWidget);
    expect(find.textContaining('immutable-refund-event'), findsOneWidget);
  });

  testWidgets('including resolved changes the collection query', (tester) async {
    final filters = <bool>[];
    await tester.pumpWidget(ProviderScope(
      overrides: [financialObligationsProvider.overrideWith((ref, query) async {
        filters.add(query.includeResolved);
        return const DomainPage<FinancialObligation>(items: []);
      })],
      child: _app(const FundsObligationsScreen(), scaffold: false),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(filters, [false, true]);
  });

  testWidgets('same-receipt net debit and actual refund do not hide remainder', (tester) async {
    await tester.pumpWidget(_app(FinancialObligationCard(
      obligation: _obligation('same-receipt-return',
        economicStatus: 'partiallyRefunded',
        buckets: {
          'source_debited': FinancialObligationAmount.known('2000000000000000000'),
          'refunded': FinancialObligationAmount.known('98000000000000000000'),
          'outstanding': FinancialObligationAmount.known('2000000000000000000'),
        },
      ),
      onObserve: () {},
    )));
    expect(find.text('Net source debit: 2.000000000000000000 USDT'), findsOneWidget);
    expect(find.text('Refunded: 98.000000000000000000 USDT'), findsOneWidget);
    expect(find.text('Unresolved: 2.000000000000000000 USDT'), findsOneWidget);
    expect(find.text('Unresolved'), findsOneWidget);
    expect(find.text('Economic status: Partially refunded'), findsOneWidget);
    expect(find.text('Economic status: Settled'), findsNothing);
  });
}

Widget _app(Widget child, {bool scaffold = true}) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: scaffold ? Scaffold(body: SingleChildScrollView(child: child)) : child,
);

FinancialObligation _obligation(String id, {
  bool unknownAsset = false,
  String economicStatus = 'reserved',
  List<FinancialSettlementEvidence> evidence = const [],
  Map<String, FinancialObligationAmount>? buckets,
  List<FinancialBusinessReference> relatedReferences = const [],
}) => FinancialObligation(
  id: id,
  businessReference: const FinancialBusinessReference(type: 'bstocks_order', id: 'order-1'),
  relatedReferences: relatedReferences,
  economicStatus: economicStatus,
  technicalStatus: 'manual_review',
  unresolved: true,
  reason: 'No final receipt; reservation remains active',
  amounts: [FinancialObligationAmounts(
    asset: unknownAsset
        ? const FinancialObligationAsset(status: 'unknown', unknownReason: 'historical_identity_missing', observedAssetRef: 'legacy-asset-reference')
        : const FinancialObligationAsset(status: 'known', assetId: 'bsc-usdt', namespace: 'eip155', network: 'BSC', chainId: 56, token: 'USDT', tokenDecimals: 18),
    buckets: buckets ?? {
      'reserved': FinancialObligationAmount.known('2500970232991173395'),
      'actual_fee': FinancialObligationAmount.unknown('fee_not_observed'),
    },
  )],
  evidence: evidence,
  responsibility: const FinancialResponsibility(
    queue: 'funds-recovery', owner: 'Funding support', caseId: 'support-case-1',
    escalationStatus: 'escalated', allowedActions: ['observe', 'contactSupport'],
  ),
  createdAt: DateTime.utc(2026, 10, 1),
  updatedAt: DateTime.utc(2026, 10, 19),
);
