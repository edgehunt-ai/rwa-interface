import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  test('failure 具备值语义且仅保存安全字段', () {
    const first = ServerFailure(
      statusCode: 422,
      code: 'insufficient_funds',
      requestId: 'req-1',
      retryable: false,
      userAction: 'deposit',
      details: {'field': 'amount'},
    );
    const second = ServerFailure(
      statusCode: 422,
      code: 'insufficient_funds',
      requestId: 'req-1',
      retryable: false,
      userAction: 'deposit',
      details: {'field': 'amount'},
    );
    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(first.toString(), isNot(contains('token')));
  });
}
