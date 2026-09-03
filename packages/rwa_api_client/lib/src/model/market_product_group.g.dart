// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_product_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MarketProductGroup _$hot = const MarketProductGroup._('hot');
const MarketProductGroup _$gainers = const MarketProductGroup._('gainers');
const MarketProductGroup _$losers = const MarketProductGroup._('losers');
const MarketProductGroup _$volume = const MarketProductGroup._('volume');
const MarketProductGroup _$favorites = const MarketProductGroup._('favorites');
const MarketProductGroup _$unknownDefaultOpenApi =
    const MarketProductGroup._('unknownDefaultOpenApi');

MarketProductGroup _$valueOf(String name) {
  switch (name) {
    case 'hot':
      return _$hot;
    case 'gainers':
      return _$gainers;
    case 'losers':
      return _$losers;
    case 'volume':
      return _$volume;
    case 'favorites':
      return _$favorites;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<MarketProductGroup> _$values =
    BuiltSet<MarketProductGroup>(const <MarketProductGroup>[
  _$hot,
  _$gainers,
  _$losers,
  _$volume,
  _$favorites,
  _$unknownDefaultOpenApi,
]);

class _$MarketProductGroupMeta {
  const _$MarketProductGroupMeta();
  MarketProductGroup get hot => _$hot;
  MarketProductGroup get gainers => _$gainers;
  MarketProductGroup get losers => _$losers;
  MarketProductGroup get volume => _$volume;
  MarketProductGroup get favorites => _$favorites;
  MarketProductGroup get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  MarketProductGroup valueOf(String name) => _$valueOf(name);
  BuiltSet<MarketProductGroup> get values => _$values;
}

abstract class _$MarketProductGroupMixin {
  // ignore: non_constant_identifier_names
  _$MarketProductGroupMeta get MarketProductGroup =>
      const _$MarketProductGroupMeta();
}

Serializer<MarketProductGroup> _$marketProductGroupSerializer =
    _$MarketProductGroupSerializer();

class _$MarketProductGroupSerializer
    implements PrimitiveSerializer<MarketProductGroup> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hot': 'hot',
    'gainers': 'gainers',
    'losers': 'losers',
    'volume': 'volume',
    'favorites': 'favorites',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hot': 'hot',
    'gainers': 'gainers',
    'losers': 'losers',
    'volume': 'volume',
    'favorites': 'favorites',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MarketProductGroup];
  @override
  final String wireName = 'MarketProductGroup';

  @override
  Object serialize(Serializers serializers, MarketProductGroup object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MarketProductGroup deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MarketProductGroup.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
