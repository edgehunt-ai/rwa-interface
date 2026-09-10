import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  test(
    'control submissions use action step route and signature-only body',
    () async {
      RequestOptions? captured;
      final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            captured = request;
            handler.reject(
              DioException(
                requestOptions: request,
                type: DioExceptionType.connectionError,
              ),
            );
          },
        ),
      );
      final service = GeneratedHip3PositionActionService(
        api.RwaApiClient(dio: dio).getOrdersApi(),
      );
      final request = api.Hip3ActionSubmissionRequest(
        (b) => b.signature
          ..r = '0x${'1' * 64}'
          ..s = '0x${'2' * 64}'
          ..v = api.HyperliquidSignatureVEnum.number27,
      );
      await expectLater(
        service.submit('action-1', 'step-2', request, 'retry-key'),
        throwsA(isA<ApiFailure>()),
      );
      expect(
        captured!.path,
        '/v1/hip3/actions/action-1/steps/step-2/submissions',
      );
      expect(captured!.method, 'POST');
      expect(captured!.headers['Idempotency-Key'], 'retry-key');
      expect((captured!.data as Map).keys, ['signature']);
      // Public synthetic fixture only; no wallet signing or network broadcast.
    },
  );
}
