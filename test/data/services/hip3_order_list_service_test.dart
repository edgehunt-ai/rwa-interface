import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/services/generated_orders_service.dart';

void main() {
  test(
    'perp list includes kind and leaves the unscoped request unchanged',
    () async {
      final queries = <Map<String, dynamic>>[];
      final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            queries.add(Map.of(request.queryParameters));
            handler.resolve(
              Response(
                requestOptions: request,
                statusCode: 200,
                data: {
                  'items': <Object>[],
                  'has_more': false,
                  'next_cursor': null,
                },
              ),
            );
          },
        ),
      );
      final service = GeneratedOrdersService(
        api.RwaApiClient(dio: dio).getOrdersApi(),
      );
      await service.listOrders(kind: api.ProductKind.perp, cursor: 'cursor-1');
      await service.listOrders();
      expect(queries[0]['kind'], 'perp');
      expect(queries[0]['cursor'], 'cursor-1');
      expect(queries[1]['kind'], isNull);
    },
  );
}
