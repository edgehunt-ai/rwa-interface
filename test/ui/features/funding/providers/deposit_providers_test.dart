import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

void main() {
  test(
    'directory, list, and detail are isolated by session generation',
    () async {
      final repository = _FundingRepository();
      final container = _container(repository);
      final directory = container.listen(depositDirectoryProvider, (_, _) {});
      final list = container.listen(depositsProvider(null), (_, _) {});
      final detail = container.listen(depositProvider('deposit-1'), (_, _) {});
      addTearDown(directory.close);
      addTearDown(list.close);
      addTearDown(detail.close);

      await _readQueries(container);
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await _readQueries(container);

      expect(repository.directoryCalls, 2);
      expect(repository.listCalls, 2);
      expect(repository.getCalls, 2);
    },
  );

  test('deposit instructions are selected from the cached directory', () async {
    final repository = _FundingRepository();
    final container = _container(repository);
    final route = (chain: 'Arbitrum', token: 'USDC');

    expect(
      await container.read(depositInstructionProvider(route).future),
      isA<DepositInstruction>(),
    );
    expect(
      await container.read(depositInstructionProvider(route).future),
      isA<DepositInstruction>(),
    );
    expect(repository.directoryCalls, 1);

    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.read(depositInstructionProvider(route).future);
    expect(repository.directoryCalls, 2);
  });

  test('deposit routes are derived from the aggregate directory', () async {
    final repository = _FundingRepository();
    final container = _container(repository);

    final routes = await container.read(depositRoutesProvider.future);

    expect(repository.directoryCalls, 1);
    expect(routes.map((route) => '${route.chain}:${route.token}'), [
      'Arbitrum:USDC',
      'BSC:USDT',
      'BSC:USDC',
    ]);
    expect(routes.first.isRecommended, isTrue);
    expect(routes[1].isRecommended, isTrue);
    expect(routes.last.isRecommended, isFalse);
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
  container.read(depositDirectoryProvider.future),
  container.read(depositsProvider(null).future),
  container.read(depositProvider('deposit-1').future),
]);

final class _FundingRepository implements FundingRepository {
  int listCalls = 0;
  int getCalls = 0;
  int directoryCalls = 0;

  ResourceResult<Deposit> get _deposit => ResourceResult(
    resource: const Deposit(
      depositId: 'deposit-1',
      chain: 'BSC',
      token: 'USDC',
      status: DepositState.awaiting,
      instructions: DepositInstructions(address: '0x123'),
    ),
  );

  @override
  Future<DepositDirectory> getDepositDirectory() async {
    directoryCalls++;
    return DepositDirectory(
      updatedAt: DateTime.utc(2026),
      walletAddress: '0x123',
      instructions: [
        for (final route in const [
          ('Arbitrum', 'USDC', '1', 20),
          ('BSC', 'USDT', '1', 15),
          ('BSC', 'USDC', '1', 15),
        ])
          DepositInstruction(
            chain: route.$1,
            token: route.$2,
            tokenContract: '0x${route.$2.toLowerCase()}',
            tokenDecimals: 6,
            address: '0x123',
            qrPayload: 'ethereum:0x${route.$2.toLowerCase()}',
            minimumAmount: DecimalValue(
              route.$3,
              asset: route.$2,
              unit: 'token',
            ),
            confirmationsRequired: route.$4,
            estimatedArrivalSeconds: 60,
            warning: 'Send ${route.$2} only.',
          ),
      ],
    );
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
