import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_wallet_history.dart';
import '../api/api_failure_mapper.dart';

abstract interface class Hip3WalletHistoryService {
  Future<api.Hip3FundingPaymentPage> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  });
  Future<api.Hip3LiquidationPage> liquidations(
    Hip3HistoryQuery query, {
    String? cursor,
  });
}

final class GeneratedHip3WalletHistoryService
    implements Hip3WalletHistoryService {
  GeneratedHip3WalletHistoryService(this._api);
  final api.OrdersApi _api;
  @override
  Future<api.Hip3FundingPaymentPage> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async {
    try {
      return (await _api.listHip3FundingPayments(
            from: query.from,
            to: query.to,
            source_: query.source.name,
            productId: query.productId,
            cursor: cursor,
          )).data ??
          (throw const DecodingFailure());
    } on DioException catch (error) {
      throw const ApiFailureMapper().fromDio(error);
    }
  }

  @override
  Future<api.Hip3LiquidationPage> liquidations(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async {
    try {
      return (await _api.listHip3Liquidations(
            from: query.from,
            to: query.to,
            source_: query.source.name,
            productId: query.productId,
            cursor: cursor,
          )).data ??
          (throw const DecodingFailure());
    } on DioException catch (error) {
      throw const ApiFailureMapper().fromDio(error);
    }
  }
}
