import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/realtime_replay_guard.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

const stream = '11111111111111111111111111111111';
RealtimeEnvelope event(String id, [String name = 'hip3_price']) =>
    RealtimeEnvelope(eventId: id, eventName: name, data: const {});

void main() {
  test(
    'HIP3 retains constant replay state with exact web-safe i64 ordering',
    () {
      final guard = RealtimeReplayGuard();
      final start = BigInt.parse('9007199254740992');
      for (var i = 0; i < 2000; i++) {
        expect(
          guard.accept(event('h3.$stream.${start + BigInt.from(i)}')),
          isTrue,
        );
        expect(guard.retainedIdCount, 1);
      }
      expect(guard.accept(event('h3.$stream.$start')), isFalse);
      expect(
        guard.accept(event('h3.$stream.${start + BigInt.from(1999)}')),
        isFalse,
      );
      expect(guard.accept(event('h3.$stream.9223372036854775807')), isTrue);
      expect(
        () => guard.accept(event('h3.22222222222222222222222222222222.1')),
        throwsA(isA<CompatibilityFailure>()),
      );
    },
  );

  test(
    'generic replay memory is bounded and recovery instructions bypass it',
    () {
      final guard = RealtimeReplayGuard(capacity: 8);
      for (var i = 0; i < 1000; i++) {
        expect(guard.accept(event('$i', 'price')), isTrue);
        expect(guard.retainedIdCount, lessThanOrEqualTo(8));
      }
      expect(guard.accept(event('999', 'price')), isFalse);
      expect(guard.accept(event('999', 'resync_required')), isTrue);
    },
  );

  test('HIP3 cursor rejects malformed, foreign-format and overflowing IDs', () {
    for (final value in [
      '1',
      'h3.$stream.01',
      'h3.$stream.-1',
      'h3.$stream.9223372036854775808',
      'h3.$stream.1\n',
    ]) {
      expect(
        () => Hip3EventCursor.parse(value),
        throwsA(isA<CompatibilityFailure>()),
      );
    }
  });
}
