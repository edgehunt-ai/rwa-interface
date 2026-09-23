// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_trade.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionTradeKindEnum
    _$fundingSessionTradeKindEnum_accountTransfer =
    const FundingSessionTradeKindEnum._('accountTransfer');
const FundingSessionTradeKindEnum
    _$fundingSessionTradeKindEnum_unknownDefaultOpenApi =
    const FundingSessionTradeKindEnum._('unknownDefaultOpenApi');

FundingSessionTradeKindEnum _$fundingSessionTradeKindEnumValueOf(String name) {
  switch (name) {
    case 'accountTransfer':
      return _$fundingSessionTradeKindEnum_accountTransfer;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTradeKindEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTradeKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTradeKindEnum>
    _$fundingSessionTradeKindEnumValues =
    BuiltSet<FundingSessionTradeKindEnum>(const <FundingSessionTradeKindEnum>[
  _$fundingSessionTradeKindEnum_accountTransfer,
  _$fundingSessionTradeKindEnum_unknownDefaultOpenApi,
]);

const FundingSessionTradeSideEnum _$fundingSessionTradeSideEnum_long =
    const FundingSessionTradeSideEnum._('long');
const FundingSessionTradeSideEnum _$fundingSessionTradeSideEnum_short =
    const FundingSessionTradeSideEnum._('short');
const FundingSessionTradeSideEnum
    _$fundingSessionTradeSideEnum_unknownDefaultOpenApi =
    const FundingSessionTradeSideEnum._('unknownDefaultOpenApi');

FundingSessionTradeSideEnum _$fundingSessionTradeSideEnumValueOf(String name) {
  switch (name) {
    case 'long':
      return _$fundingSessionTradeSideEnum_long;
    case 'short':
      return _$fundingSessionTradeSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTradeSideEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTradeSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTradeSideEnum>
    _$fundingSessionTradeSideEnumValues =
    BuiltSet<FundingSessionTradeSideEnum>(const <FundingSessionTradeSideEnum>[
  _$fundingSessionTradeSideEnum_long,
  _$fundingSessionTradeSideEnum_short,
  _$fundingSessionTradeSideEnum_unknownDefaultOpenApi,
]);

const FundingSessionTradeDestinationEnum
    _$fundingSessionTradeDestinationEnum_hip3Margin =
    const FundingSessionTradeDestinationEnum._('hip3Margin');
const FundingSessionTradeDestinationEnum
    _$fundingSessionTradeDestinationEnum_unknownDefaultOpenApi =
    const FundingSessionTradeDestinationEnum._('unknownDefaultOpenApi');

FundingSessionTradeDestinationEnum _$fundingSessionTradeDestinationEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Margin':
      return _$fundingSessionTradeDestinationEnum_hip3Margin;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTradeDestinationEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTradeDestinationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTradeDestinationEnum>
    _$fundingSessionTradeDestinationEnumValues = BuiltSet<
        FundingSessionTradeDestinationEnum>(const <FundingSessionTradeDestinationEnum>[
  _$fundingSessionTradeDestinationEnum_hip3Margin,
  _$fundingSessionTradeDestinationEnum_unknownDefaultOpenApi,
]);

Serializer<FundingSessionTradeKindEnum>
    _$fundingSessionTradeKindEnumSerializer =
    _$FundingSessionTradeKindEnumSerializer();
Serializer<FundingSessionTradeSideEnum>
    _$fundingSessionTradeSideEnumSerializer =
    _$FundingSessionTradeSideEnumSerializer();
Serializer<FundingSessionTradeDestinationEnum>
    _$fundingSessionTradeDestinationEnumSerializer =
    _$FundingSessionTradeDestinationEnumSerializer();

class _$FundingSessionTradeKindEnumSerializer
    implements PrimitiveSerializer<FundingSessionTradeKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'accountTransfer': 'account_transfer',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'account_transfer': 'accountTransfer',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingSessionTradeKindEnum];
  @override
  final String wireName = 'FundingSessionTradeKindEnum';

  @override
  Object serialize(Serializers serializers, FundingSessionTradeKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTradeKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTradeKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTradeSideEnumSerializer
    implements PrimitiveSerializer<FundingSessionTradeSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'long': 'long',
    'short': 'short',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'long': 'long',
    'short': 'short',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingSessionTradeSideEnum];
  @override
  final String wireName = 'FundingSessionTradeSideEnum';

  @override
  Object serialize(Serializers serializers, FundingSessionTradeSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTradeSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTradeSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTradeDestinationEnumSerializer
    implements PrimitiveSerializer<FundingSessionTradeDestinationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Margin': 'hip3_margin',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_margin': 'hip3Margin',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingSessionTradeDestinationEnum];
  @override
  final String wireName = 'FundingSessionTradeDestinationEnum';

  @override
  Object serialize(
          Serializers serializers, FundingSessionTradeDestinationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTradeDestinationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTradeDestinationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTrade extends FundingSessionTrade {
  @override
  final OneOf oneOf;

  factory _$FundingSessionTrade(
          [void Function(FundingSessionTradeBuilder)? updates]) =>
      (FundingSessionTradeBuilder()..update(updates))._build();

  _$FundingSessionTrade._({required this.oneOf}) : super._();
  @override
  FundingSessionTrade rebuild(
          void Function(FundingSessionTradeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTradeBuilder toBuilder() =>
      FundingSessionTradeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTrade && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingSessionTrade')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingSessionTradeBuilder
    implements Builder<FundingSessionTrade, FundingSessionTradeBuilder> {
  _$FundingSessionTrade? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingSessionTradeBuilder() {
    FundingSessionTrade._defaults(this);
  }

  FundingSessionTradeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTrade other) {
    _$v = other as _$FundingSessionTrade;
  }

  @override
  void update(void Function(FundingSessionTradeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTrade build() => _build();

  _$FundingSessionTrade _build() {
    final _$result = _$v ??
        _$FundingSessionTrade._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingSessionTrade', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
