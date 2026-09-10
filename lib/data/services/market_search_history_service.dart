import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/market_product.dart';

abstract interface class MarketSearchHistoryService {
  Future<List<MarketProductRef>> read();

  Future<List<MarketProductRef>> record(MarketProductRef product);
}

final class SharedPreferencesMarketSearchHistoryService
    implements MarketSearchHistoryService {
  SharedPreferencesMarketSearchHistoryService({
    SharedPreferencesResolver? resolvePreferences,
  }) : _resolvePreferences =
           resolvePreferences ?? SharedPreferences.getInstance;

  static const _key = 'market_search_history';
  static const _maxEntries = 10;

  final SharedPreferencesResolver _resolvePreferences;

  @override
  Future<List<MarketProductRef>> read() async {
    final preferences = await _resolvePreferences();
    return _decode(preferences.getString(_key));
  }

  @override
  Future<List<MarketProductRef>> record(MarketProductRef product) async {
    final preferences = await _resolvePreferences();
    final updated = [
      product,
      ..._decode(preferences.getString(_key)).where((item) => item != product),
    ].take(_maxEntries).toList(growable: false);
    await preferences.setString(
      _key,
      jsonEncode([
        for (final item in updated)
          {'symbol': item.symbol, 'kind': item.kind.name},
      ]),
    );
    return updated;
  }

  List<MarketProductRef> _decode(String? value) {
    if (value == null || value.isEmpty) return const [];
    try {
      final decoded = jsonDecode(value);
      if (decoded is! List) return const [];
      return [
        for (final entry in decoded)
          if (entry case {'symbol': String symbol, 'kind': String kind})
            switch (kind) {
              'bstock' => MarketProductRef(
                symbol: symbol,
                kind: MarketProductKind.bstock,
              ),
              'perp' => MarketProductRef(
                symbol: symbol,
                kind: MarketProductKind.perp,
              ),
              _ => null,
            },
      ].whereType<MarketProductRef>().toList(growable: false);
    } on FormatException {
      return const [];
    }
  }
}

typedef SharedPreferencesResolver = Future<SharedPreferences> Function();
