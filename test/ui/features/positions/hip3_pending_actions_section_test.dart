import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/models/hip3_action_summary.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_pending_actions_section.dart';

void main() {
  testWidgets(
    'resumes the original ID once and never offers manual review retry',
    (tester) async {
      final repository = _Repository();
      await _mount(tester, repository);
      expect(find.text('Unfinished HIP3 actions'), findsOneWidget);
      expect(find.byKey(const ValueKey('resume-review')), findsNothing);
      final button = find.byKey(const ValueKey('resume-pending'));
      await tester.tap(button);
      await tester.pump();
      await tester.tap(button);
      await tester.pump();
      expect(repository.resumed, ['pending']);
      repository.completion.completeError(const Hip3ActionPending('pending'));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'The action is still unfinished. Continue this action instead of creating another.',
        ),
        findsOneWidget,
      );
      expect(repository.cursors.where((cursor) => cursor == null).length, 2);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('loads additional actions without looping on a repeated cursor', (
    tester,
  ) async {
    final repository = _Repository();
    await _mount(tester, repository);
    await tester.ensureVisible(find.text('Load more actions'));
    await tester.tap(find.text('Load more actions'));
    await tester.pumpAndSettle();
    expect(repository.cursors, [null, 'page-2']);
    expect(find.text('third'), findsOneWidget);
    expect(find.text('Load more actions'), findsNothing);
  });

  testWidgets('renders Chinese recovery copy at narrow width and large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await _mount(tester, _Repository(), locale: const Locale('zh'), scale: 2);
    expect(find.text('未完成的 HIP3 操作'), findsOneWidget);
    expect(find.text('继续操作'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('stays hidden while loading and when there are no actions', (
    tester,
  ) async {
    final repository = _EmptyRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: Hip3PendingActionsSection()),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Unfinished HIP3 actions'), findsNothing);
    expect(find.text('Refresh actions'), findsNothing);

    repository.completion.complete(const DomainPage(items: []));
    await tester.pumpAndSettle();

    expect(find.text('Unfinished HIP3 actions'), findsNothing);
    expect(find.text('No unfinished actions.'), findsNothing);
  });
}

Future<void> _mount(
  WidgetTester tester,
  _Repository repository, {
  Locale locale = const Locale('en'),
  double scale = 1,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: const Scaffold(
          body: SingleChildScrollView(child: Hip3PendingActionsSection()),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _Repository implements PositionsRepository {
  final cursors = <String?>[];
  final resumed = <String>[];
  final completion = Completer<void>();

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async {
    cursors.add(cursor);
    return DomainPage(
      items: cursor == null
          ? [_action('pending'), _action('review', review: true)]
          : [_action('third')],
      nextCursor: 'page-2',
      hasMore: true,
    );
  }

  @override
  Future<void> resumeHip3Action(String actionId) {
    resumed.add(actionId);
    return completion.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _EmptyRepository implements PositionsRepository {
  final completion = Completer<DomainPage<Hip3ActionSummary>>();

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({String? cursor}) =>
      completion.future;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Hip3ActionSummary _action(String id, {bool review = false}) =>
    Hip3ActionSummary(
      actionId: id,
      productId: 'xyz:TSLA',
      operation: 'setTpsl',
      status: review ? 'manualReview' : 'awaitingSignature',
      effectsApplied: false,
      canResumePositionAction: !review,
    );
