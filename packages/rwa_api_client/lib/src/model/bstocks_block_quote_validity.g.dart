// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_block_quote_validity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksBlockQuoteValidityKindEnum
    _$bstocksBlockQuoteValidityKindEnum_blockWindow =
    const BstocksBlockQuoteValidityKindEnum._('blockWindow');
const BstocksBlockQuoteValidityKindEnum
    _$bstocksBlockQuoteValidityKindEnum_unknownDefaultOpenApi =
    const BstocksBlockQuoteValidityKindEnum._('unknownDefaultOpenApi');

BstocksBlockQuoteValidityKindEnum _$bstocksBlockQuoteValidityKindEnumValueOf(
    String name) {
  switch (name) {
    case 'blockWindow':
      return _$bstocksBlockQuoteValidityKindEnum_blockWindow;
    case 'unknownDefaultOpenApi':
      return _$bstocksBlockQuoteValidityKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksBlockQuoteValidityKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksBlockQuoteValidityKindEnum>
    _$bstocksBlockQuoteValidityKindEnumValues = BuiltSet<
        BstocksBlockQuoteValidityKindEnum>(const <BstocksBlockQuoteValidityKindEnum>[
  _$bstocksBlockQuoteValidityKindEnum_blockWindow,
  _$bstocksBlockQuoteValidityKindEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksBlockQuoteValidityKindEnum>
    _$bstocksBlockQuoteValidityKindEnumSerializer =
    _$BstocksBlockQuoteValidityKindEnumSerializer();

class _$BstocksBlockQuoteValidityKindEnumSerializer
    implements PrimitiveSerializer<BstocksBlockQuoteValidityKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'blockWindow': 'block_window',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'block_window': 'blockWindow',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksBlockQuoteValidityKindEnum];
  @override
  final String wireName = 'BstocksBlockQuoteValidityKindEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksBlockQuoteValidityKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksBlockQuoteValidityKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksBlockQuoteValidityKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksBlockQuoteValidity extends BstocksBlockQuoteValidity {
  @override
  final BstocksBlockQuoteValidityKindEnum kind;
  @override
  final int validAfterBlock;
  @override
  final int validUntilBlock;

  factory _$BstocksBlockQuoteValidity(
          [void Function(BstocksBlockQuoteValidityBuilder)? updates]) =>
      (BstocksBlockQuoteValidityBuilder()..update(updates))._build();

  _$BstocksBlockQuoteValidity._(
      {required this.kind,
      required this.validAfterBlock,
      required this.validUntilBlock})
      : super._();
  @override
  BstocksBlockQuoteValidity rebuild(
          void Function(BstocksBlockQuoteValidityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksBlockQuoteValidityBuilder toBuilder() =>
      BstocksBlockQuoteValidityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksBlockQuoteValidity &&
        kind == other.kind &&
        validAfterBlock == other.validAfterBlock &&
        validUntilBlock == other.validUntilBlock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, validAfterBlock.hashCode);
    _$hash = $jc(_$hash, validUntilBlock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksBlockQuoteValidity')
          ..add('kind', kind)
          ..add('validAfterBlock', validAfterBlock)
          ..add('validUntilBlock', validUntilBlock))
        .toString();
  }
}

class BstocksBlockQuoteValidityBuilder
    implements
        Builder<BstocksBlockQuoteValidity, BstocksBlockQuoteValidityBuilder> {
  _$BstocksBlockQuoteValidity? _$v;

  BstocksBlockQuoteValidityKindEnum? _kind;
  BstocksBlockQuoteValidityKindEnum? get kind => _$this._kind;
  set kind(BstocksBlockQuoteValidityKindEnum? kind) => _$this._kind = kind;

  int? _validAfterBlock;
  int? get validAfterBlock => _$this._validAfterBlock;
  set validAfterBlock(int? validAfterBlock) =>
      _$this._validAfterBlock = validAfterBlock;

  int? _validUntilBlock;
  int? get validUntilBlock => _$this._validUntilBlock;
  set validUntilBlock(int? validUntilBlock) =>
      _$this._validUntilBlock = validUntilBlock;

  BstocksBlockQuoteValidityBuilder() {
    BstocksBlockQuoteValidity._defaults(this);
  }

  BstocksBlockQuoteValidityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _validAfterBlock = $v.validAfterBlock;
      _validUntilBlock = $v.validUntilBlock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksBlockQuoteValidity other) {
    _$v = other as _$BstocksBlockQuoteValidity;
  }

  @override
  void update(void Function(BstocksBlockQuoteValidityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksBlockQuoteValidity build() => _build();

  _$BstocksBlockQuoteValidity _build() {
    final _$result = _$v ??
        _$BstocksBlockQuoteValidity._(
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'BstocksBlockQuoteValidity', 'kind'),
          validAfterBlock: BuiltValueNullFieldError.checkNotNull(
              validAfterBlock, r'BstocksBlockQuoteValidity', 'validAfterBlock'),
          validUntilBlock: BuiltValueNullFieldError.checkNotNull(
              validUntilBlock, r'BstocksBlockQuoteValidity', 'validUntilBlock'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
