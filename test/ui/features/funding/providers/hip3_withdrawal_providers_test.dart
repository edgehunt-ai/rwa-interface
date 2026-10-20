import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_reporter.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/observability_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/deployment_environment.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';

void main() {
  test(
    'transfer balance uses HIP-3 available USD instead of total USDC',
    () async {
      final repository = _AvailableBalancePortfolio();
      final container = ProviderContainer(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          portfolioRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final balance = await container.read(hip3TransferBalanceProvider.future);

      expect(balance, '1.962684');
    },
  );

  ProviderContainer makeContainer(
    _Repository repo, {
    String network = 'mainnet',
  }) => ProviderContainer(
    overrides: [
      deploymentEnvironmentProvider.overrideWith(
        (_) async => DeploymentEnvironment(
          environment: network,
          hip3Environment: network,
          bstocksConfigured: false,
        ),
      ),
      hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
    ],
  );

  test(
    'Arbitrum gross amount is exact decimal and destination is frozen',
    () async {
      final repo = _Repository();
      final container = makeContainer(repo);
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      await commands.preview('51.400000');
      await commands.prepare('51.40', rail: 'float', payoutChainId: 42161);
      expect(repo.previewChains, [42161]);
      expect(repo.creationChains, [42161]);
    },
  );

  test('Testnet selects Arbitrum Sepolia from the API environment', () async {
    final repo = _Repository()..chainId = 421614;
    final container = makeContainer(repo, network: 'testnet');
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    await commands.preview('51.4');
    await commands.prepare('51.4', rail: 'float', payoutChainId: 421614);
    expect(repo.previewChains, [421614]);
    expect(repo.creationChains, [421614]);
  });

  for (final previewAsset in <String?>['USDC', null]) {
    test(
      'testnet Bridge2 matches USDC2 against preview $previewAsset',
      () async {
        final repo = _Repository()
          ..chainId = 421614
          ..rail = 'bridge2'
          ..previewAsset = previewAsset
          ..createdAsset = 'USDC2';
        final container = makeContainer(repo, network: 'testnet');
        addTearDown(container.dispose);
        final commands = container.read(hip3WithdrawalCommandsProvider);
        await commands.preview('51.4');
        final prepared = await commands.prepare('51.4', rail: 'bridge2');
        expect(prepared.payoutAsset, 'USDC2');
        expect(repo.creationChains, [421614]);
      },
    );
  }

  for (final target in [
    (network: 'mainnet', chainId: 42161, rail: 'bridge2'),
    (network: 'testnet', chainId: 421614, rail: 'relay'),
  ]) {
    test('USDC2 is rejected outside testnet Bridge2: $target', () async {
      final repo = _Repository()
        ..chainId = target.chainId
        ..rail = target.rail
        ..previewAsset = 'USDC'
        ..createdAsset = 'USDC2';
      final container = makeContainer(repo, network: target.network);
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      await commands.preview('51.4');
      await expectLater(
        commands.prepare('51.4', rail: target.rail),
        throwsA(isA<Hip3WithdrawalQuoteChanged>()),
      );
      expect(repo.submitted, 0);
    });
  }

  test(
    'a venue submission with an unknown result cannot create or sign again',
    () async {
      final repo = _Repository();
      final container = makeContainer(repo);
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      await commands.preview('51.4');
      final prepared = await commands.prepare('51.4', rail: 'float');
      repo.status = 'submitting';
      final repeated = await commands.prepare('51.4', rail: 'float');
      expect(repeated.status, 'submitting');
      expect(repeated.isPending, isTrue);
      expect((await commands.submit(prepared)).status, 'submitting');
      expect(repo.creationKeys, hasLength(1));
      expect(repo.submitted, 0);
    },
  );

  for (final status in [
    'manual_review',
    'partial',
    'refund_pending',
    'ambiguous',
  ]) {
    test(
      '$status reconciles the same withdrawal without creating another',
      () async {
        final repo = _Repository();
        final container = makeContainer(repo);
        addTearDown(container.dispose);
        final commands = container.read(hip3WithdrawalCommandsProvider);
        await commands.preview('51.4');
        final prepared = await commands.prepare('51.4', rail: 'float');
        repo.status = status;
        for (var i = 0; i < 2; i++) {
          final repeated = await commands.prepare('51.4', rail: 'float');
          expect(repeated.id, prepared.id);
          expect(repeated.status, status);
          expect(repeated.isCompleted, isFalse);
        }
        expect(repo.creationKeys, hasLength(1));
        expect(repo.submitted, 0);
      },
    );
  }

  test('a successful submit response retains the pending withdrawal for reconciliation', () async {
    final repo = _Repository();
    final container = makeContainer(repo);
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    await commands.preview('51.4');
    final prepared = await commands.prepare('51.4', rail: 'float');
    final submitted = await commands.submit(prepared);
    expect(submitted.status, 'submitted');
    expect(submitted.isCompleted, isFalse);
    final repeated = await commands.prepare('51.4', rail: 'float');
    expect(repeated.id, prepared.id);
    expect(repo.creationKeys, hasLength(1));
    expect(repo.submitted, 1);
  });

  for (final changed in ['signature expiry', 'quote fee', 'input amount']) {
    test(
      'reconciles a lost submission response after $changed before creating again',
      () async {
        final repo = _Repository();
        if (changed == 'signature expiry') {
          repo.intentExpiresAt = DateTime.now().subtract(
            const Duration(minutes: 1),
          );
        }
        final container = makeContainer(repo);
        addTearDown(container.dispose);
        final commands = container.read(hip3WithdrawalCommandsProvider);
        await commands.preview('51.4');
        final prepared = await commands.prepare('51.4', rail: 'float');
        repo.status = 'submitting';
        if (changed == 'signature expiry') {
          expect(prepared.expiresAt.isBefore(DateTime.now()), isTrue);
        }
        if (changed == 'quote fee') {
          repo.quotedFee = '2';
          await commands.preview('51.4', forceRefresh: true);
        }
        final current = await commands.prepare(
          changed == 'input amount' ? '52' : '51.4',
          rail: 'float',
        );
        expect(current.status, 'submitting');
        expect(repo.creationKeys, hasLength(1));
        expect(repo.submitted, 0);
      },
    );
  }

  test('unknown environments fail before any quote request', () async {
    final repo = _Repository();
    final container = makeContainer(repo, network: 'unknown');
    addTearDown(container.dispose);
    await expectLater(
      container.read(hip3WithdrawalCommandsProvider).preview('51.4'),
      throwsStateError,
    );
    expect(repo.previewAmounts, isEmpty);
  });

  test('a BSC preview cannot change the Arbitrum destination', () async {
    final repo = _Repository()..chainId = 56;
    final container = makeContainer(repo);
    addTearDown(container.dispose);
    await expectLater(
      container.read(hip3WithdrawalCommandsProvider).preview('51.4'),
      throwsStateError,
    );
    expect(repo.creationKeys, isEmpty);
  });

  test(
    'an unexpected quote asset is rejected before creating an intent',
    () async {
      final repo = _Repository()..previewAsset = 'USDT';
      final container = makeContainer(repo);
      addTearDown(container.dispose);
      await expectLater(
        container.read(hip3WithdrawalCommandsProvider).preview('51.4'),
        throwsStateError,
      );
      expect(repo.creationKeys, isEmpty);
    },
  );

  for (final field in [
    'chain',
    'asset',
    'amount',
    'fee',
    'minimum',
    'rail',
    'destination',
  ]) {
    test('changed frozen $field rejects preparation before signing', () async {
      final repo = _Repository()..changedField = field;
      final container = makeContainer(repo);
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      await commands.preview('51.4');
      await expectLater(
        commands.prepare('51.4', rail: 'float', payoutChainId: 42161),
        throwsA(isA<Hip3WithdrawalQuoteChanged>()),
      );
      expect(repo.submitted, 0);
      expect(repo.creationKeys, hasLength(1));
      repo.changedField = null;
      await commands.preview('51.4', forceRefresh: true);
      await commands.prepare('51.4', rail: 'float', payoutChainId: 42161);
      expect(repo.creationKeys.toSet(), hasLength(2));
    });
  }

  test('relay freezes updated estimated economics and submits once', () async {
    final repo = _Repository()
      ..rail = 'relay'
      ..changedField = 'relay_economics';
    final container = makeContainer(repo);
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    await commands.preview('51.4');
    final prepared = await commands.prepare('51.4', rail: 'relay');
    expect(prepared.fee, '1.19');
    expect(prepared.minimumReceived, '50.21');
    await commands.submit(prepared);
    expect(repo.submitted, 1);
    expect(repo.creationKeys, hasLength(1));
    expect(repo.previewAmounts, ['51.4']);
  });

  for (final field in [
    'chain',
    'asset',
    'amount',
    'destination',
    'fee',
    'minimum',
  ]) {
    test('relay rejects changed $field or inconsistent economics', () async {
      final repo = _Repository()
        ..rail = 'relay'
        ..changedField = field;
      final container = makeContainer(repo);
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      await commands.preview('51.4');
      await expectLater(
        commands.prepare('51.4', rail: 'relay'),
        throwsA(isA<Hip3WithdrawalQuoteChanged>()),
      );
      expect(repo.submitted, 0);
    });
  }

  test('preparation reuses the frozen intent and submits it once', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [
        deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
        hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);

    final preview = await commands.preview('51.4');
    expect(preview.rail, 'float');
    final first = await commands.prepare('51.4', rail: preview.rail);
    final repeated = await commands.prepare('51.4', rail: preview.rail);
    expect(identical(first, repeated), isTrue);
    expect(repo.previewAmounts, ['51.4']);
    expect(repo.creationKeys, hasLength(1));
    expect(repo.creationRails, ['float']);
    await commands.submit(first);
    expect(repo.submitted, 1);
    expect(repo.submittedIntent, same(first));
    expect(repo.submissionKeys, hasLength(1));
    final afterSubmission = await commands.submit(first);
    expect(afterSubmission.status, 'submitted');
    expect(repo.submitted, 1);
  });

  test(
    'an expired risk preview is requested again for the same amount',
    () async {
      final repo = _Repository()
        ..riskValidUntil = DateTime.now().toUtc().subtract(
          const Duration(seconds: 1),
        );
      final container = ProviderContainer(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);

      await commands.preview('51.4');
      await commands.preview('51.4');

      expect(repo.previewAmounts, ['51.4', '51.4']);
    },
  );

  test('a current risk preview remains cached for the same amount', () async {
    final repo = _Repository()
      ..riskValidUntil = DateTime.now().toUtc().add(const Duration(minutes: 1));
    final container = ProviderContainer(
      overrides: [
        deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
        hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);

    await commands.preview('51.4');
    await commands.preview('51.4');

    expect(repo.previewAmounts, ['51.4']);
  });

  test(
    'lost submit response uses the same intent and idempotency key',
    () async {
      final repo = _Repository()..failSubmissionOnce = true;
      final observability = _RecordingObservabilityReporter();
      final container = ProviderContainer(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
          observabilityReporterProvider.overrideWithValue(observability),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      final preview = await commands.preview('51.4');
      final intent = await commands.prepare('51.4', rail: preview.rail);
      await expectLater(commands.submit(intent), throwsStateError);
      expect(await commands.prepare('51.4', rail: preview.rail), same(intent));
      await commands.submit(intent);
      expect(repo.creationKeys, hasLength(1));
      expect(repo.submissionKeys.toSet(), hasLength(1));
      expect(observability.errors, [isA<StateError>()]);
      expect(observability.operations, [
        'hip3_withdrawal_prepare:started',
        'hip3_withdrawal_prepare:succeeded',
        'hip3_withdrawal_submit:started',
        'hip3_withdrawal_submit:failed',
        'hip3_withdrawal_prepare:started',
        'hip3_withdrawal_prepare:succeeded',
        'hip3_withdrawal_submit:started',
        'hip3_withdrawal_submit:succeeded',
      ]);
    },
  );

  test('preparation reports API failures', () async {
    final repo = _Repository()..createFailure = const UnknownFailure();
    final observability = _RecordingObservabilityReporter();
    final container = ProviderContainer(
      overrides: [
        deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
        hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
        observabilityReporterProvider.overrideWithValue(observability),
      ],
    );
    addTearDown(container.dispose);

    final commands = container.read(hip3WithdrawalCommandsProvider);
    await commands.preview('51.4');
    await expectLater(
      commands.prepare('51.4', rail: 'float'),
      throwsA(isA<UnknownFailure>()),
    );

    expect(observability.failures, [isA<UnknownFailure>()]);
    expect(observability.operations, [
      'hip3_withdrawal_prepare:started',
      'hip3_withdrawal_prepare:failed',
    ]);
  });

  test(
    'a terminal observation precedes an explicit new creation key',
    () async {
      final repo = _Repository();
      final container = ProviderContainer(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      final preview = await commands.preview('51.4');
      await commands.prepare('51.4', rail: preview.rail);
      repo.status = 'failed';
      final failed = await commands.prepare('51.4', rail: preview.rail);
      expect(failed.status, 'failed');
      expect(repo.creationKeys, hasLength(1));
      await commands.prepare('51.4', rail: preview.rail);
      expect(repo.creationKeys, hasLength(2));
      expect(repo.creationKeys.toSet(), hasLength(2));
    },
  );

  test('an old account session cannot submit its frozen intent', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [
        deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
        hip3WithdrawalRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    final preview = await commands.preview('51.4');
    final intent = await commands.prepare('51.4', rail: preview.rail);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await expectLater(commands.submit(intent), throwsStateError);
    expect(repo.submitted, 0);
  });
}

final class _AvailableBalancePortfolio implements PortfolioRepository {
  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.hip3,
      availableUsd: DecimalValue('1.962684', asset: 'USD', unit: 'fiat'),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: DecimalValue('4.943396', asset: 'USDC', unit: 'token'),
        ),
      ],
    ),
  ];

  @override
  Future<Portfolio> getSummary() => throw UnimplementedError();

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      throw UnimplementedError();
}

