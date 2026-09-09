// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_notice_severity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioNoticeSeverity _$info = const PortfolioNoticeSeverity._('info');
const PortfolioNoticeSeverity _$warning =
    const PortfolioNoticeSeverity._('warning');
const PortfolioNoticeSeverity _$error =
    const PortfolioNoticeSeverity._('error');
const PortfolioNoticeSeverity _$unknownDefaultOpenApi =
    const PortfolioNoticeSeverity._('unknownDefaultOpenApi');

PortfolioNoticeSeverity _$valueOf(String name) {
  switch (name) {
    case 'info':
      return _$info;
    case 'warning':
      return _$warning;
    case 'error':
      return _$error;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioNoticeSeverity> _$values =
    BuiltSet<PortfolioNoticeSeverity>(const <PortfolioNoticeSeverity>[
  _$info,
  _$warning,
  _$error,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioNoticeSeverityMeta {
  const _$PortfolioNoticeSeverityMeta();
  PortfolioNoticeSeverity get info => _$info;
  PortfolioNoticeSeverity get warning => _$warning;
  PortfolioNoticeSeverity get error => _$error;
  PortfolioNoticeSeverity get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioNoticeSeverity valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioNoticeSeverity> get values => _$values;
}

abstract class _$PortfolioNoticeSeverityMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioNoticeSeverityMeta get PortfolioNoticeSeverity =>
      const _$PortfolioNoticeSeverityMeta();
}

Serializer<PortfolioNoticeSeverity> _$portfolioNoticeSeveritySerializer =
    _$PortfolioNoticeSeveritySerializer();

class _$PortfolioNoticeSeveritySerializer
    implements PrimitiveSerializer<PortfolioNoticeSeverity> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'info': 'info',
    'warning': 'warning',
    'error': 'error',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'info': 'info',
    'warning': 'warning',
    'error': 'error',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioNoticeSeverity];
  @override
  final String wireName = 'PortfolioNoticeSeverity';

  @override
  Object serialize(Serializers serializers, PortfolioNoticeSeverity object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioNoticeSeverity deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioNoticeSeverity.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
