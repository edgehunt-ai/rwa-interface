// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionMode _$default_ =
    const Hip3AccountAbstractionMode._('default_');
const Hip3AccountAbstractionMode _$unifiedAccount =
    const Hip3AccountAbstractionMode._('unifiedAccount');
const Hip3AccountAbstractionMode _$portfolioMargin =
    const Hip3AccountAbstractionMode._('portfolioMargin');
const Hip3AccountAbstractionMode _$unknownDefaultOpenApi =
    const Hip3AccountAbstractionMode._('unknownDefaultOpenApi');

Hip3AccountAbstractionMode _$valueOf(String name) {
  switch (name) {
    case 'default_':
      return _$default_;
    case 'unifiedAccount':
      return _$unifiedAccount;
    case 'portfolioMargin':
      return _$portfolioMargin;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AccountAbstractionMode> _$values =
    BuiltSet<Hip3AccountAbstractionMode>(const <Hip3AccountAbstractionMode>[
  _$default_,
  _$unifiedAccount,
  _$portfolioMargin,
  _$unknownDefaultOpenApi,
]);

class _$Hip3AccountAbstractionModeMeta {
  const _$Hip3AccountAbstractionModeMeta();
  Hip3AccountAbstractionMode get default_ => _$default_;
  Hip3AccountAbstractionMode get unifiedAccount => _$unifiedAccount;
  Hip3AccountAbstractionMode get portfolioMargin => _$portfolioMargin;
  Hip3AccountAbstractionMode get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  Hip3AccountAbstractionMode valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3AccountAbstractionMode> get values => _$values;
}

abstract class _$Hip3AccountAbstractionModeMixin {
  // ignore: non_constant_identifier_names
  _$Hip3AccountAbstractionModeMeta get Hip3AccountAbstractionMode =>
      const _$Hip3AccountAbstractionModeMeta();
}

Serializer<Hip3AccountAbstractionMode> _$hip3AccountAbstractionModeSerializer =
    _$Hip3AccountAbstractionModeSerializer();

class _$Hip3AccountAbstractionModeSerializer
    implements PrimitiveSerializer<Hip3AccountAbstractionMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'default_': 'default',
    'unifiedAccount': 'unifiedAccount',
    'portfolioMargin': 'portfolioMargin',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'default': 'default_',
    'unifiedAccount': 'unifiedAccount',
    'portfolioMargin': 'portfolioMargin',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3AccountAbstractionMode];
  @override
  final String wireName = 'Hip3AccountAbstractionMode';

  @override
  Object serialize(Serializers serializers, Hip3AccountAbstractionMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionMode deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
