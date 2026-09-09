import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/idempotent_command_guard.dart';

void main() {
  group('IdempotentCommandGuard', () {
    test(
      'supports an immediately completed command and clears it for retry',
      () async {
        final guard = IdempotentCommandGuard();
        var calls = 0;

        Future<String> run() => guard.run(
          operation: 'funding-transfer',
          fingerprint: 'plan-1|authorization-1',
          command: (_) async {
            calls++;
            return 'completed';
          },
        );

        expect(await run(), 'completed');
        expect(await run(), 'completed');
        expect(calls, 2);
      },
    );
  });
}
