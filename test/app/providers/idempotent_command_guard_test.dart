import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/idempotent_command_guard.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('IdempotentCommandGuard', () {
    test(
      'supports an immediately completed command and clears it for retry',
      () async {
        final guard = IdempotentCommandGuard();
        var calls = 0;
        final keys = <String>[];

        Future<String> run() => guard.run(
          operation: 'funding-transfer',
          fingerprint: 'plan-1|authorization-1',
          command: (key) async {
            calls++;
            keys.add(key);
            return 'completed';
          },
        );

        expect(await run(), 'completed');
        expect(await run(), 'completed');
        expect(calls, 2);
        expect(keys.toSet(), hasLength(1));
        expect(Uuid.isValidUUID(fromString: keys.first), isTrue);
      },
    );

    test('uses a fresh UUID for a replacement command scope', () async {
      Future<String> keyFrom(IdempotentCommandGuard guard) => guard.run(
        operation: 'set-leverage',
        fingerprint: 'position-1|2',
        command: (key) async => key,
      );

      final first = await keyFrom(IdempotentCommandGuard());
      final second = await keyFrom(IdempotentCommandGuard());

      expect(Uuid.isValidUUID(fromString: first), isTrue);
      expect(Uuid.isValidUUID(fromString: second), isTrue);
      expect(second, isNot(first));
    });
  });
}
