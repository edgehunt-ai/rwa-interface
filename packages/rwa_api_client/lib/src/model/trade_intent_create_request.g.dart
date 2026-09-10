// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnum_autoMultiSource =
    const TradeIntentCreateRequestFundingModeEnum._('autoMultiSource');
const TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi =
    const TradeIntentCreateRequestFundingModeEnum._('unknownDefaultOpenApi');

TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$tradeIntentCreateRequestFundingModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentCreateRequestFundingModeEnum>
    _$tradeIntentCreateRequestFundingModeEnumValues = BuiltSet<
        TradeIntentCreateRequestFundingModeEnum>(const <TradeIntentCreateRequestFundingModeEnum>[
  _$tradeIntentCreateRequestFundingModeEnum_autoMultiSource,
  _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<TradeIntentCreateRequestFundingModeEnum>
    _$tradeIntentCreateRequestFundingModeEnumSerializer =
    _$TradeIntentCreateRequestFundingModeEnumSerializer();

class _$TradeIntentCreateRequestFundingModeEnumSerializer
    implements PrimitiveSerializer<TradeIntentCreateRequestFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TradeIntentCreateRequestFundingModeEnum
  ];
  @override
  final String wireName = 'TradeIntentCreateRequestFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          TradeIntentCreateRequestFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentCreateRequestFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentCreateRequestFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TradeIntentCreateRequest extends TradeIntentCreateRequest {
  @override
  final OneOf oneOf;

  factory _$TradeIntentCreateRequest(
          [void Function(TradeIntentCreateRequestBuilder)? updates]) =>
      (TradeIntentCreateRequestBuilder()..update(updates))._build();

  _$TradeIntentCreateRequest._({required this.oneOf}) : super._();
  @override
  TradeIntentCreateRequest rebuild(
          void Function(TradeIntentCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeIntentCreateRequestBuilder toBuilder() =>
      TradeIntentCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeIntentCreateRequest && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'TradeIntentCreateRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class TradeIntentCreateRequestBuilder
    implements
        Builder<TradeIntentCreateRequest, TradeIntentCreateRequestBuilder> {
  _$TradeIntentCreateRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  TradeIntentCreateRequestBuilder() {
    TradeIntentCreateRequest._defaults(this);
  }

  TradeIntentCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeIntentCreateRequest other) {
    _$v = other as _$TradeIntentCreateRequest;
  }

  @override
  void update(void Function(TradeIntentCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TradeIntentCreateRequest build() => _build();

  _$TradeIntentCreateRequest _build() {
    final _$result = _$v ??
        _$TradeIntentCreateRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'TradeIntentCreateRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
