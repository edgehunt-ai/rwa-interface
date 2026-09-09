// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_data_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioDataStatus _$complete = const PortfolioDataStatus._('complete');
const PortfolioDataStatus _$partial = const PortfolioDataStatus._('partial');
const PortfolioDataStatus _$empty = const PortfolioDataStatus._('empty');
const PortfolioDataStatus _$unknownDefaultOpenApi =
    const PortfolioDataStatus._('unknownDefaultOpenApi');

PortfolioDataStatus _$valueOf(String name) {
  switch (name) {
    case 'complete':
      return _$complete;
    case 'partial':
      return _$partial;
    case 'empty':
      return _$empty;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioDataStatus> _$values =
    BuiltSet<PortfolioDataStatus>(const <PortfolioDataStatus>[
  _$complete,
  _$partial,
  _$empty,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioDataStatusMeta {
  const _$PortfolioDataStatusMeta();
  PortfolioDataStatus get complete => _$complete;
  PortfolioDataStatus get partial => _$partial;
  PortfolioDataStatus get empty => _$empty;
  PortfolioDataStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioDataStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioDataStatus> get values => _$values;
}

abstract class _$PortfolioDataStatusMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioDataStatusMeta get PortfolioDataStatus =>
      const _$PortfolioDataStatusMeta();
}

Serializer<PortfolioDataStatus> _$portfolioDataStatusSerializer =
    _$PortfolioDataStatusSerializer();

class _$PortfolioDataStatusSerializer
    implements PrimitiveSerializer<PortfolioDataStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'complete': 'complete',
    'partial': 'partial',
    'empty': 'empty',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'complete': 'complete',
    'partial': 'partial',
    'empty': 'empty',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioDataStatus];
  @override
  final String wireName = 'PortfolioDataStatus';

  @override
  Object serialize(Serializers serializers, PortfolioDataStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioDataStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioDataStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
