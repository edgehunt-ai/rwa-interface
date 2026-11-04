/// The server's decision for the current request IP, independent of locale.
final class AccessRegion {
  AccessRegion({
    required this.countryCode,
    required this.source,
    required this.restricted,
    required Iterable<String> restrictedCountries,
    required Iterable<RestrictedRegion> restrictedRegions,
  }) : restrictedCountries = List.unmodifiable(restrictedCountries),
       restrictedRegions = List.unmodifiable(restrictedRegions);

  final String? countryCode;
  final String source;
  final bool restricted;
  final List<String> restrictedCountries;
  final List<RestrictedRegion> restrictedRegions;
}

/// Server-maintained display name; list order is preserved by [AccessRegion].
final class RestrictedRegion {
  const RestrictedRegion({required this.countryCode, required this.name});

  final String countryCode;
  final String name;
}
