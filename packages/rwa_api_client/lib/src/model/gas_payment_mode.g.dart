// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_payment_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GasPaymentMode _$appSponsored = const GasPaymentMode._('appSponsored');
const GasPaymentMode _$userPaidNative =
    const GasPaymentMode._('userPaidNative');

GasPaymentMode _$valueOf(String name) {
  switch (name) {
    case 'appSponsored':
      return _$appSponsored;
    case 'userPaidNative':
      return _$userPaidNative;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GasPaymentMode> _$values =
    BuiltSet<GasPaymentMode>(const <GasPaymentMode>[
  _$appSponsored,
  _$userPaidNative,
]);

class _$GasPaymentModeMeta {
  const _$GasPaymentModeMeta();
  GasPaymentMode get appSponsored => _$appSponsored;
  GasPaymentMode get userPaidNative => _$userPaidNative;
  GasPaymentMode valueOf(String name) => _$valueOf(name);
  BuiltSet<GasPaymentMode> get values => _$values;
}

abstract class _$GasPaymentModeMixin {
  // ignore: non_constant_identifier_names
  _$GasPaymentModeMeta get GasPaymentMode => const _$GasPaymentModeMeta();
}

Serializer<GasPaymentMode> _$gasPaymentModeSerializer =
    _$GasPaymentModeSerializer();

class _$GasPaymentModeSerializer
    implements PrimitiveSerializer<GasPaymentMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'appSponsored': 'app_sponsored',
    'userPaidNative': 'user_paid_native',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'app_sponsored': 'appSponsored',
    'user_paid_native': 'userPaidNative',
  };

  @override
  final Iterable<Type> types = const <Type>[GasPaymentMode];
  @override
  final String wireName = 'GasPaymentMode';

  @override
  Object serialize(Serializers serializers, GasPaymentMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GasPaymentMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GasPaymentMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
