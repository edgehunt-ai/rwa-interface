import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/api_failure.dart';

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
    expect(
      first.toString(),
      'ApiFailure(kind: validation, retryable: false, requestId: req-1)',
    );
    expect(first.toString(), isNot(contains('token')));
  });

  test('decoding diagnostics participate in value semantics', () {
    const diagnostics = (
      apiOperation: 'orders.get_hip3_action',
      responseModel: 'Hip3Action',
      httpStatus: 200,
      contentType: 'application/json',
      responseBodySize: 321,
      decoderError: 'generated_client',
    );
    const first = DecodingFailure(
      requestId: 'request-1',
      diagnostics: diagnostics,
    );
    const second = DecodingFailure(
      requestId: 'request-1',
      diagnostics: diagnostics,
    );

    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(first.toString(), isNot(contains('Hip3Action')));
  });
}
