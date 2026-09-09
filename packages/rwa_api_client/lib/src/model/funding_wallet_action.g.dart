// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_wallet_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingWalletActionKindEnum
    _$fundingWalletActionKindEnum_originTransaction =
    const FundingWalletActionKindEnum._('originTransaction');
const FundingWalletActionKindEnum
    _$fundingWalletActionKindEnum_unknownDefaultOpenApi =
    const FundingWalletActionKindEnum._('unknownDefaultOpenApi');

FundingWalletActionKindEnum _$fundingWalletActionKindEnumValueOf(String name) {
  switch (name) {
    case 'originTransaction':
      return _$fundingWalletActionKindEnum_originTransaction;
    case 'unknownDefaultOpenApi':
      return _$fundingWalletActionKindEnum_unknownDefaultOpenApi;
    default:
      return _$fundingWalletActionKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingWalletActionKindEnum>
    _$fundingWalletActionKindEnumValues =
    BuiltSet<FundingWalletActionKindEnum>(const <FundingWalletActionKindEnum>[
  _$fundingWalletActionKindEnum_originTransaction,
  _$fundingWalletActionKindEnum_unknownDefaultOpenApi,
]);

const FundingWalletActionChainIdEnum _$fundingWalletActionChainIdEnum_number1 =
    const FundingWalletActionChainIdEnum._('number1');
const FundingWalletActionChainIdEnum _$fundingWalletActionChainIdEnum_number56 =
    const FundingWalletActionChainIdEnum._('number56');
const FundingWalletActionChainIdEnum
    _$fundingWalletActionChainIdEnum_number8453 =
    const FundingWalletActionChainIdEnum._('number8453');
const FundingWalletActionChainIdEnum
    _$fundingWalletActionChainIdEnum_number42161 =
    const FundingWalletActionChainIdEnum._('number42161');
const FundingWalletActionChainIdEnum
    _$fundingWalletActionChainIdEnum_unknownDefaultOpenApi =
    const FundingWalletActionChainIdEnum._('unknownDefaultOpenApi');

FundingWalletActionChainIdEnum _$fundingWalletActionChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$fundingWalletActionChainIdEnum_number1;
    case 'number56':
      return _$fundingWalletActionChainIdEnum_number56;
    case 'number8453':
      return _$fundingWalletActionChainIdEnum_number8453;
    case 'number42161':
      return _$fundingWalletActionChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$fundingWalletActionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$fundingWalletActionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingWalletActionChainIdEnum>
    _$fundingWalletActionChainIdEnumValues = BuiltSet<
        FundingWalletActionChainIdEnum>(const <FundingWalletActionChainIdEnum>[
  _$fundingWalletActionChainIdEnum_number1,
  _$fundingWalletActionChainIdEnum_number56,
  _$fundingWalletActionChainIdEnum_number8453,
  _$fundingWalletActionChainIdEnum_number42161,
  _$fundingWalletActionChainIdEnum_unknownDefaultOpenApi,
]);

const FundingWalletActionValueEnum _$fundingWalletActionValueEnum_n0x0 =
    const FundingWalletActionValueEnum._('n0x0');
const FundingWalletActionValueEnum
    _$fundingWalletActionValueEnum_unknownDefaultOpenApi =
    const FundingWalletActionValueEnum._('unknownDefaultOpenApi');

FundingWalletActionValueEnum _$fundingWalletActionValueEnumValueOf(
    String name) {
  switch (name) {
    case 'n0x0':
      return _$fundingWalletActionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$fundingWalletActionValueEnum_unknownDefaultOpenApi;
    default:
      return _$fundingWalletActionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingWalletActionValueEnum>
    _$fundingWalletActionValueEnumValues =
    BuiltSet<FundingWalletActionValueEnum>(const <FundingWalletActionValueEnum>[
  _$fundingWalletActionValueEnum_n0x0,
  _$fundingWalletActionValueEnum_unknownDefaultOpenApi,
]);

Serializer<FundingWalletActionKindEnum>
    _$fundingWalletActionKindEnumSerializer =
    _$FundingWalletActionKindEnumSerializer();
Serializer<FundingWalletActionChainIdEnum>
    _$fundingWalletActionChainIdEnumSerializer =
    _$FundingWalletActionChainIdEnumSerializer();
Serializer<FundingWalletActionValueEnum>
    _$fundingWalletActionValueEnumSerializer =
    _$FundingWalletActionValueEnumSerializer();

class _$FundingWalletActionKindEnumSerializer
    implements PrimitiveSerializer<FundingWalletActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'originTransaction': 'origin_transaction',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'origin_transaction': 'originTransaction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingWalletActionKindEnum];
  @override
  final String wireName = 'FundingWalletActionKindEnum';

  @override
  Object serialize(Serializers serializers, FundingWalletActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingWalletActionKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingWalletActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingWalletActionChainIdEnumSerializer
    implements PrimitiveSerializer<FundingWalletActionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
    'number56': 56,
    'number8453': 8453,
    'number42161': 42161,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
    56: 'number56',
    8453: 'number8453',
    42161: 'number42161',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingWalletActionChainIdEnum];
  @override
  final String wireName = 'FundingWalletActionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, FundingWalletActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingWalletActionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingWalletActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingWalletActionValueEnumSerializer
    implements PrimitiveSerializer<FundingWalletActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingWalletActionValueEnum];
  @override
  final String wireName = 'FundingWalletActionValueEnum';

  @override
  Object serialize(Serializers serializers, FundingWalletActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingWalletActionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingWalletActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingWalletAction extends FundingWalletAction {
  @override
  final OneOf oneOf;

  factory _$FundingWalletAction(
          [void Function(FundingWalletActionBuilder)? updates]) =>
      (FundingWalletActionBuilder()..update(updates))._build();

  _$FundingWalletAction._({required this.oneOf}) : super._();
  @override
  FundingWalletAction rebuild(
          void Function(FundingWalletActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingWalletActionBuilder toBuilder() =>
      FundingWalletActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingWalletAction && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingWalletAction')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingWalletActionBuilder
    implements Builder<FundingWalletAction, FundingWalletActionBuilder> {
  _$FundingWalletAction? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingWalletActionBuilder() {
    FundingWalletAction._defaults(this);
  }

  FundingWalletActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingWalletAction other) {
    _$v = other as _$FundingWalletAction;
  }

  @override
  void update(void Function(FundingWalletActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingWalletAction build() => _build();

  _$FundingWalletAction _build() {
    final _$result = _$v ??
        _$FundingWalletAction._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingWalletAction', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
