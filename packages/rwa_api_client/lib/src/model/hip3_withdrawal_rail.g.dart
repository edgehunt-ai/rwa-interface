// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalRail _$bridge2 = const Hip3WithdrawalRail._('bridge2');
const Hip3WithdrawalRail _$float = const Hip3WithdrawalRail._('float');
const Hip3WithdrawalRail _$unknownDefaultOpenApi =
    const Hip3WithdrawalRail._('unknownDefaultOpenApi');

Hip3WithdrawalRail _$valueOf(String name) {
  switch (name) {
    case 'bridge2':
      return _$bridge2;
    case 'float':
      return _$float;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3WithdrawalRail> _$values =
    BuiltSet<Hip3WithdrawalRail>(const <Hip3WithdrawalRail>[
  _$bridge2,
  _$float,
  _$unknownDefaultOpenApi,
]);

class _$Hip3WithdrawalRailMeta {
  const _$Hip3WithdrawalRailMeta();
  Hip3WithdrawalRail get bridge2 => _$bridge2;
  Hip3WithdrawalRail get float => _$float;
  Hip3WithdrawalRail get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3WithdrawalRail valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3WithdrawalRail> get values => _$values;
}

abstract class _$Hip3WithdrawalRailMixin {
  // ignore: non_constant_identifier_names
  _$Hip3WithdrawalRailMeta get Hip3WithdrawalRail =>
      const _$Hip3WithdrawalRailMeta();
}

Serializer<Hip3WithdrawalRail> _$hip3WithdrawalRailSerializer =
    _$Hip3WithdrawalRailSerializer();

class _$Hip3WithdrawalRailSerializer
    implements PrimitiveSerializer<Hip3WithdrawalRail> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bridge2': 'bridge2',
    'float': 'float',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bridge2': 'bridge2',
    'float': 'float',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalRail];
  @override
  final String wireName = 'Hip3WithdrawalRail';

  @override
  Object serialize(Serializers serializers, Hip3WithdrawalRail object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalRail deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalRail.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
