// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_credit_target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositCreditTarget _$wallet = const DepositCreditTarget._('wallet');
const DepositCreditTarget _$unknownDefaultOpenApi =
    const DepositCreditTarget._('unknownDefaultOpenApi');

DepositCreditTarget _$valueOf(String name) {
  switch (name) {
    case 'wallet':
      return _$wallet;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositCreditTarget> _$values =
    BuiltSet<DepositCreditTarget>(const <DepositCreditTarget>[
  _$wallet,
  _$unknownDefaultOpenApi,
]);

class _$DepositCreditTargetMeta {
  const _$DepositCreditTargetMeta();
  DepositCreditTarget get wallet => _$wallet;
  DepositCreditTarget get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  DepositCreditTarget valueOf(String name) => _$valueOf(name);
  BuiltSet<DepositCreditTarget> get values => _$values;
}

abstract class _$DepositCreditTargetMixin {
  // ignore: non_constant_identifier_names
  _$DepositCreditTargetMeta get DepositCreditTarget =>
      const _$DepositCreditTargetMeta();
}

Serializer<DepositCreditTarget> _$depositCreditTargetSerializer =
    _$DepositCreditTargetSerializer();

class _$DepositCreditTargetSerializer
    implements PrimitiveSerializer<DepositCreditTarget> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'wallet': 'wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet': 'wallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositCreditTarget];
  @override
  final String wireName = 'DepositCreditTarget';

  @override
  Object serialize(Serializers serializers, DepositCreditTarget object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositCreditTarget deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositCreditTarget.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
