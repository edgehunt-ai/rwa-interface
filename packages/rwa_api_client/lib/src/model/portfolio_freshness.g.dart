// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_freshness.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioFreshness _$live = const PortfolioFreshness._('live');
const PortfolioFreshness _$cached = const PortfolioFreshness._('cached');
const PortfolioFreshness _$stale = const PortfolioFreshness._('stale');
const PortfolioFreshness _$unknownDefaultOpenApi =
    const PortfolioFreshness._('unknownDefaultOpenApi');

PortfolioFreshness _$valueOf(String name) {
  switch (name) {
    case 'live':
      return _$live;
    case 'cached':
      return _$cached;
    case 'stale':
      return _$stale;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioFreshness> _$values =
    BuiltSet<PortfolioFreshness>(const <PortfolioFreshness>[
  _$live,
  _$cached,
  _$stale,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioFreshnessMeta {
  const _$PortfolioFreshnessMeta();
  PortfolioFreshness get live => _$live;
  PortfolioFreshness get cached => _$cached;
  PortfolioFreshness get stale => _$stale;
  PortfolioFreshness get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioFreshness valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioFreshness> get values => _$values;
}

abstract class _$PortfolioFreshnessMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioFreshnessMeta get PortfolioFreshness =>
      const _$PortfolioFreshnessMeta();
}

Serializer<PortfolioFreshness> _$portfolioFreshnessSerializer =
    _$PortfolioFreshnessSerializer();

class _$PortfolioFreshnessSerializer
    implements PrimitiveSerializer<PortfolioFreshness> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'live': 'live',
    'cached': 'cached',
    'stale': 'stale',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'live': 'live',
    'cached': 'cached',
    'stale': 'stale',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioFreshness];
  @override
  final String wireName = 'PortfolioFreshness';

  @override
  Object serialize(Serializers serializers, PortfolioFreshness object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioFreshness deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioFreshness.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
