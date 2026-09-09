import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/unsupported_capability.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

void main() {
  test('funding transfer capability always waits for feature', () {
    const capability = UnsupportedCapability.fundingTransfer(
      resourceId: 'deposit-1',
    );
    expect(capability.userAction, 'wait_for_feature');
    expect(capability.retryable, isFalse);
  });

  test(
    'same deposit intent merges concurrency and preserves retry key',
    () async {
      final repository = _FundingRepository();
      final container = _container(repository);
      final subscription = container.listen(depositCommandsProvider, (_, _) {});
      addTearDown(subscription.close);
      final commands = container.read(depositCommandsProvider);

      final results = await Future.wait([
        commands.create(chain: 'BSC', amount: '1'),
        commands.create(chain: 'BSC', amount: '1'),
      ]);
      expect(results, hasLength(2));
      expect(repository.keys, hasLength(1));

      await commands.create(chain: 'BSC', amount: '1');
      expect(repository.keys.toSet(), hasLength(1));

      await commands.create(chain: 'BSC', amount: '2');
      expect(repository.keys.toSet(), hasLength(2));
    },
  );

  test(
    'catalog, list, and detail are isolated by session generation',
    () async {
      final repository = _FundingRepository();
      final container = _container(repository);
      final catalog = container.listen(fundingCatalogProvider, (_, _) {});
      final list = container.listen(depositsProvider(null), (_, _) {});
      final detail = container.listen(depositProvider('deposit-1'), (_, _) {});
      addTearDown(catalog.close);
      addTearDown(list.close);
      addTearDown(detail.close);

      await _readQueries(container);
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await _readQueries(container);

      expect(repository.catalogCalls, 2);
      expect(repository.listCalls, 2);
      expect(repository.getCalls, 2);
    },
  );

  test('query exposes a stable domain failure', () async {
    final repository = _FundingRepository()..failCatalog = true;
    final container = _container(repository);
    final errors = <Object>[];
    final subscription = container.listen(fundingCatalogProvider, (_, next) {
      if (next.hasError) errors.add(next.error!);
    });
    addTearDown(subscription.close);

    await pumpEventQueue();
    expect(errors.single, isA<NetworkFailure>());
  });
}

ProviderContainer _container(_FundingRepository repository) {
  final container = ProviderContainer(
    overrides: [fundingRepositoryProvider.overrideWithValue(repository)],
  );
  addTearDown(container.dispose);
  return container;
}

Future<void> _readQueries(ProviderContainer container) => Future.wait([
  container.read(fundingCatalogProvider.future),
  container.read(depositsProvider(null).future),
  container.read(depositProvider('deposit-1').future),
]);

final class _FundingRepository implements FundingRepository {
  final List<String> keys = [];
  int catalogCalls = 0;
  int listCalls = 0;
  int getCalls = 0;
  bool failCatalog = false;

  ResourceResult<Deposit> get _deposit => ResourceResult(
    resource: const Deposit(
      depositId: 'deposit-1',
      chain: 'BSC',
      token: 'USDC',
      status: DepositState.awaiting,
      instructions: DepositInstructions(address: '0x123'),
      requiresTransfer: true,
    ),
    capability: const UnsupportedCapability.fundingTransfer(
      resourceId: 'deposit-1',
    ),
  );

  @override
  Future<FundingCatalog> getCatalog() async {
    catalogCalls++;
    if (failCatalog) throw const NetworkFailure();
    return FundingCatalog(rails: const [], updatedAt: DateTime.utc(2026));
  }

  @override
  Future<ResourceResult<Deposit>> createDeposit({
    required String chain,
    String? amount,
    required String idempotencyKey,
  }) async {
    keys.add(idempotencyKey);
    await Future<void>.delayed(const Duration(milliseconds: 2));
    return _deposit;
  }

  @override
  Future<ResourceResult<Deposit>> getDeposit(String id) async {
    getCalls++;
    return _deposit;
  }

  @override
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({
    String? cursor,
  }) async {
    listCalls++;
    return DomainPage(items: [_deposit]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
