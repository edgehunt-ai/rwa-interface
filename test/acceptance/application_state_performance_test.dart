import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

void main() {
  test('100 controlled queries reach a consumable terminal state under one second p95', () async {
    final repository = _ControlledFundingRepository();
    final samples = <Duration>[];

    for (var index = 0; index < 100; index++) {
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(repository)],
      );
      final subscription = container.listen(fundingCatalogProvider, (_, _) {});
      final watch = Stopwatch()..start();
      final catalog = await container.read(fundingCatalogProvider.future);
      watch.stop();
      samples.add(watch.elapsed);
      expect(catalog.rails.single.network, 'BSC');
      subscription.close();
      container.dispose();
    }

    samples.sort();
    expect(repository.queries, 100);
    expect(samples[94], lessThan(const Duration(seconds: 1)));
  });
}

final class _ControlledFundingRepository implements FundingRepository {
  int queries = 0;

  @override
  Future<FundingCatalog> getCatalog() async {
    queries++;
    return FundingCatalog(
      rails: const [
        FundingRail(
          kind: FundingRailKind.bstock,
          network: 'BSC',
          settlementAsset: 'USDT',
        ),
      ],
      updatedAt: DateTime.utc(2026),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
