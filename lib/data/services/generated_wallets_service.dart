import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../api/api_failure_mapper.dart';
import 'wallets_service.dart';

final class GeneratedWalletsService implements WalletsService {
  GeneratedWalletsService(this._api, {this._mapper = const ApiFailureMapper()});

  final api.WalletsApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.WalletPage> listWallets({String? cursor}) =>
      _body(() => _api.listWallets(cursor: cursor));

  @override
  Future<api.Wallet> syncWallet({required String idempotencyKey}) =>
      _body(() => _api.syncWallet(idempotencyKey: idempotencyKey));

  @override
  Future<api.WalletAuthorization> createAuthorization(
    String walletId,
    api.WalletAuthorizationRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createWalletAuthorization(
      walletId: walletId,
      idempotencyKey: idempotencyKey,
      walletAuthorizationRequest: request,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) {
        throw DecodingFailure(
          requestId: response.headers.value('x-request-id'),
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
