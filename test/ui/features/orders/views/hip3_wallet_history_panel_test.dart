import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/hip3_wallet_history.dart';
import 'package:rwa_interface/domain/repositories/hip3_wallet_history_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_wallet_history_panel.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_history_screen.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';

class HistoryRepository implements Hip3WalletHistoryRepository {
  final queries = <Hip3HistoryQuery>[];
  final cursors = <String?>[];
  bool failNext = false;
  bool paginated = false;
  Completer<Hip3HistoryPage<Hip3FundingPayment>>? pending;
  Hip3HistoryPage<T> page<T>(
    Hip3HistoryQuery query,
    List<T> items, {
    String? next,
  }) {
    final archive = query.source == Hip3HistorySource.archive;
    return Hip3HistoryPage(
      snapshotId: 'fixture',
      environment: 'testnet',
      source: query.source,
      observedAt: query.to,
      items: items,
      hasMore: next != null,
      nextCursor: next,
      coverage: Hip3HistoryCoverage(
        status: archive
            ? Hip3HistoryCoverageStatus.archivePartial
            : Hip3HistoryCoverageStatus.sourceExhausted,
        from: query.from,
        to: query.to,
        resumeFrom: archive ? query.from : null,
        retentionGuaranteed: false,
        coveredRanges: [],
        missingRanges: archive
            ? [Hip3HistoryRange(from: query.from, to: query.to)]
            : [],
      ),
      warnings: [],
    );
  }

  @override
  Future<Hip3HistoryPage<Hip3FundingPayment>> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async {
    queries.add(query);
    cursors.add(cursor);
    if (failNext) {
      failNext = false;
      throw StateError('Synthetic provider failure');
    }
    if (pending != null) return pending!.future;
    return page(
      query,
      query.source == Hip3HistorySource.archive
          ? []
          : [
              Hip3FundingPayment(
                id: cursor == null ? 'funding-fixture' : 'funding-second',
                productId: cursor == null ? 'xyz:TSLA' : 'xyz:NVDA',
                amount: DecimalValue('-0.1234567890123456789'),
                settlementAsset: null,
                collateralToken: null,
                signedPositionSize: DecimalValue('-0.099'),
                fundingRate: DecimalValue('0.00001234'),
                transactionHash: 'synthetic-fixture-hash',
                occurredAt: query.to,
              ),
            ],
      next: paginated && cursor == null ? 'next' : null,
    );
  }

