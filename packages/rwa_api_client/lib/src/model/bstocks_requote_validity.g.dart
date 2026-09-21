// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_requote_validity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksRequoteValidityKindEnum
    _$bstocksRequoteValidityKindEnum_requoteOnConfirmation =
    const BstocksRequoteValidityKindEnum._('requoteOnConfirmation');
const BstocksRequoteValidityKindEnum
    _$bstocksRequoteValidityKindEnum_unknownDefaultOpenApi =
    const BstocksRequoteValidityKindEnum._('unknownDefaultOpenApi');

BstocksRequoteValidityKindEnum _$bstocksRequoteValidityKindEnumValueOf(
    String name) {
  switch (name) {
    case 'requoteOnConfirmation':
      return _$bstocksRequoteValidityKindEnum_requoteOnConfirmation;
    case 'unknownDefaultOpenApi':
      return _$bstocksRequoteValidityKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksRequoteValidityKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksRequoteValidityKindEnum>
    _$bstocksRequoteValidityKindEnumValues = BuiltSet<
        BstocksRequoteValidityKindEnum>(const <BstocksRequoteValidityKindEnum>[
  _$bstocksRequoteValidityKindEnum_requoteOnConfirmation,
  _$bstocksRequoteValidityKindEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksRequoteValidityKindEnum>
    _$bstocksRequoteValidityKindEnumSerializer =
    _$BstocksRequoteValidityKindEnumSerializer();

class _$BstocksRequoteValidityKindEnumSerializer
    implements PrimitiveSerializer<BstocksRequoteValidityKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'requoteOnConfirmation': 'requote_on_confirmation',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'requote_on_confirmation': 'requoteOnConfirmation',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksRequoteValidityKindEnum];
  @override
  final String wireName = 'BstocksRequoteValidityKindEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksRequoteValidityKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksRequoteValidityKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksRequoteValidityKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksRequoteValidity extends BstocksRequoteValidity {
  @override
  final BstocksRequoteValidityKindEnum kind;

  factory _$BstocksRequoteValidity(
          [void Function(BstocksRequoteValidityBuilder)? updates]) =>
      (BstocksRequoteValidityBuilder()..update(updates))._build();

  _$BstocksRequoteValidity._({required this.kind}) : super._();
  @override
  BstocksRequoteValidity rebuild(
          void Function(BstocksRequoteValidityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksRequoteValidityBuilder toBuilder() =>
      BstocksRequoteValidityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksRequoteValidity && kind == other.kind;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksRequoteValidity')
          ..add('kind', kind))
        .toString();
  }
}

class BstocksRequoteValidityBuilder
    implements Builder<BstocksRequoteValidity, BstocksRequoteValidityBuilder> {
  _$BstocksRequoteValidity? _$v;

  BstocksRequoteValidityKindEnum? _kind;
  BstocksRequoteValidityKindEnum? get kind => _$this._kind;
  set kind(BstocksRequoteValidityKindEnum? kind) => _$this._kind = kind;

  BstocksRequoteValidityBuilder() {
    BstocksRequoteValidity._defaults(this);
  }

  BstocksRequoteValidityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksRequoteValidity other) {
    _$v = other as _$BstocksRequoteValidity;
  }

  @override
  void update(void Function(BstocksRequoteValidityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksRequoteValidity build() => _build();

  _$BstocksRequoteValidity _build() {
    final _$result = _$v ??
        _$BstocksRequoteValidity._(
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'BstocksRequoteValidity', 'kind'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
