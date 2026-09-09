import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/unsupported_capability.dart';

void main() {
  test('only exposes the two stable non-retryable capabilities', () {
    const order = UnsupportedCapability.orderSignature(resourceId: 'ord-1');
    const funding = UnsupportedCapability.fundingTransfer(resourceId: 'dep-1');
    expect(order.code, 'order_signature_not_supported');
    expect(funding.code, 'funding_transfer_not_supported');
    expect(order.userAction, 'wait_for_feature');
    expect(order.retryable, isFalse);
    expect(order.resourceId, 'ord-1');
  });
}
