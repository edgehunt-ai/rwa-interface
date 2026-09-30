import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class Hip3WithdrawalService {
  Future<api.Hip3WithdrawalPreview> preview(
    api.Hip3WithdrawalCreateRequest request,
  );

  Future<api.Hip3Withdrawal> create(
    api.Hip3WithdrawalCreateRequest request, {
    required String idempotencyKey,
  });

  Future<api.Hip3Withdrawal> submit(
    String id,
    api.Hip3WithdrawalSubmissionRequest request, {
    required String idempotencyKey,
  });

  Future<api.Hip3Withdrawal> get(String id);
}

final class GeneratedHip3WithdrawalService implements Hip3WithdrawalService {
  GeneratedHip3WithdrawalService(
    this._api, {
    this.mapper = const ApiFailureMapper(),
  });

  final api.FundingApi _api;
  final ApiFailureMapper mapper;

  @override
  Future<api.Hip3WithdrawalPreview> preview(
    api.Hip3WithdrawalCreateRequest request,
  ) => _body(
    () => _api.previewHip3Withdrawal(hip3WithdrawalCreateRequest: request),
  );

  @override
  Future<api.Hip3Withdrawal> create(
    api.Hip3WithdrawalCreateRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createHip3Withdrawal(
      idempotencyKey: idempotencyKey,
      hip3WithdrawalCreateRequest: request,
    ),
  );

  @override
  Future<api.Hip3Withdrawal> submit(
    String id,
    api.Hip3WithdrawalSubmissionRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.submitHip3Withdrawal(
      withdrawalId: id,
      idempotencyKey: idempotencyKey,
      hip3WithdrawalSubmissionRequest: request,
    ),
  );

  @override
  Future<api.Hip3Withdrawal> get(String id) =>
      _body(() => _api.getHip3Withdrawal(withdrawalId: id));

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      throw mapper.fromDio(error);
    }
  }
}
