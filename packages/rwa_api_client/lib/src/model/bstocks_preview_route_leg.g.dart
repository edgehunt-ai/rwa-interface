// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_route_leg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewRouteLegVenueEnum
    _$bstocksPreviewRouteLegVenueEnum_propamm =
    const BstocksPreviewRouteLegVenueEnum._('propamm');
const BstocksPreviewRouteLegVenueEnum
    _$bstocksPreviewRouteLegVenueEnum_pancakeV3 =
    const BstocksPreviewRouteLegVenueEnum._('pancakeV3');
const BstocksPreviewRouteLegVenueEnum
    _$bstocksPreviewRouteLegVenueEnum_unknownDefaultOpenApi =
    const BstocksPreviewRouteLegVenueEnum._('unknownDefaultOpenApi');

BstocksPreviewRouteLegVenueEnum _$bstocksPreviewRouteLegVenueEnumValueOf(
    String name) {
  switch (name) {
    case 'propamm':
      return _$bstocksPreviewRouteLegVenueEnum_propamm;
    case 'pancakeV3':
      return _$bstocksPreviewRouteLegVenueEnum_pancakeV3;
    case 'unknownDefaultOpenApi':
      return _$bstocksPreviewRouteLegVenueEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksPreviewRouteLegVenueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksPreviewRouteLegVenueEnum>
    _$bstocksPreviewRouteLegVenueEnumValues = BuiltSet<
        BstocksPreviewRouteLegVenueEnum>(const <BstocksPreviewRouteLegVenueEnum>[
  _$bstocksPreviewRouteLegVenueEnum_propamm,
  _$bstocksPreviewRouteLegVenueEnum_pancakeV3,
  _$bstocksPreviewRouteLegVenueEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksPreviewRouteLegVenueEnum>
    _$bstocksPreviewRouteLegVenueEnumSerializer =
    _$BstocksPreviewRouteLegVenueEnumSerializer();

class _$BstocksPreviewRouteLegVenueEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewRouteLegVenueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'propamm': 'propamm',
    'pancakeV3': 'pancake_v3',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'propamm': 'propamm',
    'pancake_v3': 'pancakeV3',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksPreviewRouteLegVenueEnum];
  @override
  final String wireName = 'BstocksPreviewRouteLegVenueEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksPreviewRouteLegVenueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewRouteLegVenueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewRouteLegVenueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewRouteLeg extends BstocksPreviewRouteLeg {
  @override
  final BstocksPreviewRouteLegVenueEnum venue;
  @override
  final String amountInRaw;
  @override
  final String amountOutRaw;
  @override
  final int? feeTier;
  @override
  final String quoteReference;

  factory _$BstocksPreviewRouteLeg(
          [void Function(BstocksPreviewRouteLegBuilder)? updates]) =>
      (BstocksPreviewRouteLegBuilder()..update(updates))._build();

  _$BstocksPreviewRouteLeg._(
      {required this.venue,
      required this.amountInRaw,
      required this.amountOutRaw,
      this.feeTier,
      required this.quoteReference})
      : super._();
  @override
  BstocksPreviewRouteLeg rebuild(
          void Function(BstocksPreviewRouteLegBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewRouteLegBuilder toBuilder() =>
      BstocksPreviewRouteLegBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewRouteLeg &&
        venue == other.venue &&
        amountInRaw == other.amountInRaw &&
        amountOutRaw == other.amountOutRaw &&
        feeTier == other.feeTier &&
        quoteReference == other.quoteReference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, venue.hashCode);
    _$hash = $jc(_$hash, amountInRaw.hashCode);
    _$hash = $jc(_$hash, amountOutRaw.hashCode);
    _$hash = $jc(_$hash, feeTier.hashCode);
    _$hash = $jc(_$hash, quoteReference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewRouteLeg')
          ..add('venue', venue)
          ..add('amountInRaw', amountInRaw)
          ..add('amountOutRaw', amountOutRaw)
          ..add('feeTier', feeTier)
          ..add('quoteReference', quoteReference))
        .toString();
  }
}

class BstocksPreviewRouteLegBuilder
    implements Builder<BstocksPreviewRouteLeg, BstocksPreviewRouteLegBuilder> {
  _$BstocksPreviewRouteLeg? _$v;

  BstocksPreviewRouteLegVenueEnum? _venue;
  BstocksPreviewRouteLegVenueEnum? get venue => _$this._venue;
  set venue(BstocksPreviewRouteLegVenueEnum? venue) => _$this._venue = venue;

  String? _amountInRaw;
  String? get amountInRaw => _$this._amountInRaw;
  set amountInRaw(String? amountInRaw) => _$this._amountInRaw = amountInRaw;

  String? _amountOutRaw;
  String? get amountOutRaw => _$this._amountOutRaw;
  set amountOutRaw(String? amountOutRaw) => _$this._amountOutRaw = amountOutRaw;

  int? _feeTier;
  int? get feeTier => _$this._feeTier;
  set feeTier(int? feeTier) => _$this._feeTier = feeTier;

  String? _quoteReference;
  String? get quoteReference => _$this._quoteReference;
  set quoteReference(String? quoteReference) =>
      _$this._quoteReference = quoteReference;

  BstocksPreviewRouteLegBuilder() {
    BstocksPreviewRouteLeg._defaults(this);
  }

  BstocksPreviewRouteLegBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _venue = $v.venue;
      _amountInRaw = $v.amountInRaw;
      _amountOutRaw = $v.amountOutRaw;
      _feeTier = $v.feeTier;
      _quoteReference = $v.quoteReference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewRouteLeg other) {
    _$v = other as _$BstocksPreviewRouteLeg;
  }

  @override
  void update(void Function(BstocksPreviewRouteLegBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewRouteLeg build() => _build();

  _$BstocksPreviewRouteLeg _build() {
    final _$result = _$v ??
        _$BstocksPreviewRouteLeg._(
          venue: BuiltValueNullFieldError.checkNotNull(
              venue, r'BstocksPreviewRouteLeg', 'venue'),
          amountInRaw: BuiltValueNullFieldError.checkNotNull(
              amountInRaw, r'BstocksPreviewRouteLeg', 'amountInRaw'),
          amountOutRaw: BuiltValueNullFieldError.checkNotNull(
              amountOutRaw, r'BstocksPreviewRouteLeg', 'amountOutRaw'),
          feeTier: feeTier,
          quoteReference: BuiltValueNullFieldError.checkNotNull(
              quoteReference, r'BstocksPreviewRouteLeg', 'quoteReference'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
