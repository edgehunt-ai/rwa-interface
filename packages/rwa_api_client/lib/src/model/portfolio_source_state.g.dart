// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_source_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioSourceState _$available =
    const PortfolioSourceState._('available');
const PortfolioSourceState _$unavailable =
    const PortfolioSourceState._('unavailable');
const PortfolioSourceState _$unknownDefaultOpenApi =
    const PortfolioSourceState._('unknownDefaultOpenApi');

PortfolioSourceState _$valueOf(String name) {
  switch (name) {
    case 'available':
      return _$available;
    case 'unavailable':
      return _$unavailable;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioSourceState> _$values =
    BuiltSet<PortfolioSourceState>(const <PortfolioSourceState>[
  _$available,
  _$unavailable,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioSourceStateMeta {
  const _$PortfolioSourceStateMeta();
  PortfolioSourceState get available => _$available;
  PortfolioSourceState get unavailable => _$unavailable;
  PortfolioSourceState get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioSourceState valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioSourceState> get values => _$values;
}

abstract class _$PortfolioSourceStateMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioSourceStateMeta get PortfolioSourceState =>
      const _$PortfolioSourceStateMeta();
}

Serializer<PortfolioSourceState> _$portfolioSourceStateSerializer =
    _$PortfolioSourceStateSerializer();

class _$PortfolioSourceStateSerializer
    implements PrimitiveSerializer<PortfolioSourceState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioSourceState];
  @override
  final String wireName = 'PortfolioSourceState';

  @override
  Object serialize(Serializers serializers, PortfolioSourceState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioSourceState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioSourceState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
