import '../../domain/models/domain_page.dart';
import '../../domain/models/stock.dart';
import '../../domain/repositories/markets_repository.dart';
import '../services/markets_service.dart';

final class MarketsRepositoryImpl implements MarketsRepository {
  MarketsRepositoryImpl(this._service);
  final MarketsService _service;

  @override
  Future<DomainPage<Stock>> listStocks() async {
    final page = await _service.listStocks();
    return DomainPage(
      items: page.items
          .map(
            (group) => Stock(
              symbol: group.stock.symbol,
              name: group.stock.name,
              referencePrice: group.stock.referencePrice,
            ),
          )
          .toList(growable: false),
      nextCursor: page.nextCursor,
    );
  }
}
