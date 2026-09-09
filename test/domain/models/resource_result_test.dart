import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/unsupported_capability.dart';

void main() {
  test('returns a resource with an optional capability, not a failure', () {
    const result = ResourceResult(
      resource: 'ord-1',
      capability: UnsupportedCapability.orderSignature(resourceId: 'ord-1'),
    );
    expect(result.resource, 'ord-1');
    expect(result.capability?.retryable, isFalse);
  });
}
