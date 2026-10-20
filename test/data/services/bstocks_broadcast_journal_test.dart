import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/data/services/bstocks_broadcast_journal.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/order.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('historical hash remains read-only across reconstruction', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, '0xhash');
    for (var attempt = 0; attempt < 2; attempt++) {
      expect(
        await BstocksBroadcastJournal.persistent().transactionHash(_action),
        '0xhash',
      );
    }
    expect(prefs.getString(_key), '0xhash');
  });

  test('historical pending marker cannot authorize a new relay', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, '');
    for (var attempt = 0; attempt < 2; attempt++) {
      await expectLater(
        BstocksBroadcastJournal.persistent().transactionHash(_action),
        throwsA(isA<UnknownFailure>()),
      );
    }
    expect(prefs.getString(_key), '');
  });

  test('missing history does not write a broadcast marker', () async {
    expect(
      await BstocksBroadcastJournal.persistent().transactionHash(_action),
      isNull,
    );
    expect((await SharedPreferences.getInstance()).containsKey(_key), isFalse);
  });
}

const _key = 'bstocks.broadcast.56.0x1.order-1.action-1';

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
