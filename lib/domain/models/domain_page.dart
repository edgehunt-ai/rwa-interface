import 'portfolio_read_status.dart';

final class DomainPage<T> {
  const DomainPage({
    required this.items,
    this.nextCursor,
    this.hasMore = false,
    this.portfolioStatus,
  });

  final List<T> items;
  final String? nextCursor;
  final bool hasMore;
  final PortfolioReadStatus? portfolioStatus;
}
