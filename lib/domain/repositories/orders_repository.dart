import '../models/domain_page.dart';
import '../models/order.dart';
import '../models/order_intent.dart';
import '../models/order_preview.dart';
import '../models/resource_result.dart';

abstract interface class OrdersRepository {
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  });
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  });
  Future<DomainPage<ResourceResult<TradingOrder>>> list({String? cursor});
  Future<ResourceResult<TradingOrder>> get(String orderId);
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  });
}