  @override
  Future<Hip3HistoryPage<Hip3LiquidationEvent>> liquidations(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async => page(query, [
    Hip3LiquidationEvent(
      id: 'liquidation-fixture',
      providerAccountValue: DecimalValue('123456789.123456789'),
      accountValueScope: 'crossAccount',
      marginMode: 'cross',
      positions: [
        Hip3LiquidationPosition(
          productId: 'xyz:TSLA',
          signedPositionSize: DecimalValue('-0.099'),
        ),
        Hip3LiquidationPosition(
          productId: 'xyz:NVDA',
          signedPositionSize: DecimalValue('0.25'),
        ),
      ],
      excludedNativePositionCount: 1,
      transactionHash: 'synthetic-liquidation-hash',
      occurredAt: query.to,
    ),
  ]);
}

Future<ProviderContainer> mount(
  WidgetTester tester,
  HistoryRepository repository, {
  Hip3HistoryKind kind = Hip3HistoryKind.funding,
  double scale = 1,
  Size size = const Size(375, 812),
  bool dark = false,
  bool fullScreen = false,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer(
    overrides: [
      hip3WalletHistoryRepositoryProvider.overrideWithValue(repository),
      hip3OrdersProvider.overrideWith(
        (ref, cursor) async => const DomainPage(items: []),
      ),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: dark ? AppTheme.dark : AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: RepaintBoundary(
          key: const ValueKey('history-capture'),
          child: fullScreen
              ? const Hip3OrderHistoryScreen()
              : Scaffold(body: Hip3WalletHistoryPanel(kind: kind)),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('failed next page retains records and retries the same cursor', (
    tester,
  ) async {
    final repository = HistoryRepository()..paginated = true;
    await mount(tester, repository);
    repository.failNext = true;
    await tester.ensureVisible(find.text('Load more records'));
    await tester.tap(find.text('Load more records'));
    await tester.pumpAndSettle();
    expect(find.text('xyz:TSLA'), findsOneWidget);
    expect(
      find.text('History could not be loaded. Try again.'),
      findsOneWidget,
    );
    await tester.ensureVisible(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(repository.cursors, [null, 'next', 'next']);
    expect(repository.queries.toSet(), hasLength(1));
    expect(find.text('xyz:TSLA'), findsOneWidget);
    expect(find.text('xyz:NVDA'), findsOneWidget);
    expect(find.text('Load more records'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'history load error retries the same window and refresh preserves it',
    (tester) async {
      final repository = HistoryRepository()..failNext = true;
      await mount(tester, repository);
      final query = repository.queries.single;
      expect(
        find.text('History could not be loaded. Try again.'),
        findsOneWidget,
      );
      expect(find.text('xyz:TSLA'), findsNothing);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(repository.queries, [query, query]);
      expect(find.text('xyz:TSLA'), findsOneWidget);
      await tester.tap(find.text('Refresh history'));
      await tester.pumpAndSettle();
      expect(repository.queries, [query, query, query]);
      expect(
        find.text('History could not be loaded. Try again.'),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'previous window ends one millisecond before current inclusive start',
    (tester) async {
      final repository = HistoryRepository();
      await mount(tester, repository);
      final query = repository.queries.single;
      await tester.tap(find.text('Previous 30 days'));
      await tester.pumpAndSettle();
      final previous = repository.queries.last;
      expect(previous.to, query.from.subtract(const Duration(milliseconds: 1)));
      expect(previous.to.difference(previous.from), const Duration(days: 30));
      expect(previous.source, query.source);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('history entry keeps orders and exposes both wallet histories', (
    tester,
  ) async {
    await mount(tester, HistoryRepository(), fullScreen: true);
    expect(find.text('HIP3 history'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    await tester.tap(find.text('Funding fees'));
    await tester.pumpAndSettle();
    expect(find.text('Settled amount: -0.1234567890123456789'), findsOneWidget);
    await tester.ensureVisible(find.text('Liquidations').first);
    await tester.tap(find.text('Liquidations').first);
    await tester.pumpAndSettle();
    expect(find.text('Cross-margin account value'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('optional component render captures with synthetic fixtures', (
    tester,
  ) async {
    const output = String.fromEnvironment('HIP3_HISTORY_CAPTURE');
    const font = String.fromEnvironment('HIP3_HISTORY_FONT');
    if (output.isEmpty || font.isEmpty) return;
    await tester.runAsync(() async {
      final bytes = ByteData.sublistView(File(font).readAsBytesSync());
      for (final name in ['Roboto', 'Ahem']) {
        await (FontLoader(name)..addFont(Future.value(bytes))).load();
      }
      await (FontLoader('MaterialIcons')..addFont(
            Future.value(
              ByteData.sublistView(
                File('${File(font).parent.path}/MaterialIcons-Regular.otf')
                    .readAsBytesSync(),
              ),
            ),
          ))
          .load();
      await Directory(output).create(recursive: true);
    });
    for (final variant in [
      (
        name: 'phone-light',
        dark: false,
        scale: 1.0,
        size: const Size(375, 812),
      ),
      (
        name: 'phone-dark-large',
        dark: true,
        scale: 1.6,
        size: const Size(375, 812),
      ),
      (
        name: 'tablet-light',
        dark: false,
        scale: 1.0,
        size: const Size(834, 1112),
      ),
    ]) {
      await tester.pumpWidget(const SizedBox());
      await mount(
        tester,
        HistoryRepository(),
        fullScreen: true,
        dark: variant.dark,
        scale: variant.scale,
        size: variant.size,
      );
      await tester.tap(find.text('Funding fees'));
      await tester.pumpAndSettle();
      Future<void> capture(String state) async {
        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find.byKey(const ValueKey('history-capture')),
        );
        await tester.runAsync(() async {
          final image = await boundary.toImage();
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await File('$output/${variant.name}-$state.png')
              .writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }

      await capture('funding');
      await tester.ensureVisible(find.text('Liquidations').first);
      await tester.tap(find.text('Liquidations').first);
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView).last, const Offset(0, -340));
      await tester.pumpAndSettle();
      await capture('liquidation');
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets(
    'keeps funding precision and does not invent settlement currency',
    (tester) async {
      await mount(tester, HistoryRepository());
      expect(
        find.text('Settled amount: -0.1234567890123456789'),
        findsOneWidget,
      );
      expect(
        find.text('Settlement asset unavailable — not a USD valuation'),
        findsOneWidget,
      );
      expect(
        find.textContaining('permanent history retention'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'archive empty result still reports a gap and can read its exact window',
    (tester) async {
      final repository = HistoryRepository();
      await mount(tester, repository);
      final initial = repository.queries.single;
      await tester.tap(find.byType(DropdownButton<Hip3HistorySource>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Saved archive').last);
      await tester.pumpAndSettle();
      expect(repository.queries.last.from, initial.from);
      expect(repository.queries.last.to, initial.to);
      expect(find.textContaining('History is incomplete'), findsOneWidget);
      expect(find.text('Missing intervals: 1'), findsOneWidget);
      expect(
        find.text('No records were returned for this window.'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('Read missing history'));
      await tester.tap(find.text('Read missing history'));
      await tester.pumpAndSettle();
      expect(repository.queries.last.source, Hip3HistorySource.live);
      expect(repository.queries.last.from, initial.from);
      expect(repository.queries.last.to, initial.to);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('account change immediately hides the prior account facts', (
    tester,
  ) async {
    final repository = HistoryRepository();
    final container = await mount(tester, repository);
    expect(find.text('xyz:TSLA'), findsOneWidget);
    repository.pending = Completer();
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await tester.pump();
    await tester.pump();
    expect(find.text('xyz:TSLA'), findsNothing);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    repository.pending!.complete(repository.page(repository.queries.last, []));
    await tester.pumpAndSettle();
    expect(
      find.text('No records were returned for this window.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'large text liquidation preserves full event group and value caveat',
    (tester) async {
      await mount(
        tester,
        HistoryRepository(),
        kind: Hip3HistoryKind.liquidations,
        scale: 1.6,
      );
      await tester.scrollUntilVisible(
        find.text('xyz:NVDA: 0.25'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('xyz:TSLA: -0.099'), findsOneWidget);
      expect(find.text('xyz:NVDA: 0.25'), findsOneWidget);
      expect(
        find.textContaining('not the loss on an individual product'),
        findsOneWidget,
      );
      expect(
        find.text('Other native positions in this event: 1'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
