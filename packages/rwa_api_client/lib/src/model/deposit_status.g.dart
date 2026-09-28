// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositStatus _$confirmed = const DepositStatus._('confirmed');

DepositStatus _$valueOf(String name) {
  switch (name) {
    case 'confirmed':
      return _$confirmed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositStatus> _$values =
    BuiltSet<DepositStatus>(const <DepositStatus>[
  _$confirmed,
]);

class _$DepositStatusMeta {
  const _$DepositStatusMeta();
  DepositStatus get confirmed => _$confirmed;
  DepositStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<DepositStatus> get values => _$values;
}

abstract class _$DepositStatusMixin {
  // ignore: non_constant_identifier_names
  _$DepositStatusMeta get DepositStatus => const _$DepositStatusMeta();
}

Serializer<DepositStatus> _$depositStatusSerializer =
    _$DepositStatusSerializer();

class _$DepositStatusSerializer implements PrimitiveSerializer<DepositStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'confirmed': 'confirmed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'confirmed': 'confirmed',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositStatus];
  @override
  final String wireName = 'DepositStatus';

  @override
  Object serialize(Serializers serializers, DepositStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