class _Repository implements Hip3WithdrawalRepository {
  final previewAmounts = <String>[];
  final previewChains = <int>[];
  final creationChains = <int>[];
  int chainId = 42161;
  String? previewAsset;
  String createdAsset = 'USDC';
  String rail = 'float';
  String quotedFee = '1.18';
  DateTime? intentExpiresAt;
  String? changedField;
  final creationKeys = <String>[];
  final creationRails = <String>[];
  final submissionKeys = <String>[];
  int submitted = 0;
  bool failSubmissionOnce = false;
  ApiFailure? createFailure;
  String status = 'awaiting_signature';
  Hip3Withdrawal? submittedIntent;
  DateTime? riskValidUntil;

  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) async {
    previewAmounts.add(amount);
    previewChains.add(payoutChainId);
    return Hip3WithdrawalPreview(
      amount: '51.4',
      fee: quotedFee,
      minimumReceived: '50.22',
      rail: rail,
      destinationAddress: '0x1111111111111111111111111111111111111111',
      chainId: chainId.toString(),
      payoutAsset: previewAsset,
      maximumTransferable: '100',
      blockers: [],
      estimatedArrivalSeconds: 120,
      feeDetails: [],
      crossLiquidationImpacts: [],
      riskStatus: 'available',
      riskValidUntil: riskValidUntil,
    );
  }

  Hip3Withdrawal _intent(String status) => Hip3Withdrawal(
    id: 'id',
    ownerAddress: '0x1111111111111111111111111111111111111111',
    destinationAddress: changedField == 'destination'
        ? '0x2222222222222222222222222222222222222222'
        : '0x1111111111111111111111111111111111111111',
    amount: changedField == 'amount' ? '52' : '51.400000',
    fee: changedField == 'fee' || changedField == 'relay_economics'
        ? '1.19'
        : '1.180000',
    minimumReceived: changedField == 'relay_economics'
        ? '50.21'
        : changedField == 'minimum'
        ? '50'
        : '50.220000',
    status: status,
    rail: changedField == 'rail' ? 'relay' : rail,
    payoutChainId: changedField == 'chain' ? 56 : chainId,
    payoutAsset: changedField == 'asset' ? 'USDT' : createdAsset,
    expiresAt:
        intentExpiresAt ?? DateTime.now().add(const Duration(minutes: 5)),
    typedDataJson: '{}',
    payloadHash: 'hash',
  );

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required int payoutChainId,
    required String idempotencyKey,
  }) async {
    if (createFailure case final failure?) throw failure;
    creationKeys.add(idempotencyKey);
    creationRails.add(rail);
    creationChains.add(payoutChainId);
    return _intent('awaiting_signature');
  }

  @override
  Future<Hip3Withdrawal> get(String id) async =>
      _intent(submitted > 0 ? 'submitted' : status);

  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    submissionKeys.add(idempotencyKey);
    submittedIntent = prepared;
    if (failSubmissionOnce) {
      failSubmissionOnce = false;
      throw StateError('response lost');
    }
    submitted++;
    return _intent('submitted');
  }
}

final class _RecordingObservabilityReporter implements ObservabilityReporter {
  final operations = <String>[];
  final failures = <ApiFailure>[];
  final errors = <Object>[];

  @override
  Future<void> clearUser() async {}

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    failures.add(failure);
    recordOperation(operation, outcome: 'failed');
  }

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
    String failureKind = 'unexpected',
  }) {
    errors.add(error);
    recordOperation(operation, outcome: 'failed');
  }

  @override
  void recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    operations.add('$operation:$outcome');
  }

  @override
  Future<void> setUserId(String userId) async {}
}

Future<DeploymentEnvironment> _mainnetEnvironment(Ref ref) async =>
    const DeploymentEnvironment(
      environment: 'mainnet',
      hip3Environment: 'mainnet',
      bstocksConfigured: false,
    );
