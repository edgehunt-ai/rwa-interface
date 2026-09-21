// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_economics_quote_validity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewEconomicsQuoteValidityKindEnum
    _$bstocksPreviewEconomicsQuoteValidityKindEnum_requoteOnConfirmation =
    const BstocksPreviewEconomicsQuoteValidityKindEnum._(
        'requoteOnConfirmation');
const BstocksPreviewEconomicsQuoteValidityKindEnum
    _$bstocksPreviewEconomicsQuoteValidityKindEnum_unknownDefaultOpenApi =
    const BstocksPreviewEconomicsQuoteValidityKindEnum._(
        'unknownDefaultOpenApi');

BstocksPreviewEconomicsQuoteValidityKindEnum
    _$bstocksPreviewEconomicsQuoteValidityKindEnumValueOf(String name) {
  switch (name) {
    case 'requoteOnConfirmation':
      return _$bstocksPreviewEconomicsQuoteValidityKindEnum_requoteOnConfirmation;
    case 'unknownDefaultOpenApi':
      return _$bstocksPreviewEconomicsQuoteValidityKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksPreviewEconomicsQuoteValidityKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksPreviewEconomicsQuoteValidityKindEnum>
    _$bstocksPreviewEconomicsQuoteValidityKindEnumValues = BuiltSet<
        BstocksPreviewEconomicsQuoteValidityKindEnum>(const <BstocksPreviewEconomicsQuoteValidityKindEnum>[
  _$bstocksPreviewEconomicsQuoteValidityKindEnum_requoteOnConfirmation,
  _$bstocksPreviewEconomicsQuoteValidityKindEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksPreviewEconomicsQuoteValidityKindEnum>
    _$bstocksPreviewEconomicsQuoteValidityKindEnumSerializer =
    _$BstocksPreviewEconomicsQuoteValidityKindEnumSerializer();

class _$BstocksPreviewEconomicsQuoteValidityKindEnumSerializer
    implements
        PrimitiveSerializer<BstocksPreviewEconomicsQuoteValidityKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'requoteOnConfirmation': 'requote_on_confirmation',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'requote_on_confirmation': 'requoteOnConfirmation',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksPreviewEconomicsQuoteValidityKindEnum
  ];
  @override
  final String wireName = 'BstocksPreviewEconomicsQuoteValidityKindEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksPreviewEconomicsQuoteValidityKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewEconomicsQuoteValidityKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewEconomicsQuoteValidityKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewEconomicsQuoteValidity
    extends BstocksPreviewEconomicsQuoteValidity {
  @override
  final OneOf oneOf;

  factory _$BstocksPreviewEconomicsQuoteValidity(
          [void Function(BstocksPreviewEconomicsQuoteValidityBuilder)?
              updates]) =>
      (BstocksPreviewEconomicsQuoteValidityBuilder()..update(updates))._build();

  _$BstocksPreviewEconomicsQuoteValidity._({required this.oneOf}) : super._();
  @override
  BstocksPreviewEconomicsQuoteValidity rebuild(
          void Function(BstocksPreviewEconomicsQuoteValidityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewEconomicsQuoteValidityBuilder toBuilder() =>
      BstocksPreviewEconomicsQuoteValidityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewEconomicsQuoteValidity &&
        oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'BstocksPreviewEconomicsQuoteValidity')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class BstocksPreviewEconomicsQuoteValidityBuilder
    implements
        Builder<BstocksPreviewEconomicsQuoteValidity,
            BstocksPreviewEconomicsQuoteValidityBuilder> {
  _$BstocksPreviewEconomicsQuoteValidity? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  BstocksPreviewEconomicsQuoteValidityBuilder() {
    BstocksPreviewEconomicsQuoteValidity._defaults(this);
  }

  BstocksPreviewEconomicsQuoteValidityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewEconomicsQuoteValidity other) {
    _$v = other as _$BstocksPreviewEconomicsQuoteValidity;
  }

  @override
  void update(
      void Function(BstocksPreviewEconomicsQuoteValidityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewEconomicsQuoteValidity build() => _build();

  _$BstocksPreviewEconomicsQuoteValidity _build() {
    final _$result = _$v ??
        _$BstocksPreviewEconomicsQuoteValidity._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'BstocksPreviewEconomicsQuoteValidity', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
