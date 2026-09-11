// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_public_market.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3PublicMarketEnvironmentEnum
    _$hip3PublicMarketEnvironmentEnum_mainnet =
    const Hip3PublicMarketEnvironmentEnum._('mainnet');
const Hip3PublicMarketEnvironmentEnum
    _$hip3PublicMarketEnvironmentEnum_testnet =
    const Hip3PublicMarketEnvironmentEnum._('testnet');
const Hip3PublicMarketEnvironmentEnum
    _$hip3PublicMarketEnvironmentEnum_unknownDefaultOpenApi =
    const Hip3PublicMarketEnvironmentEnum._('unknownDefaultOpenApi');

Hip3PublicMarketEnvironmentEnum _$hip3PublicMarketEnvironmentEnumValueOf(
    String name) {
  switch (name) {
    case 'mainnet':
      return _$hip3PublicMarketEnvironmentEnum_mainnet;
    case 'testnet':
      return _$hip3PublicMarketEnvironmentEnum_testnet;
    case 'unknownDefaultOpenApi':
      return _$hip3PublicMarketEnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$hip3PublicMarketEnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3PublicMarketEnvironmentEnum>
    _$hip3PublicMarketEnvironmentEnumValues = BuiltSet<
        Hip3PublicMarketEnvironmentEnum>(const <Hip3PublicMarketEnvironmentEnum>[
  _$hip3PublicMarketEnvironmentEnum_mainnet,
  _$hip3PublicMarketEnvironmentEnum_testnet,
  _$hip3PublicMarketEnvironmentEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3PublicMarketEnvironmentEnum>
    _$hip3PublicMarketEnvironmentEnumSerializer =
    _$Hip3PublicMarketEnvironmentEnumSerializer();

class _$Hip3PublicMarketEnvironmentEnumSerializer
    implements PrimitiveSerializer<Hip3PublicMarketEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3PublicMarketEnvironmentEnum];
  @override
  final String wireName = 'Hip3PublicMarketEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3PublicMarketEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PublicMarketEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PublicMarketEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class Hip3PublicMarketBuilder {
  void replace(Hip3PublicMarket other);
  void update(void Function(Hip3PublicMarketBuilder) updates);
  String? get productId;
  set productId(String? productId);

  String? get venue;
  set venue(String? venue);

  Hip3PublicMarketEnvironmentEnum? get environment;
  set environment(Hip3PublicMarketEnvironmentEnum? environment);

  String? get settlementAsset;
  set settlementAsset(String? settlementAsset);

  bool? get tradable;
  set tradable(bool? tradable);

  String? get unavailableReason;
  set unavailableReason(String? unavailableReason);
}

class _$$Hip3PublicMarket extends $Hip3PublicMarket {
  @override
  final String productId;
  @override
  final String venue;
  @override
  final Hip3PublicMarketEnvironmentEnum environment;
  @override
  final String settlementAsset;
  @override
  final bool tradable;
  @override
  final String? unavailableReason;

  factory _$$Hip3PublicMarket(
          [void Function($Hip3PublicMarketBuilder)? updates]) =>
      ($Hip3PublicMarketBuilder()..update(updates))._build();

  _$$Hip3PublicMarket._(
      {required this.productId,
      required this.venue,
      required this.environment,
      required this.settlementAsset,
      required this.tradable,
      this.unavailableReason})
      : super._();
  @override
  $Hip3PublicMarket rebuild(void Function($Hip3PublicMarketBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $Hip3PublicMarketBuilder toBuilder() =>
      $Hip3PublicMarketBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $Hip3PublicMarket &&
        productId == other.productId &&
        venue == other.venue &&
        environment == other.environment &&
        settlementAsset == other.settlementAsset &&
        tradable == other.tradable &&
        unavailableReason == other.unavailableReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, venue.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, tradable.hashCode);
    _$hash = $jc(_$hash, unavailableReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$Hip3PublicMarket')
          ..add('productId', productId)
          ..add('venue', venue)
          ..add('environment', environment)
          ..add('settlementAsset', settlementAsset)
          ..add('tradable', tradable)
          ..add('unavailableReason', unavailableReason))
        .toString();
  }
}

class $Hip3PublicMarketBuilder
    implements
        Builder<$Hip3PublicMarket, $Hip3PublicMarketBuilder>,
        Hip3PublicMarketBuilder {
  _$$Hip3PublicMarket? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(covariant String? productId) => _$this._productId = productId;

  String? _venue;
  String? get venue => _$this._venue;
  set venue(covariant String? venue) => _$this._venue = venue;

  Hip3PublicMarketEnvironmentEnum? _environment;
  Hip3PublicMarketEnvironmentEnum? get environment => _$this._environment;
  set environment(covariant Hip3PublicMarketEnvironmentEnum? environment) =>
      _$this._environment = environment;

  String? _settlementAsset;
  String? get settlementAsset => _$this._settlementAsset;
  set settlementAsset(covariant String? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  bool? _tradable;
  bool? get tradable => _$this._tradable;
  set tradable(covariant bool? tradable) => _$this._tradable = tradable;

  String? _unavailableReason;
  String? get unavailableReason => _$this._unavailableReason;
  set unavailableReason(covariant String? unavailableReason) =>
      _$this._unavailableReason = unavailableReason;

  $Hip3PublicMarketBuilder() {
    $Hip3PublicMarket._defaults(this);
  }

  $Hip3PublicMarketBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _venue = $v.venue;
      _environment = $v.environment;
      _settlementAsset = $v.settlementAsset;
      _tradable = $v.tradable;
      _unavailableReason = $v.unavailableReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $Hip3PublicMarket other) {
    _$v = other as _$$Hip3PublicMarket;
  }

  @override
  void update(void Function($Hip3PublicMarketBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $Hip3PublicMarket build() => _build();

  _$$Hip3PublicMarket _build() {
    final _$result = _$v ??
        _$$Hip3PublicMarket._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'$Hip3PublicMarket', 'productId'),
          venue: BuiltValueNullFieldError.checkNotNull(
              venue, r'$Hip3PublicMarket', 'venue'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'$Hip3PublicMarket', 'environment'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'$Hip3PublicMarket', 'settlementAsset'),
          tradable: BuiltValueNullFieldError.checkNotNull(
              tradable, r'$Hip3PublicMarket', 'tradable'),
          unavailableReason: unavailableReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
