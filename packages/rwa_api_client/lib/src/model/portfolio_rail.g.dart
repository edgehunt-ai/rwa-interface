// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioRail _$bstock = const PortfolioRail._('bstock');
const PortfolioRail _$perp = const PortfolioRail._('perp');
const PortfolioRail _$cash = const PortfolioRail._('cash');
const PortfolioRail _$unknownDefaultOpenApi =
    const PortfolioRail._('unknownDefaultOpenApi');

PortfolioRail _$valueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstock;
    case 'perp':
      return _$perp;
    case 'cash':
      return _$cash;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioRail> _$values =
    BuiltSet<PortfolioRail>(const <PortfolioRail>[
  _$bstock,
  _$perp,
  _$cash,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioRailMeta {
  const _$PortfolioRailMeta();
  PortfolioRail get bstock => _$bstock;
  PortfolioRail get perp => _$perp;
  PortfolioRail get cash => _$cash;
  PortfolioRail get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioRail valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioRail> get values => _$values;
}

abstract class _$PortfolioRailMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioRailMeta get PortfolioRail => const _$PortfolioRailMeta();
}

Serializer<PortfolioRail> _$portfolioRailSerializer =
    _$PortfolioRailSerializer();

class _$PortfolioRailSerializer implements PrimitiveSerializer<PortfolioRail> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'perp': 'perp',
    'cash': 'cash',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'perp': 'perp',
    'cash': 'cash',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioRail];
  @override
  final String wireName = 'PortfolioRail';

  @override
  Object serialize(Serializers serializers, PortfolioRail object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioRail deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioRail.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
