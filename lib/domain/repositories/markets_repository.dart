import '../models/domain_page.dart';
import '../models/stock.dart';

abstract interface class MarketsRepository {
  Future<DomainPage<Stock>> listStocks();
}
