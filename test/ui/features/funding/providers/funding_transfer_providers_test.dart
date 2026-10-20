import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/funding_catalog_summary.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/domain/repositories/wallet_action_execution_repository.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';

import '../../../../helpers/funding_execution_fixture.dart';

void main() {
  for (final mode in GasPaymentMode.values) {
    test(
      '$mode transfer follows server action and fresh execution authority',
      () async {
        final funding = _FundingRepository(nextAction: _action(mode));
        final executions = RecordingFundingExecutions(
          created: fundingExecution(mode: mode, resourceId: 'transfer-1'),
        );
        final signer = RecordingFundingSigner(executions.events);
        final container = ProviderContainer(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(funding),
            walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
            walletActionExecutionRepositoryProvider.overrideWithValue(
              executions,
            ),
            walletAuthorizationSignerProvider.overrideWithValue(signer),
          ],
        );
        addTearDown(container.dispose);
        final commands = container.read(fundingTransferCommandsProvider);
        final authorization = await commands.authorize(funding.plan);
        await commands.create(plan: funding.plan, authorization: authorization);
        expect(executions.modes, [mode]);
        expect(executions.events, ['create', 'get', 'sign', 'submit']);
        expect(
          signer.requests.single.sponsor,
          mode == GasPaymentMode.appSponsored,
        );
        expect(signer.signers, [fundingSigner]);
        expect(executions.hashes, isEmpty);
      },
    );
  }

  test(
    'missing or unsupported action mode never creates an execution',
    () async {
      final funding = _FundingRepository(nextAction: _action(null));
      final executions = RecordingFundingExecutions(
        created: fundingExecution(resourceId: 'transfer-1'),
      );
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
          walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);
      final authorization = await commands.authorize(funding.plan);
      await expectLater(
        commands.create(plan: funding.plan, authorization: authorization),
        throwsStateError,
      );
      expect(executions.events, isEmpty);
    },
  );

  test('selected mode cannot drift between create and fresh GET', () async {
    final funding = _FundingRepository(
      nextAction: _action(GasPaymentMode.userPaidNative),
    );
    final executions = RecordingFundingExecutions(
      created: fundingExecution(resourceId: 'transfer-1'),
      current: fundingExecution(
        resourceId: 'transfer-1',
        mode: GasPaymentMode.appSponsored,
      ),
    );
    final signer = RecordingFundingSigner(executions.events);
    final container = ProviderContainer(
      overrides: [
        fundingRepositoryProvider.overrideWithValue(funding),
        walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(signer),
      ],
    );
    addTearDown(container.dispose);
    final commands = container.read(fundingTransferCommandsProvider);
    final authorization = await commands.authorize(funding.plan);
    await expectLater(
      commands.create(plan: funding.plan, authorization: authorization),
      throwsStateError,
    );
    expect(executions.modes, [GasPaymentMode.userPaidNative]);
    expect(signer.requests, isEmpty);
  });

  for (final status in [
    WalletActionExecutionState.submitting,
    WalletActionExecutionState.ambiguous,
    WalletActionExecutionState.manualReview,
  ]) {
    test(
      'transfer observes fresh $status instead of signing stale create',
      () async {
        final funding = _FundingRepository(
          nextAction: _action(GasPaymentMode.userPaidNative),
        );
        final executions = RecordingFundingExecutions(
          created: fundingExecution(resourceId: 'transfer-1'),
          current: fundingExecution(
            resourceId: 'transfer-1',
            status: status,
            includeAuthorization: false,
          ),
        );
        final signer = RecordingFundingSigner(executions.events);
        final container = ProviderContainer(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(funding),
            walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
            walletActionExecutionRepositoryProvider.overrideWithValue(
              executions,
            ),
            walletAuthorizationSignerProvider.overrideWithValue(signer),
          ],
        );
        addTearDown(container.dispose);
        final commands = container.read(fundingTransferCommandsProvider);
        await commands.create(
          plan: funding.plan,
          authorization: await commands.authorize(funding.plan),
        );
        expect(executions.events, ['create', 'get']);
        expect(signer.requests, isEmpty);
      },
    );
  }

  test('transfer lost authorization response only observes on retry', () async {
    final funding = _FundingRepository(
      nextAction: _action(GasPaymentMode.userPaidNative),
    );
    final executions = RecordingFundingExecutions(
      created: fundingExecution(resourceId: 'transfer-1'),
      submitFailure: const NetworkFailure(),
    );
    final signer = RecordingFundingSigner(executions.events);
    final container = ProviderContainer(
      overrides: [
        fundingRepositoryProvider.overrideWithValue(funding),
        walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(signer),
      ],
    );
    addTearDown(container.dispose);
    final commands = container.read(fundingTransferCommandsProvider);
    final authorization = await commands.authorize(funding.plan);
    await expectLater(
      commands.create(plan: funding.plan, authorization: authorization),
      throwsA(isA<NetworkFailure>()),
    );
    await commands.create(plan: funding.plan, authorization: authorization);
    expect(executions.events, ['create', 'get', 'sign', 'submit', 'get']);
    expect(signer.requests, hasLength(1));
    expect(executions.signatures, hasLength(1));
  });

  for (final mismatch in ['resource', 'mode', 'raw call', 'nonce']) {
    test('transfer rejects $mismatch drift before signing', () async {
      final funding = _FundingRepository(
        nextAction: _action(GasPaymentMode.userPaidNative),
      );
      final executions = RecordingFundingExecutions(
        created: fundingExecution(
          resourceId: mismatch == 'resource' ? 'other-transfer' : 'transfer-1',
          mode: mismatch == 'mode'
              ? GasPaymentMode.appSponsored
              : GasPaymentMode.userPaidNative,
          rawTo: mismatch == 'raw call'
              ? '0x9999999999999999999999999999999999999999'
              : null,
          authorizedNonce: mismatch == 'nonce' ? '0xb' : '0xa',
        ),
      );
      final signer = RecordingFundingSigner(executions.events);
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
          walletActionExecutionRepositoryProvider.overrideWithValue(executions),
          walletAuthorizationSignerProvider.overrideWithValue(signer),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);
      final authorization = await commands.authorize(funding.plan);
      await expectLater(
        commands.create(plan: funding.plan, authorization: authorization),
        throwsStateError,
      );
      expect(signer.requests, isEmpty);
      expect(executions.signatures, isEmpty);
    });
  }

  for (final status in [
    FundingTransferState.failed,
    FundingTransferState.manualReview,
    FundingTransferState.refundPending,
    FundingTransferState.refunded,
  ]) {
    test('$status never executes a stale wallet action', () async {
      final funding = _FundingRepository(
        transferStatus: status,
        nextActionId: 'stale-action',
      );
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
          walletActionExecutionRepositoryProvider.overrideWithValue(
            _UnexpectedTransferExecution(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);
      final authorization = await commands.authorize(funding.plan);
      final transfer = await commands.create(
        plan: funding.plan,
        authorization: authorization,
      );
      expect(transfer.status, status);
      expect(transfer.isCompleted, isFalse);
    });
  }

  test(
    'manual review quote cannot create or update an executable plan',
    () async {
      final funding = _FundingRepository(createdStatus: 'manualReview');
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);
      final quote = await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-1': '10'},
      );
      expect(quote.requiresReview, isTrue);
      expect(funding.selectionVersions, isEmpty);
      await expectLater(commands.planForSession(quote), throwsStateError);
      expect(funding.sessionPlanId, isNull);
    },
  );
  test(
    'transfer options remain usable when the legacy catalog fails',
    () async {
      final funding = _CatalogFailingRepository();
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final options = await container.read(transferOptionsProvider.future);

      expect(options.account.positions.single.positionId, 'position-1');
      expect(options.catalog, isNull);
      expect(funding.accountCalls, 1);
      expect(funding.catalogCalls, 1);
    },
  );

  test('transfer options failure does not retry account or catalog', () async {
    final funding = _FailingOptionsRepository();
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(transferOptionsProvider.future),
      throwsA(isA<NetworkFailure>()),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(funding.accountCalls, 1);
    expect(funding.catalogCalls, 1);
  });

  test(
    'standalone transfer creates a transfer session before its plan',
    () async {
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final plan = await container
          .read(fundingTransferCommandsProvider)
          .transferSession(
            destination: 'hip3_margin',
            amount: '160.25',
            allocations: const {'position-1': '160.25'},
          );

      expect(funding.transferSessionAmount, '160.25');
      expect(funding.transferSessionDestination, 'hip3_margin');
      expect(funding.sessionPlanId, 'transfer-session-1');
      expect(funding.selectedAllocations, {'position-1': '160.25'});
      expect(funding.selectedAmount, isNull);
      expect(plan.planId, 'plan-1');
    },
  );

  test(
    'transfer quote refreshes one session before advancing selection versions',
    () async {
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);

      await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-1': '10'},
      );
      await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-2': '10'},
      );

      expect(funding.transferSessionCalls, 1);
      expect(funding.sessionRefreshes, 1);
      expect(funding.selectionVersions, [3, 7]);
    },
  );

  test(
    'same amount returns transferring session without editing selection',
    () async {
      final funding = _FundingRepository(refreshedStatus: 'transferring');
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);

      await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-1': '10'},
      );
      final quote = await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-1': '10'},
      );

      expect(quote.status, 'transferring');
      expect(funding.sessionRefreshes, 1);
      expect(funding.selectionVersions, [3]);
    },
  );

  test('same amount starts a new session after terminal draft', () async {
    final funding = _FundingRepository(refreshedStatus: 'expired');
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);
    final commands = container.read(fundingTransferCommandsProvider);

    await commands.quoteTransfer(
      destination: 'hip3_margin',
      amount: '10',
      allocations: const {'position-1': '10'},
    );
    await commands.quoteTransfer(
      destination: 'hip3_margin',
      amount: '10',
      allocations: const {'position-1': '10'},
    );

    expect(funding.transferSessionCalls, 2);
    expect(funding.selectionVersions, [3, 3]);
  });

  test(
    'transfer quote creates a new session only when target amount changes',
    () async {
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);
      final commands = container.read(fundingTransferCommandsProvider);

      await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '10',
        allocations: const {'position-1': '10'},
      );
      await commands.quoteTransfer(
        destination: 'hip3_margin',
        amount: '11',
        allocations: const {'position-1': '11'},
      );

      expect(funding.transferSessionCalls, 2);
      expect(funding.selectionVersions, [3, 3]);
    },
  );

  test(
    'transfer quote accepts matching allocations returned at creation',
    () async {
      final funding = _FundingRepository(
        createdAllocations: const {'position-1': '10'},
      );
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final quote = await container
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: '10',
            allocations: const {'position-1': '10'},
          );

      expect(quote.allocations, {'position-1': '10'});
      expect(funding.selectionVersions, isEmpty);
    },
  );

  test(
    'transfer quote resubmits matching allocations while selection is editing',
    () async {
      final funding = _FundingRepository(
        createdStatus: 'editing',
        createdCanConfirmTransfer: false,
        createdAllocations: const {'position-1': '10'},
      );
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      await container
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: '10',
            allocations: const {'position-1': '10'},
          );

      expect(funding.selectionVersions, [3]);
      expect(funding.selectedAmount, isNull);
    },
  );

  test(
    'transfer quote refreshes and retries once after a version conflict',
    () async {
      final funding = _FundingRepository(conflictOnFirstSelection: true);
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final quote = await container
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: '10',
            allocations: const {'position-1': '10'},
          );

      expect(funding.selectionVersions, [3, 7]);
      expect(funding.sessionRefreshes, 1);
      expect(quote.version, 8);
    },
  );

  test('transfer quote retries matching allocations when conflict refresh is editing', () async {
    final funding = _FundingRepository(
      conflictOnFirstSelection: true,
      refreshedStatus: 'editing',
      refreshedCanConfirmTransfer: false,
      refreshedAllocations: const {'position-1': '10'},
    );
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);

    final quote = await container
        .read(fundingTransferCommandsProvider)
        .quoteTransfer(
          destination: 'hip3_margin',
          amount: '10',
          allocations: const {'position-1': '10'},
        );

    expect(funding.selectionVersions, [3, 7]);
    expect(funding.sessionRefreshes, 1);
    expect(funding.selectedAmount, isNull);
    expect(quote.version, 8);
  });

  test(
    'version conflict does not edit a session that started transferring',
    () async {
      final funding = _FundingRepository(
        conflictOnFirstSelection: true,
        refreshedStatus: 'transferring',
      );
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final quote = await container
          .read(fundingTransferCommandsProvider)
          .quoteTransfer(
            destination: 'hip3_margin',
            amount: '10',
            allocations: const {'position-1': '10'},
          );

      expect(quote.status, 'transferring');
      expect(funding.selectionVersions, [3]);
      expect(funding.sessionRefreshes, 1);
    },
  );

  test('failed quote refresh cannot reuse a stale transfer draft', () async {
    final funding = _FundingRepository(
      createdAllocations: const {'position-1': '10'},
    );
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);
    final commands = container.read(fundingTransferCommandsProvider);
    final quote = await commands.quoteTransfer(
      destination: 'hip3_margin',
      amount: '10',
      allocations: const {'position-1': '10'},
    );
    funding.failSessionRefresh = true;
    await expectLater(
      commands.refreshTransferQuote(quote.sessionId),
      throwsA(isA<NetworkFailure>()),
    );
    await commands.quoteTransfer(
      destination: 'hip3_margin',
      amount: '10',
      allocations: const {'position-1': '10'},
    );

    expect(funding.transferSessionCalls, 2);
  });

  test(
    'funding transfer lifecycle uses a server-selected plan and authorization',
    () async {
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
        ],
      );
      addTearDown(container.dispose);

      final commands = container.read(fundingTransferCommandsProvider);
      final plan = await commands.plan(tradePreviewId: 'preview-1');
      expect(plan.sourceWalletId, 'wallet-1');
      final authorization = await commands.authorize(plan);
      final transfer = await commands.create(
        plan: plan,
        authorization: authorization,
      );

      expect(funding.createdPlanFor, 'preview-1');
      expect(funding.transferAuthorizationId, authorization.authorizationId);
      expect(transfer.status, FundingTransferState.awaitingWallet);
    },
  );

  test('funding plan retries retain a stable idempotency key', () async {
    final funding = _FundingRepository();
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);

    final commands = container.read(fundingTransferCommandsProvider);
    await commands.plan(tradePreviewId: 'preview-1');
    await commands.plan(tradePreviewId: 'preview-1');

    expect(funding.planKeys.toSet(), hasLength(1));
  });

  test('funding plan query exposes a stable domain failure', () async {
    final funding = _FundingRepository(failPlanQuery: true);
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      fundingPlanProvider('plan-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);

    await expectLater(
      container.read(fundingPlanProvider('plan-1').future),
      throwsA(isA<NetworkFailure>()),
    );
  });

  test(
    'plan inspection exposes a released action without executing it',
    () async {
      final inspectedPlan = FundingPlan(
        planId: 'plan-1',
        tradePreviewId: 'session-1',
        shortfall: DecimalValue('1'),
        status: FundingPlanState.executing,
        legs: [
          FundingLeg(
            legId: 'leg-1',
            walletId: 'wallet-1',
            asset: 'USDT',
            maximumAmount: DecimalValue('1'),
            outputAmount: DecimalValue('0.9'),
            status: FundingLegState.submitted,
            transferId: 'transfer-1',
          ),
        ],
      );
      final funding = _FundingRepository()
        ..queriedPlan = inspectedPlan
        ..refreshedTransfer = FundingTransfer(
          transferId: 'transfer-1',
          planId: 'plan-1',
          amount: DecimalValue('1'),
          status: FundingTransferState.awaitingWallet,
          nextActionId: 'origin-action',
        );
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      );
      addTearDown(container.dispose);

      final progress = await container
          .read(fundingTransferCommandsProvider)
          .inspect(inspectedPlan);

      expect(progress.plan, same(inspectedPlan));
      expect(progress.requiresUserAction, isTrue);
      expect(funding.transferReads, 1);
    },
  );
}

