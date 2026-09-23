// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_market_order_minimums.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3MarketOrderMinimumsAmountAssetEnum
    _$hip3MarketOrderMinimumsAmountAssetEnum_USDC =
    const Hip3MarketOrderMinimumsAmountAssetEnum._('USDC');
const Hip3MarketOrderMinimumsAmountAssetEnum
    _$hip3MarketOrderMinimumsAmountAssetEnum_unknownDefaultOpenApi =
    const Hip3MarketOrderMinimumsAmountAssetEnum._('unknownDefaultOpenApi');

Hip3MarketOrderMinimumsAmountAssetEnum
    _$hip3MarketOrderMinimumsAmountAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$hip3MarketOrderMinimumsAmountAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$hip3MarketOrderMinimumsAmountAssetEnum_unknownDefaultOpenApi;
    default:
      return _$hip3MarketOrderMinimumsAmountAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3MarketOrderMinimumsAmountAssetEnum>
    _$hip3MarketOrderMinimumsAmountAssetEnumValues = BuiltSet<
        Hip3MarketOrderMinimumsAmountAssetEnum>(const <Hip3MarketOrderMinimumsAmountAssetEnum>[
  _$hip3MarketOrderMinimumsAmountAssetEnum_USDC,
  _$hip3MarketOrderMinimumsAmountAssetEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3MarketOrderMinimumsAmountAssetEnum>
    _$hip3MarketOrderMinimumsAmountAssetEnumSerializer =
    _$Hip3MarketOrderMinimumsAmountAssetEnumSerializer();

class _$Hip3MarketOrderMinimumsAmountAssetEnumSerializer
    implements PrimitiveSerializer<Hip3MarketOrderMinimumsAmountAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3MarketOrderMinimumsAmountAssetEnum
  ];
  @override
  final String wireName = 'Hip3MarketOrderMinimumsAmountAssetEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3MarketOrderMinimumsAmountAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3MarketOrderMinimumsAmountAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3MarketOrderMinimumsAmountAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3MarketOrderMinimums extends Hip3MarketOrderMinimums {
  @override
  final Hip3MarketOrderMinimumsAmountAssetEnum amountAsset;
  @override
  final String slippagePercent;
  @override
  final String leverage;
  @override
  final Hip3MarketOrderMinimum? long;
  @override
  final Hip3MarketOrderMinimum? short;
  @override
  final DateTime observedAt;

  factory _$Hip3MarketOrderMinimums(
          [void Function(Hip3MarketOrderMinimumsBuilder)? updates]) =>
      (Hip3MarketOrderMinimumsBuilder()..update(updates))._build();

  _$Hip3MarketOrderMinimums._(
      {required this.amountAsset,
      required this.slippagePercent,
      required this.leverage,
      this.long,
      this.short,
      required this.observedAt})
      : super._();
  @override
  Hip3MarketOrderMinimums rebuild(
          void Function(Hip3MarketOrderMinimumsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3MarketOrderMinimumsBuilder toBuilder() =>
      Hip3MarketOrderMinimumsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3MarketOrderMinimums &&
        amountAsset == other.amountAsset &&
        slippagePercent == other.slippagePercent &&
        leverage == other.leverage &&
        long == other.long &&
        short == other.short &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amountAsset.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, long.hashCode);
    _$hash = $jc(_$hash, short.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3MarketOrderMinimums')
          ..add('amountAsset', amountAsset)
          ..add('slippagePercent', slippagePercent)
          ..add('leverage', leverage)
          ..add('long', long)
          ..add('short', short)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class Hip3MarketOrderMinimumsBuilder
    implements
        Builder<Hip3MarketOrderMinimums, Hip3MarketOrderMinimumsBuilder> {
  _$Hip3MarketOrderMinimums? _$v;

  Hip3MarketOrderMinimumsAmountAssetEnum? _amountAsset;
  Hip3MarketOrderMinimumsAmountAssetEnum? get amountAsset =>
      _$this._amountAsset;
  set amountAsset(Hip3MarketOrderMinimumsAmountAssetEnum? amountAsset) =>
      _$this._amountAsset = amountAsset;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  Hip3MarketOrderMinimumBuilder? _long;
  Hip3MarketOrderMinimumBuilder get long =>
      _$this._long ??= Hip3MarketOrderMinimumBuilder();
  set long(Hip3MarketOrderMinimumBuilder? long) => _$this._long = long;

  Hip3MarketOrderMinimumBuilder? _short;
  Hip3MarketOrderMinimumBuilder get short =>
      _$this._short ??= Hip3MarketOrderMinimumBuilder();
  set short(Hip3MarketOrderMinimumBuilder? short) => _$this._short = short;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  Hip3MarketOrderMinimumsBuilder() {
    Hip3MarketOrderMinimums._defaults(this);
  }

  Hip3MarketOrderMinimumsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amountAsset = $v.amountAsset;
      _slippagePercent = $v.slippagePercent;
      _leverage = $v.leverage;
      _long = $v.long?.toBuilder();
      _short = $v.short?.toBuilder();
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3MarketOrderMinimums other) {
    _$v = other as _$Hip3MarketOrderMinimums;
  }

  @override
  void update(void Function(Hip3MarketOrderMinimumsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3MarketOrderMinimums build() => _build();

  _$Hip3MarketOrderMinimums _build() {
    _$Hip3MarketOrderMinimums _$result;
    try {
      _$result = _$v ??
          _$Hip3MarketOrderMinimums._(
            amountAsset: BuiltValueNullFieldError.checkNotNull(
                amountAsset, r'Hip3MarketOrderMinimums', 'amountAsset'),
            slippagePercent: BuiltValueNullFieldError.checkNotNull(
                slippagePercent, r'Hip3MarketOrderMinimums', 'slippagePercent'),
            leverage: BuiltValueNullFieldError.checkNotNull(
                leverage, r'Hip3MarketOrderMinimums', 'leverage'),
            long: _long?.build(),
            short: _short?.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3MarketOrderMinimums', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'long';
        _long?.build();
        _$failedField = 'short';
        _short?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3MarketOrderMinimums', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
