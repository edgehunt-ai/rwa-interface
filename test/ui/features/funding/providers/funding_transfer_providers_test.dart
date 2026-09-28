import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/funding_catalog_summary.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/funding_session.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';

void main() {
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
      expect(plan.planId, 'plan-1');
    },
  );

  test(
    'transfer quote reuses one session and advances selection versions',
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
      expect(funding.selectionVersions, [3, 4]);
    },
  );

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
}

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
    this.createdAllocations = const {},
  });

  String? createdPlanFor;
  String? transferAuthorizationId;
  String? transferSessionAmount;
  String? transferSessionDestination;
  String? sessionPlanId;
  Map<String, String>? selectedAllocations;
  final bool failPlanQuery;
  final bool conflictOnFirstSelection;
  final Map<String, String> createdAllocations;
  int transferSessionCalls = 0;
  int sessionRefreshes = 0;
  final List<int> selectionVersions = [];
  final List<String> planKeys = [];
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
      status: 'readyToConfirm',
      version: 3,
      canConfirmTransfer: true,
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
    required String idempotencyKey,
  }) async {
    selectionVersions.add(version);
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
    return FundingSessionSummary(
      sessionId: id,
      status: 'readyToConfirm',
      version: 7,
      canConfirmTransfer: true,
      expiresAt: DateTime.utc(2026, 1, 2),
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
    return plan;
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
      status: FundingTransferState.awaitingWallet,
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
