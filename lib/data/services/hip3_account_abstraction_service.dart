import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class Hip3AccountAbstractionService {
  Future<api.Hip3AccountAbstraction> getStatus();

  Future<api.Hip3AccountAbstractionPreparation> prepare({
    required String idempotencyKey,
  });

  Future<api.Hip3AccountAbstraction> execute({
    required String idempotencyKey,
    required api.Hip3AccountAbstractionExecuteRequest request,
  });
}

final class GeneratedHip3AccountAbstractionService
    implements Hip3AccountAbstractionService {
  GeneratedHip3AccountAbstractionService(
    this._api, {
    this.mapper = const ApiFailureMapper(),
  });

  final api.OrdersApi _api;
  final ApiFailureMapper mapper;

  @override
  Future<api.Hip3AccountAbstraction> getStatus() =>
      _body(() => _api.getHip3AccountAbstraction());

  @override
  Future<api.Hip3AccountAbstractionPreparation> prepare({
    required String idempotencyKey,
  }) => _body(
    () => _api.prepareHip3AccountAbstraction(
      idempotencyKey: idempotencyKey,
      hip3AccountAbstractionPrepareRequest:
          api.Hip3AccountAbstractionPrepareRequest(
            (b) => b.targetMode = api
                .Hip3AccountAbstractionPrepareRequestTargetModeEnum
                .unifiedAccount,
          ),
    ),
  );

  @override
  Future<api.Hip3AccountAbstraction> execute({
    required String idempotencyKey,
    required api.Hip3AccountAbstractionExecuteRequest request,
  }) => _body(
    () => _api.executeHip3AccountAbstraction(
      idempotencyKey: idempotencyKey,
      hip3AccountAbstractionExecuteRequest: request,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      final body = response.data;
      if (body == null) throw const FormatException('Missing response body');
      return body;
    } on DioException catch (error) {
      throw mapper.fromDio(error);
    }
  }
}
