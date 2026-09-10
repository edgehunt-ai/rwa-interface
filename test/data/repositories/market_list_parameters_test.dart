import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_markets_service.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:rwa_interface/domain/models/market_product.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  for (final group in MarketListGroup.values) {
    for (final kind in [null, ...MarketProductKind.values]) {
      test(
        'repository → service → HTTP preserves $kind/$group and opaque pagination',
        () async {
          final source = RwaApiDataSource.create(
            tokenProvider: FakePrivyAccessTokenProvider(),
            environment: const ApiEnvironment(
              baseUrl: 'https://controlled.invalid',
            ),
          );
          source.dio.httpClientAdapter = ControlledApiAdapter([
            ControlledResponse.json(
              method: 'GET',
              path: '/v1/markets/products',
              statusCode: 200,
              body: {
                'items': [
                  {'symbol': 'GOLD', 'kind': 'perp', 'price': '3210.000001'},
                ],
                'has_more': true,
                'next_cursor': 'next:opaque',
              },
            ),
          ]);
          addTearDown(() => source.dio.close());
          RequestOptions? request;
          source.dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                request = options;
                handler.next(options);
              },
            ),
          );
          final repository = MarketsRepositoryImpl(
            GeneratedMarketsService(source.client.getMarketsApi()),
          );
          final page = await repository.listProducts(
            kind: kind,
            group: group,
            query: 'gold',
            cursor: 'cursor:opaque',
            limit: 37,
          );
          expect(request!.queryParameters, {
            'group': group.name,
            if (kind != null)
              'product_type': kind == MarketProductKind.perp
                  ? 'contract'
                  : 'spot',
            'q': 'gold',
            'cursor': 'cursor:opaque',
            'limit': 37,
          });
          expect(page.nextCursor, 'next:opaque');
          expect(page.hasMore, isTrue);
          expect(page.items.single.price.value, '3210.000001');
        },
      );
    }
  }
}
