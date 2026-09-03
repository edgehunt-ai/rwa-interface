import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_diagnostics.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  test('诊断摘要不包含 token、stack、raw body 或金融 payload', () {
    const failure = ServerFailure(
      statusCode: 400,
      code: 'bad_request',
      requestId: 'req-safe',
      details: {
        'token': 'secret',
        'raw_body': {'amount': '999999.99'},
        'stack': 'private trace',
      },
    );
    final summary = safeFailureSummary(failure);
    expect(summary, 'server status=400 code=bad_request requestId=req-safe');
    expect(summary, isNot(contains('secret')));
    expect(summary, isNot(contains('999999')));
    expect(summary, isNot(contains('trace')));
  });
}
