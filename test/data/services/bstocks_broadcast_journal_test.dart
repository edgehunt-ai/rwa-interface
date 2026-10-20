import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/data/services/bstocks_broadcast_journal.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/order.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('broadcast hash survives journal reconstruction', () async {
    var sends = 0;
    Future<String> send() async {
      sends++;
      return '0xhash';
    }

    await BstocksBroadcastJournal.persistent().broadcast(_action, send);
    expect(
      await BstocksBroadcastJournal.persistent().broadcast(_action, send),
      '0xhash',
    );
    expect(sends, 1);
  });

  test(
    'unknown wallet outcome blocks rebroadcast after reconstruction',
    () async {
      var sends = 0;
      Future<String> send() async {
        sends++;
        throw const NetworkFailure();
      }

      await expectLater(
        BstocksBroadcastJournal.persistent().broadcast(_action, send),
        throwsA(isA<NetworkFailure>()),
      );
      await expectLater(
        BstocksBroadcastJournal.persistent().broadcast(_action, send),
        throwsA(isA<UnknownFailure>()),
      );
      expect(sends, 1);
    },
  );

  test('explicit rejection permits a later wallet request', () async {
    await expectLater(
      BstocksBroadcastJournal.persistent().broadcast(
        _action,
        () async => throw const CancelledFailure(),
      ),
      throwsA(isA<CancelledFailure>()),
    );
    expect(
      await BstocksBroadcastJournal.persistent().broadcast(
        _action,
        () async => '0xhash',
      ),
      '0xhash',
    );
  });

  test(
    'a proven pre-broadcast failure permits retry after reconstruction',
    () async {
      await expectLater(
        BstocksBroadcastJournal.persistent().broadcast(
          _action,
          () async =>
              throw const WalletTransactionNotBroadcastFailure(retryable: true),
        ),
        throwsA(isA<WalletTransactionNotBroadcastFailure>()),
      );
      expect(
        await BstocksBroadcastJournal.persistent().broadcast(
          _action,
          () async => '0xhash',
        ),
        '0xhash',
      );
    },
  );

  test('concurrent recovery callers share one broadcast', () async {
    final journal = BstocksBroadcastJournal.persistent();
    var sends = 0;
    Future<String> send() async {
      sends++;
      return '0xhash';
    }

    final hashes = await Future.wait(
      List.generate(5, (_) => journal.broadcast(_action, send)),
    );
    expect(hashes, everyElement('0xhash'));
    expect(sends, 1);
  });
}

final _action = BstocksOrderAction(
  orderId: 'order-1',
  actionId: 'action-1',
  kind: BstocksOrderActionKind.executeIocOrder,
  chainId: 56,
  from: '0x1',
  to: '0x2',
  data: '0xaa',
  value: '0x0',
  payloadHash: 'hash',
  validUntil: DateTime.utc(2030),
  status: BstocksOrderActionStatus.awaitingSignature,
);
