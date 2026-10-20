// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_financial_asset_identity_not.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KnownFinancialAssetIdentityNotNamespaceEnum
    _$knownFinancialAssetIdentityNotNamespaceEnum_hyperliquid =
    const KnownFinancialAssetIdentityNotNamespaceEnum._('hyperliquid');

KnownFinancialAssetIdentityNotNamespaceEnum
    _$knownFinancialAssetIdentityNotNamespaceEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquid':
      return _$knownFinancialAssetIdentityNotNamespaceEnum_hyperliquid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialAssetIdentityNotNamespaceEnum>
    _$knownFinancialAssetIdentityNotNamespaceEnumValues = BuiltSet<
        KnownFinancialAssetIdentityNotNamespaceEnum>(const <KnownFinancialAssetIdentityNotNamespaceEnum>[
  _$knownFinancialAssetIdentityNotNamespaceEnum_hyperliquid,
]);

Serializer<KnownFinancialAssetIdentityNotNamespaceEnum>
    _$knownFinancialAssetIdentityNotNamespaceEnumSerializer =
    _$KnownFinancialAssetIdentityNotNamespaceEnumSerializer();

class _$KnownFinancialAssetIdentityNotNamespaceEnumSerializer
    implements
        PrimitiveSerializer<KnownFinancialAssetIdentityNotNamespaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquid': 'hyperliquid',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hyperliquid': 'hyperliquid',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KnownFinancialAssetIdentityNotNamespaceEnum
  ];
  @override
  final String wireName = 'KnownFinancialAssetIdentityNotNamespaceEnum';

  @override
  Object serialize(Serializers serializers,
          KnownFinancialAssetIdentityNotNamespaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialAssetIdentityNotNamespaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialAssetIdentityNotNamespaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialAssetIdentityNot extends KnownFinancialAssetIdentityNot {
  @override
  final KnownFinancialAssetIdentityNotNamespaceEnum namespace;

  factory _$KnownFinancialAssetIdentityNot(
          [void Function(KnownFinancialAssetIdentityNotBuilder)? updates]) =>
      (KnownFinancialAssetIdentityNotBuilder()..update(updates))._build();

  _$KnownFinancialAssetIdentityNot._({required this.namespace}) : super._();
  @override
  KnownFinancialAssetIdentityNot rebuild(
          void Function(KnownFinancialAssetIdentityNotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnownFinancialAssetIdentityNotBuilder toBuilder() =>
      KnownFinancialAssetIdentityNotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnownFinancialAssetIdentityNot &&
        namespace == other.namespace;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, namespace.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnownFinancialAssetIdentityNot')
          ..add('namespace', namespace))
        .toString();
  }
}

class KnownFinancialAssetIdentityNotBuilder
    implements
        Builder<KnownFinancialAssetIdentityNot,
            KnownFinancialAssetIdentityNotBuilder> {
  _$KnownFinancialAssetIdentityNot? _$v;

  KnownFinancialAssetIdentityNotNamespaceEnum? _namespace;
  KnownFinancialAssetIdentityNotNamespaceEnum? get namespace =>
      _$this._namespace;
  set namespace(KnownFinancialAssetIdentityNotNamespaceEnum? namespace) =>
      _$this._namespace = namespace;

  KnownFinancialAssetIdentityNotBuilder() {
    KnownFinancialAssetIdentityNot._defaults(this);
  }

  KnownFinancialAssetIdentityNotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _namespace = $v.namespace;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnownFinancialAssetIdentityNot other) {
    _$v = other as _$KnownFinancialAssetIdentityNot;
  }

  @override
  void update(void Function(KnownFinancialAssetIdentityNotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnownFinancialAssetIdentityNot build() => _build();

  _$KnownFinancialAssetIdentityNot _build() {
    final _$result = _$v ??
        _$KnownFinancialAssetIdentityNot._(
          namespace: BuiltValueNullFieldError.checkNotNull(
              namespace, r'KnownFinancialAssetIdentityNot', 'namespace'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