FundingTransferAction _action(GasPaymentMode? mode) => FundingTransferAction(
  actionId: 'action-1',
  status: 'ready',
  mode: mode,
  chainId: 56,
  from: fundingSigner,
  transaction: const FrozenTransaction(
    to: fundingTarget,
    data: fundingData,
    value: '0x0',
  ),
  validUntil: DateTime.utc(2030),
);

final class _CatalogFailingRepository implements FundingRepository {
  int accountCalls = 0;
  int catalogCalls = 0;

  @override
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount() async {
    accountCalls++;
    return UnifiedFundingAccountSummary(
      totalUsd: DecimalValue('10'),
      availableToFundUsd: DecimalValue('10'),
      reservedUsd: DecimalValue('0'),
      inTransitUsd: DecimalValue('0'),
      dataStatus: 'complete',
      calculatedAt: DateTime.utc(2026),
      positions: [
        FundingSourcePosition(
          positionId: 'position-1',
          token: 'USDC',
          network: 'Arbitrum',
          availableAmount: DecimalValue('10'),
          eligible: true,
        ),
      ],
    );
  }

  @override
  Future<FundingCatalogSummary> getFundingCatalog() async {
    catalogCalls++;
    throw const NetworkFailure();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FailingOptionsRepository implements FundingRepository {
  int accountCalls = 0;
  int catalogCalls = 0;

  @override
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount() async {
    accountCalls++;
    throw const NetworkFailure();
  }

  @override
  Future<FundingCatalogSummary> getFundingCatalog() async {
    catalogCalls++;
    throw const NetworkFailure();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FundingRepository implements FundingRepository {
  _FundingRepository({
    this.failPlanQuery = false,
    this.conflictOnFirstSelection = false,
    this.createdStatus = 'readyToConfirm',
    this.createdCanConfirmTransfer = true,
    this.createdAllocations = const {},
    this.refreshedStatus = 'readyToConfirm',
    this.refreshedCanConfirmTransfer = true,
    this.refreshedAllocations = const {},
    this.transferStatus = FundingTransferState.awaitingWallet,
    this.nextActionId,
    this.nextAction,
  });

  String? createdPlanFor;
  String? transferAuthorizationId;
  String? transferSessionAmount;
  String? transferSessionDestination;
  String? sessionPlanId;
  Map<String, String>? selectedAllocations;
  String? selectedAmount;
  final bool failPlanQuery;
  final bool conflictOnFirstSelection;
  final String createdStatus;
  final bool createdCanConfirmTransfer;
  final Map<String, String> createdAllocations;
  final String refreshedStatus;
  final bool refreshedCanConfirmTransfer;
  final Map<String, String> refreshedAllocations;
  final FundingTransferState transferStatus;
  final String? nextActionId;
  final FundingTransferAction? nextAction;
  int transferSessionCalls = 0;
  int sessionRefreshes = 0;
  bool failSessionRefresh = false;
  final List<int> selectionVersions = [];
  final List<String> planKeys = [];
  FundingPlan? queriedPlan;
  FundingTransfer? refreshedTransfer;
  int transferReads = 0;
  final plan = FundingPlan(
    planId: 'plan-1',
    tradePreviewId: 'preview-1',
    shortfall: DecimalValue('12', asset: 'USDT', unit: 'token'),
    status: FundingPlanState.ready,
    sourceWalletId: 'wallet-1',
    sourceAsset: 'USDC',
    sourceMaximum: DecimalValue('15', asset: 'USDC', unit: 'token'),
    legs: [
      FundingLeg(
        legId: 'leg-1',
        walletId: 'wallet-1',
        asset: 'USDC',
        maximumAmount: DecimalValue('15', asset: 'USDC', unit: 'token'),
        outputAmount: DecimalValue('12', asset: 'USDT', unit: 'token'),
        status: FundingLegState.actionReleased,
      ),
    ],
  );

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async {
    transferSessionCalls++;
    transferSessionDestination = destination;
    transferSessionAmount = amount;
    return FundingSessionSummary(
      sessionId: 'transfer-session-$transferSessionCalls',
      status: createdStatus,
      version: 3,
      canConfirmTransfer: createdCanConfirmTransfer,
      expiresAt: DateTime.utc(2026, 1, 2),
      allocations: createdAllocations,
    );
  }

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
    sessionPlanId = fundingSessionId;
    return plan;
  }

  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) async {
    selectionVersions.add(version);
    selectedAmount = amount;
    if (conflictOnFirstSelection && selectionVersions.length == 1) {
      throw const ServerFailure(
        statusCode: 409,
        code: 'state_conflict',
        message: 'request conflicts with current state',
      );
    }
    selectedAllocations = allocations;
    return FundingSessionSummary(
      sessionId: fundingSessionId,
      status: 'readyToConfirm',
      version: version + 1,
      canConfirmTransfer: true,
      expiresAt: DateTime.utc(2026, 1, 2),
    );
  }

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async {
    sessionRefreshes++;
    if (failSessionRefresh) throw const NetworkFailure(retryable: false);
    return FundingSessionSummary(
      sessionId: id,
      status: refreshedStatus,
      version: 7,
      canConfirmTransfer: refreshedCanConfirmTransfer,
      expiresAt: DateTime.utc(2026, 1, 2),
      allocations: refreshedAllocations,
    );
  }

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    createdPlanFor = tradePreviewId;
    planKeys.add(idempotencyKey);
    return plan;
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async {
    if (failPlanQuery) throw const NetworkFailure(retryable: false);
    return queriedPlan ?? plan;
  }

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async {
    transferReads++;
    return refreshedTransfer ??
        FundingTransfer(
          transferId: id,
          planId: 'plan-1',
          amount: DecimalValue('1'),
          status: FundingTransferState.filling,
        );
  }

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    transferAuthorizationId = authorizationId;
    return FundingTransfer(
      transferId: 'transfer-1',
      planId: 'plan-1',
      amount: DecimalValue('12', asset: 'USDT', unit: 'token'),
      status: transferStatus,
      nextActionId: nextAction?.actionId ?? nextActionId,
      nextAction: nextAction,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _WalletsRepository implements WalletsRepository {
  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async => WalletAuthorization(
    authorizationId: 'authorization-1',
    walletId: walletId,
    status: WalletAuthorizationState.authorized,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _UnexpectedTransferExecution
    implements WalletActionExecutionRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected wallet execution');
}
