// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hyperliquid_signature.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HyperliquidSignatureVEnum _$hyperliquidSignatureVEnum_number27 =
    const HyperliquidSignatureVEnum._('number27');
const HyperliquidSignatureVEnum _$hyperliquidSignatureVEnum_number28 =
    const HyperliquidSignatureVEnum._('number28');
const HyperliquidSignatureVEnum
    _$hyperliquidSignatureVEnum_unknownDefaultOpenApi =
    const HyperliquidSignatureVEnum._('unknownDefaultOpenApi');

HyperliquidSignatureVEnum _$hyperliquidSignatureVEnumValueOf(String name) {
  switch (name) {
    case 'number27':
      return _$hyperliquidSignatureVEnum_number27;
    case 'number28':
      return _$hyperliquidSignatureVEnum_number28;
    case 'unknownDefaultOpenApi':
      return _$hyperliquidSignatureVEnum_unknownDefaultOpenApi;
    default:
      return _$hyperliquidSignatureVEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HyperliquidSignatureVEnum> _$hyperliquidSignatureVEnumValues =
    BuiltSet<HyperliquidSignatureVEnum>(const <HyperliquidSignatureVEnum>[
  _$hyperliquidSignatureVEnum_number27,
  _$hyperliquidSignatureVEnum_number28,
  _$hyperliquidSignatureVEnum_unknownDefaultOpenApi,
]);

Serializer<HyperliquidSignatureVEnum> _$hyperliquidSignatureVEnumSerializer =
    _$HyperliquidSignatureVEnumSerializer();

class _$HyperliquidSignatureVEnumSerializer
    implements PrimitiveSerializer<HyperliquidSignatureVEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number27': 27,
    'number28': 28,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    27: 'number27',
    28: 'number28',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HyperliquidSignatureVEnum];
  @override
  final String wireName = 'HyperliquidSignatureVEnum';

  @override
  Object serialize(Serializers serializers, HyperliquidSignatureVEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  HyperliquidSignatureVEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HyperliquidSignatureVEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$HyperliquidSignature extends HyperliquidSignature {
  @override
  final String r;
  @override
  final String s;
  @override
  final HyperliquidSignatureVEnum v;

  factory _$HyperliquidSignature(
          [void Function(HyperliquidSignatureBuilder)? updates]) =>
      (HyperliquidSignatureBuilder()..update(updates))._build();

  _$HyperliquidSignature._({required this.r, required this.s, required this.v})
      : super._();
  @override
  HyperliquidSignature rebuild(
          void Function(HyperliquidSignatureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HyperliquidSignatureBuilder toBuilder() =>
      HyperliquidSignatureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HyperliquidSignature &&
        r == other.r &&
        s == other.s &&
        v == other.v;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, r.hashCode);
    _$hash = $jc(_$hash, s.hashCode);
    _$hash = $jc(_$hash, v.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HyperliquidSignature')
          ..add('r', r)
          ..add('s', s)
          ..add('v', v))
        .toString();
  }
}

class HyperliquidSignatureBuilder
    implements Builder<HyperliquidSignature, HyperliquidSignatureBuilder> {
  _$HyperliquidSignature? _$v;

  String? _r;
  String? get r => _$this._r;
  set r(String? r) => _$this._r = r;

  String? _s;
  String? get s => _$this._s;
  set s(String? s) => _$this._s = s;

  HyperliquidSignatureVEnum? _v;
  HyperliquidSignatureVEnum? get v => _$this._v;
  set v(HyperliquidSignatureVEnum? v) => _$this._v = v;

  HyperliquidSignatureBuilder() {
    HyperliquidSignature._defaults(this);
  }

  HyperliquidSignatureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _r = $v.r;
      _s = $v.s;
      _v = $v.v;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HyperliquidSignature other) {
    _$v = other as _$HyperliquidSignature;
  }

  @override
  void update(void Function(HyperliquidSignatureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HyperliquidSignature build() => _build();

  _$HyperliquidSignature _build() {
    final _$result = _$v ??
        _$HyperliquidSignature._(
          r: BuiltValueNullFieldError.checkNotNull(
              r, r'HyperliquidSignature', 'r'),
          s: BuiltValueNullFieldError.checkNotNull(
              s, r'HyperliquidSignature', 's'),
          v: BuiltValueNullFieldError.checkNotNull(
              v, r'HyperliquidSignature', 'v'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
