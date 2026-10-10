import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/api/idempotency_key.dart';

void main() {
  final uuid = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
  );

  test('fresh and scoped idempotency keys are UUIDs', () {
    expect(newIdempotencyKey(), matches(uuid));
    expect(scopedIdempotencyKey('order-1/action-1'), matches(uuid));
  });

  test('scoped idempotency keys remain stable for retries', () {
    expect(
      scopedIdempotencyKey('order-1/action-1'),
      scopedIdempotencyKey('order-1/action-1'),
    );
    expect(
      scopedIdempotencyKey('order-1/action-1'),
      isNot(scopedIdempotencyKey('order-1/action-2')),
    );
  });
}
