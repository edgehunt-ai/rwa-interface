import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';
import 'package:rwa_interface/app/providers/hip3_live_scope.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/wallet.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';

Wallet wallet(
  String id, {
  String chain = 'hyperliquid',
  WalletState status = WalletState.active,
}) => Wallet(
  walletId: id,
  address: '0x1111111111111111111111111111111111111111',
  chain: chain,
  status: status,
  createdAt: DateTime.utc(2026),
);

final class Wallets implements WalletsRepository {
  Wallets(this.read);
  final Future<DomainPage<Wallet>> Function(String? cursor) read;
  final cursors = <String?>[];
  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) {
    cursors.add(cursor);
    return read(cursor);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

ProviderContainer setup(
  Wallets wallets, {
  bool enabled = true,
  String environment = 'testnet',
}) {
  final container = ProviderContainer(
    overrides: [
      walletsRepositoryProvider.overrideWithValue(wallets),
      hip3LiveEnabledProvider.overrideWithValue(enabled),
      hip3AccountEnvironmentProvider.overrideWithValue(environment),
    ],
  );
  addTearDown(container.dispose);
  final subscription = container.listen(hip3LiveIdentityProvider, (_, _) {});
  addTearDown(subscription.close);
  return container;
}

void main() {
  test('disabled makes no wallet calls; invalid deployment environment fails closed', () async {
    final wallets = Wallets((_) async => DomainPage(items: [wallet('a')]));
    final disabled = setup(wallets, enabled: false);
    expect(await disabled.read(hip3LiveIdentityProvider.future), isNull);
    expect(wallets.cursors, isEmpty);
    final invalid = setup(wallets, environment: 'devnet');
    await expectLater(
      invalid.read(hip3LiveIdentityProvider.future),
      throwsA(isA<CompatibilityFailure>()),
    );
    expect(wallets.cursors, isEmpty);
  });
  test(
    'resolves only the unique active Hyperliquid wallet across all pages',
    () async {
      final wallets = Wallets(
        (cursor) async => cursor == null
            ? DomainPage(
                items: [
                  wallet('eth', chain: 'ethereum'),
                  wallet('old', status: WalletState.disabled),
                ],
                hasMore: true,
                nextCursor: 'next',
              )
            : DomainPage(items: [wallet('current')]),
      );
      final c = setup(wallets);
      final identity = (await c.read(hip3LiveIdentityProvider.future))!;
      expect(identity.signer, wallet('current').address);
      expect(identity.environment, 'testnet');
      expect(identity.generation, 0);
      expect(wallets.cursors, [null, 'next']);
    },
  );
  test(
    'ambiguous, missing and repeated-wallet pages cannot choose a signer',
    () async {
      for (final items in [
        <Wallet>[],
        [wallet('a'), wallet('b')],
        [wallet('a'), wallet('a')],
      ]) {
        final wallets = Wallets((_) async => DomainPage(items: items));
        final c = setup(wallets);
        await expectLater(
          c.read(hip3LiveIdentityProvider.future),
          throwsA(isA<ApiFailure>()),
        );
        expect(wallets.cursors, hasLength(1));
      }
    },
  );
  test('repeated pagination cursor terminates instead of looping', () async {
    var count = 0;
    final wallets = Wallets(
      (_) async => DomainPage(
        items: [wallet('id-${count++}', chain: 'ethereum')],
        hasMore: true,
        nextCursor: 'same',
      ),
    );
    final c = setup(wallets);
    await expectLater(
      c.read(hip3LiveIdentityProvider.future),
      throwsA(isA<CompatibilityFailure>()),
    );
    expect(wallets.cursors, [null, 'same']);
  });
  test(
    'a late wallet response cannot restore the previous session scope',
    () async {
      final pending = Completer<DomainPage<Wallet>>();
      var reads = 0;
      final wallets = Wallets(
        (_) => reads++ == 0
            ? pending.future
            : Future.value(DomainPage(items: [wallet('new')])),
      );
      final c = setup(wallets);
      final old = c.read(hip3LiveIdentityProvider.future);
      final ignoredOld = old.then<Object?>(
        (value) => value,
        onError: (Object error) => error,
      );
      await pumpEventQueue();
      c.read(sessionGenerationProvider.notifier).clearUserScope();
      await pumpEventQueue();
      final identity = (await c.read(hip3LiveIdentityProvider.future))!;
      expect(identity.generation, 1);
      pending.complete(DomainPage(items: [wallet('old')]));
      await ignoredOld;
      await pumpEventQueue();
      expect(c.read(hip3LiveIdentityProvider).asData!.value!.generation, 1);
    },
  );
}
