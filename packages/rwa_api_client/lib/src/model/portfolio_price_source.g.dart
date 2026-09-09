// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_price_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioPriceSource _$fixedPeg =
    const PortfolioPriceSource._('fixedPeg');
const PortfolioPriceSource _$dodoex = const PortfolioPriceSource._('dodoex');
const PortfolioPriceSource _$unavailable =
    const PortfolioPriceSource._('unavailable');
const PortfolioPriceSource _$unknownDefaultOpenApi =
    const PortfolioPriceSource._('unknownDefaultOpenApi');

PortfolioPriceSource _$valueOf(String name) {
  switch (name) {
    case 'fixedPeg':
      return _$fixedPeg;
    case 'dodoex':
      return _$dodoex;
    case 'unavailable':
      return _$unavailable;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioPriceSource> _$values =
    BuiltSet<PortfolioPriceSource>(const <PortfolioPriceSource>[
  _$fixedPeg,
  _$dodoex,
  _$unavailable,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioPriceSourceMeta {
  const _$PortfolioPriceSourceMeta();
  PortfolioPriceSource get fixedPeg => _$fixedPeg;
  PortfolioPriceSource get dodoex => _$dodoex;
  PortfolioPriceSource get unavailable => _$unavailable;
  PortfolioPriceSource get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioPriceSource valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioPriceSource> get values => _$values;
}

abstract class _$PortfolioPriceSourceMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioPriceSourceMeta get PortfolioPriceSource =>
      const _$PortfolioPriceSourceMeta();
}

Serializer<PortfolioPriceSource> _$portfolioPriceSourceSerializer =
    _$PortfolioPriceSourceSerializer();

class _$PortfolioPriceSourceSerializer
    implements PrimitiveSerializer<PortfolioPriceSource> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'fixedPeg': 'fixed_peg',
    'dodoex': 'dodoex',
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'fixed_peg': 'fixedPeg',
    'dodoex': 'dodoex',
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioPriceSource];
  @override
  final String wireName = 'PortfolioPriceSource';

  @override
  Object serialize(Serializers serializers, PortfolioPriceSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioPriceSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioPriceSource.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
