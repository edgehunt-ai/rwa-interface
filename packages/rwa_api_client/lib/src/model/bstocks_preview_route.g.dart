// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewRouteKindEnum _$bstocksPreviewRouteKindEnum_single =
    const BstocksPreviewRouteKindEnum._('single');
const BstocksPreviewRouteKindEnum _$bstocksPreviewRouteKindEnum_split =
    const BstocksPreviewRouteKindEnum._('split');
const BstocksPreviewRouteKindEnum
    _$bstocksPreviewRouteKindEnum_unknownDefaultOpenApi =
    const BstocksPreviewRouteKindEnum._('unknownDefaultOpenApi');

BstocksPreviewRouteKindEnum _$bstocksPreviewRouteKindEnumValueOf(String name) {
  switch (name) {
    case 'single':
      return _$bstocksPreviewRouteKindEnum_single;
    case 'split':
      return _$bstocksPreviewRouteKindEnum_split;
    case 'unknownDefaultOpenApi':
      return _$bstocksPreviewRouteKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksPreviewRouteKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksPreviewRouteKindEnum>
    _$bstocksPreviewRouteKindEnumValues =
    BuiltSet<BstocksPreviewRouteKindEnum>(const <BstocksPreviewRouteKindEnum>[
  _$bstocksPreviewRouteKindEnum_single,
  _$bstocksPreviewRouteKindEnum_split,
  _$bstocksPreviewRouteKindEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksPreviewRouteKindEnum>
    _$bstocksPreviewRouteKindEnumSerializer =
    _$BstocksPreviewRouteKindEnumSerializer();

class _$BstocksPreviewRouteKindEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewRouteKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'single': 'single',
    'split': 'split',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'single': 'single',
    'split': 'split',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksPreviewRouteKindEnum];
  @override
  final String wireName = 'BstocksPreviewRouteKindEnum';

  @override
  Object serialize(Serializers serializers, BstocksPreviewRouteKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewRouteKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewRouteKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewRoute extends BstocksPreviewRoute {
  @override
  final BstocksPreviewRouteKindEnum kind;
  @override
  final String expectedAmountOutRaw;
  @override
  final String netAmountOutRaw;
  @override
  final BuiltList<BstocksPreviewRouteLeg> legs;
  @override
  final bool indicative;

  factory _$BstocksPreviewRoute(
          [void Function(BstocksPreviewRouteBuilder)? updates]) =>
      (BstocksPreviewRouteBuilder()..update(updates))._build();

  _$BstocksPreviewRoute._(
      {required this.kind,
      required this.expectedAmountOutRaw,
      required this.netAmountOutRaw,
      required this.legs,
      required this.indicative})
      : super._();
  @override
  BstocksPreviewRoute rebuild(
          void Function(BstocksPreviewRouteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewRouteBuilder toBuilder() =>
      BstocksPreviewRouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewRoute &&
        kind == other.kind &&
        expectedAmountOutRaw == other.expectedAmountOutRaw &&
        netAmountOutRaw == other.netAmountOutRaw &&
        legs == other.legs &&
        indicative == other.indicative;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, expectedAmountOutRaw.hashCode);
    _$hash = $jc(_$hash, netAmountOutRaw.hashCode);
    _$hash = $jc(_$hash, legs.hashCode);
    _$hash = $jc(_$hash, indicative.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewRoute')
          ..add('kind', kind)
          ..add('expectedAmountOutRaw', expectedAmountOutRaw)
          ..add('netAmountOutRaw', netAmountOutRaw)
          ..add('legs', legs)
          ..add('indicative', indicative))
        .toString();
  }
}

class BstocksPreviewRouteBuilder
    implements Builder<BstocksPreviewRoute, BstocksPreviewRouteBuilder> {
  _$BstocksPreviewRoute? _$v;

  BstocksPreviewRouteKindEnum? _kind;
  BstocksPreviewRouteKindEnum? get kind => _$this._kind;
  set kind(BstocksPreviewRouteKindEnum? kind) => _$this._kind = kind;

  String? _expectedAmountOutRaw;
  String? get expectedAmountOutRaw => _$this._expectedAmountOutRaw;
  set expectedAmountOutRaw(String? expectedAmountOutRaw) =>
      _$this._expectedAmountOutRaw = expectedAmountOutRaw;

  String? _netAmountOutRaw;
  String? get netAmountOutRaw => _$this._netAmountOutRaw;
  set netAmountOutRaw(String? netAmountOutRaw) =>
      _$this._netAmountOutRaw = netAmountOutRaw;

  ListBuilder<BstocksPreviewRouteLeg>? _legs;
  ListBuilder<BstocksPreviewRouteLeg> get legs =>
      _$this._legs ??= ListBuilder<BstocksPreviewRouteLeg>();
  set legs(ListBuilder<BstocksPreviewRouteLeg>? legs) => _$this._legs = legs;

  bool? _indicative;
  bool? get indicative => _$this._indicative;
  set indicative(bool? indicative) => _$this._indicative = indicative;

  BstocksPreviewRouteBuilder() {
    BstocksPreviewRoute._defaults(this);
  }

  BstocksPreviewRouteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _expectedAmountOutRaw = $v.expectedAmountOutRaw;
      _netAmountOutRaw = $v.netAmountOutRaw;
      _legs = $v.legs.toBuilder();
      _indicative = $v.indicative;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewRoute other) {
    _$v = other as _$BstocksPreviewRoute;
  }

  @override
  void update(void Function(BstocksPreviewRouteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewRoute build() => _build();

  _$BstocksPreviewRoute _build() {
    _$BstocksPreviewRoute _$result;
    try {
      _$result = _$v ??
          _$BstocksPreviewRoute._(
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'BstocksPreviewRoute', 'kind'),
            expectedAmountOutRaw: BuiltValueNullFieldError.checkNotNull(
                expectedAmountOutRaw,
                r'BstocksPreviewRoute',
                'expectedAmountOutRaw'),
            netAmountOutRaw: BuiltValueNullFieldError.checkNotNull(
                netAmountOutRaw, r'BstocksPreviewRoute', 'netAmountOutRaw'),
            legs: legs.build(),
            indicative: BuiltValueNullFieldError.checkNotNull(
                indicative, r'BstocksPreviewRoute', 'indicative'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'legs';
        legs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksPreviewRoute', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
