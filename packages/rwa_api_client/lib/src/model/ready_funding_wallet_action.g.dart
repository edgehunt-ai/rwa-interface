// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ready_funding_wallet_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReadyFundingWalletActionKindEnum
    _$readyFundingWalletActionKindEnum_originTransaction =
    const ReadyFundingWalletActionKindEnum._('originTransaction');
const ReadyFundingWalletActionKindEnum
    _$readyFundingWalletActionKindEnum_unknownDefaultOpenApi =
    const ReadyFundingWalletActionKindEnum._('unknownDefaultOpenApi');

ReadyFundingWalletActionKindEnum _$readyFundingWalletActionKindEnumValueOf(
    String name) {
  switch (name) {
    case 'originTransaction':
      return _$readyFundingWalletActionKindEnum_originTransaction;
    case 'unknownDefaultOpenApi':
      return _$readyFundingWalletActionKindEnum_unknownDefaultOpenApi;
    default:
      return _$readyFundingWalletActionKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReadyFundingWalletActionKindEnum>
    _$readyFundingWalletActionKindEnumValues = BuiltSet<
        ReadyFundingWalletActionKindEnum>(const <ReadyFundingWalletActionKindEnum>[
  _$readyFundingWalletActionKindEnum_originTransaction,
  _$readyFundingWalletActionKindEnum_unknownDefaultOpenApi,
]);

const ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnum_number1 =
    const ReadyFundingWalletActionChainIdEnum._('number1');
const ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnum_number56 =
    const ReadyFundingWalletActionChainIdEnum._('number56');
const ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnum_number8453 =
    const ReadyFundingWalletActionChainIdEnum._('number8453');
const ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnum_number42161 =
    const ReadyFundingWalletActionChainIdEnum._('number42161');
const ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnum_unknownDefaultOpenApi =
    const ReadyFundingWalletActionChainIdEnum._('unknownDefaultOpenApi');

ReadyFundingWalletActionChainIdEnum
    _$readyFundingWalletActionChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number1':
      return _$readyFundingWalletActionChainIdEnum_number1;
    case 'number56':
      return _$readyFundingWalletActionChainIdEnum_number56;
    case 'number8453':
      return _$readyFundingWalletActionChainIdEnum_number8453;
    case 'number42161':
      return _$readyFundingWalletActionChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$readyFundingWalletActionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$readyFundingWalletActionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReadyFundingWalletActionChainIdEnum>
    _$readyFundingWalletActionChainIdEnumValues = BuiltSet<
        ReadyFundingWalletActionChainIdEnum>(const <ReadyFundingWalletActionChainIdEnum>[
  _$readyFundingWalletActionChainIdEnum_number1,
  _$readyFundingWalletActionChainIdEnum_number56,
  _$readyFundingWalletActionChainIdEnum_number8453,
  _$readyFundingWalletActionChainIdEnum_number42161,
  _$readyFundingWalletActionChainIdEnum_unknownDefaultOpenApi,
]);

const ReadyFundingWalletActionValueEnum
    _$readyFundingWalletActionValueEnum_n0x0 =
    const ReadyFundingWalletActionValueEnum._('n0x0');
const ReadyFundingWalletActionValueEnum
    _$readyFundingWalletActionValueEnum_unknownDefaultOpenApi =
    const ReadyFundingWalletActionValueEnum._('unknownDefaultOpenApi');

ReadyFundingWalletActionValueEnum _$readyFundingWalletActionValueEnumValueOf(
    String name) {
  switch (name) {
    case 'n0x0':
      return _$readyFundingWalletActionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$readyFundingWalletActionValueEnum_unknownDefaultOpenApi;
    default:
      return _$readyFundingWalletActionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReadyFundingWalletActionValueEnum>
    _$readyFundingWalletActionValueEnumValues = BuiltSet<
        ReadyFundingWalletActionValueEnum>(const <ReadyFundingWalletActionValueEnum>[
  _$readyFundingWalletActionValueEnum_n0x0,
  _$readyFundingWalletActionValueEnum_unknownDefaultOpenApi,
]);

Serializer<ReadyFundingWalletActionKindEnum>
    _$readyFundingWalletActionKindEnumSerializer =
    _$ReadyFundingWalletActionKindEnumSerializer();
Serializer<ReadyFundingWalletActionChainIdEnum>
    _$readyFundingWalletActionChainIdEnumSerializer =
    _$ReadyFundingWalletActionChainIdEnumSerializer();
Serializer<ReadyFundingWalletActionValueEnum>
    _$readyFundingWalletActionValueEnumSerializer =
    _$ReadyFundingWalletActionValueEnumSerializer();

class _$ReadyFundingWalletActionKindEnumSerializer
    implements PrimitiveSerializer<ReadyFundingWalletActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'originTransaction': 'origin_transaction',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'origin_transaction': 'originTransaction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ReadyFundingWalletActionKindEnum];
  @override
  final String wireName = 'ReadyFundingWalletActionKindEnum';

  @override
  Object serialize(
          Serializers serializers, ReadyFundingWalletActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReadyFundingWalletActionKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReadyFundingWalletActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReadyFundingWalletActionChainIdEnumSerializer
    implements PrimitiveSerializer<ReadyFundingWalletActionChainIdEnum> {
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
  final Iterable<Type> types = const <Type>[
    ReadyFundingWalletActionChainIdEnum
  ];
  @override
  final String wireName = 'ReadyFundingWalletActionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, ReadyFundingWalletActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReadyFundingWalletActionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReadyFundingWalletActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReadyFundingWalletActionValueEnumSerializer
    implements PrimitiveSerializer<ReadyFundingWalletActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ReadyFundingWalletActionValueEnum];
  @override
  final String wireName = 'ReadyFundingWalletActionValueEnum';

  @override
  Object serialize(
          Serializers serializers, ReadyFundingWalletActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReadyFundingWalletActionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReadyFundingWalletActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReadyFundingWalletAction extends ReadyFundingWalletAction {
  @override
  final OneOf oneOf;

  factory _$ReadyFundingWalletAction(
          [void Function(ReadyFundingWalletActionBuilder)? updates]) =>
      (ReadyFundingWalletActionBuilder()..update(updates))._build();

  _$ReadyFundingWalletAction._({required this.oneOf}) : super._();
  @override
  ReadyFundingWalletAction rebuild(
          void Function(ReadyFundingWalletActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadyFundingWalletActionBuilder toBuilder() =>
      ReadyFundingWalletActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadyFundingWalletAction && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'ReadyFundingWalletAction')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class ReadyFundingWalletActionBuilder
    implements
        Builder<ReadyFundingWalletAction, ReadyFundingWalletActionBuilder> {
  _$ReadyFundingWalletAction? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  ReadyFundingWalletActionBuilder() {
    ReadyFundingWalletAction._defaults(this);
  }

  ReadyFundingWalletActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadyFundingWalletAction other) {
    _$v = other as _$ReadyFundingWalletAction;
  }

  @override
  void update(void Function(ReadyFundingWalletActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadyFundingWalletAction build() => _build();

  _$ReadyFundingWalletAction _build() {
    final _$result = _$v ??
        _$ReadyFundingWalletAction._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'ReadyFundingWalletAction', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
