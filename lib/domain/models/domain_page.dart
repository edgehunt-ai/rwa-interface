final class DomainPage<T> {
  const DomainPage({required this.items, this.nextCursor});

  final List<T> items;
  final String? nextCursor;
}
