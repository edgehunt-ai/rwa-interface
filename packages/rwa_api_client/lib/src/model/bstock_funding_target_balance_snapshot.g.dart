// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_funding_target_balance_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockFundingTargetBalanceSnapshotAccountEnum
    _$bstockFundingTargetBalanceSnapshotAccountEnum_bstocks =
    const BstockFundingTargetBalanceSnapshotAccountEnum._('bstocks');
const BstockFundingTargetBalanceSnapshotAccountEnum
    _$bstockFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi =
    const BstockFundingTargetBalanceSnapshotAccountEnum._(
        'unknownDefaultOpenApi');

BstockFundingTargetBalanceSnapshotAccountEnum
    _$bstockFundingTargetBalanceSnapshotAccountEnumValueOf(String name) {
  switch (name) {
    case 'bstocks':
      return _$bstockFundingTargetBalanceSnapshotAccountEnum_bstocks;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingTargetBalanceSnapshotAccountEnum>
    _$bstockFundingTargetBalanceSnapshotAccountEnumValues = BuiltSet<
        BstockFundingTargetBalanceSnapshotAccountEnum>(const <BstockFundingTargetBalanceSnapshotAccountEnum>[
  _$bstockFundingTargetBalanceSnapshotAccountEnum_bstocks,
  _$bstockFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi,
]);

const BstockFundingTargetBalanceSnapshotSource_Enum
    _$bstockFundingTargetBalanceSnapshotSourceEnum_bscRpc =
    const BstockFundingTargetBalanceSnapshotSource_Enum._('bscRpc');
const BstockFundingTargetBalanceSnapshotSource_Enum
    _$bstockFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi =
    const BstockFundingTargetBalanceSnapshotSource_Enum._(
        'unknownDefaultOpenApi');

BstockFundingTargetBalanceSnapshotSource_Enum
    _$bstockFundingTargetBalanceSnapshotSourceEnumValueOf(String name) {
  switch (name) {
    case 'bscRpc':
      return _$bstockFundingTargetBalanceSnapshotSourceEnum_bscRpc;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingTargetBalanceSnapshotSource_Enum>
    _$bstockFundingTargetBalanceSnapshotSourceEnumValues = BuiltSet<
        BstockFundingTargetBalanceSnapshotSource_Enum>(const <BstockFundingTargetBalanceSnapshotSource_Enum>[
  _$bstockFundingTargetBalanceSnapshotSourceEnum_bscRpc,
  _$bstockFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingTargetBalanceSnapshotAccountEnum>
    _$bstockFundingTargetBalanceSnapshotAccountEnumSerializer =
    _$BstockFundingTargetBalanceSnapshotAccountEnumSerializer();
Serializer<BstockFundingTargetBalanceSnapshotSource_Enum>
    _$bstockFundingTargetBalanceSnapshotSourceEnumSerializer =
    _$BstockFundingTargetBalanceSnapshotSource_EnumSerializer();

class _$BstockFundingTargetBalanceSnapshotAccountEnumSerializer
    implements
        PrimitiveSerializer<BstockFundingTargetBalanceSnapshotAccountEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstocks': 'bstocks',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstocks': 'bstocks',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockFundingTargetBalanceSnapshotAccountEnum
  ];
  @override
  final String wireName = 'BstockFundingTargetBalanceSnapshotAccountEnum';

  @override
  Object serialize(Serializers serializers,
          BstockFundingTargetBalanceSnapshotAccountEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingTargetBalanceSnapshotAccountEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingTargetBalanceSnapshotAccountEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingTargetBalanceSnapshotSource_EnumSerializer
    implements
        PrimitiveSerializer<BstockFundingTargetBalanceSnapshotSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bscRpc': 'bsc_rpc',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bsc_rpc': 'bscRpc',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockFundingTargetBalanceSnapshotSource_Enum
  ];
  @override
  final String wireName = 'BstockFundingTargetBalanceSnapshotSource_Enum';

  @override
  Object serialize(Serializers serializers,
          BstockFundingTargetBalanceSnapshotSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingTargetBalanceSnapshotSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingTargetBalanceSnapshotSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingTargetBalanceSnapshot
    extends BstockFundingTargetBalanceSnapshot {
  @override
  final BstockFundingTargetBalanceSnapshotAccountEnum account;
  @override
  final String accountRef;
  @override
  final BstockFundingTargetAsset asset;
  @override
  final String availableAmount;
  @override
  final BstockFundingTargetBalanceSnapshotSource_Enum source_;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$BstockFundingTargetBalanceSnapshot(
          [void Function(BstockFundingTargetBalanceSnapshotBuilder)?
              updates]) =>
      (BstockFundingTargetBalanceSnapshotBuilder()..update(updates))._build();

  _$BstockFundingTargetBalanceSnapshot._(
      {required this.account,
      required this.accountRef,
      required this.asset,
      required this.availableAmount,
      required this.source_,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  BstockFundingTargetBalanceSnapshot rebuild(
          void Function(BstockFundingTargetBalanceSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockFundingTargetBalanceSnapshotBuilder toBuilder() =>
      BstockFundingTargetBalanceSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockFundingTargetBalanceSnapshot &&
        account == other.account &&
        accountRef == other.accountRef &&
        asset == other.asset &&
        availableAmount == other.availableAmount &&
        source_ == other.source_ &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableAmount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockFundingTargetBalanceSnapshot')
          ..add('account', account)
          ..add('accountRef', accountRef)
          ..add('asset', asset)
          ..add('availableAmount', availableAmount)
          ..add('source_', source_)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class BstockFundingTargetBalanceSnapshotBuilder
    implements
        Builder<BstockFundingTargetBalanceSnapshot,
            BstockFundingTargetBalanceSnapshotBuilder> {
  _$BstockFundingTargetBalanceSnapshot? _$v;

  BstockFundingTargetBalanceSnapshotAccountEnum? _account;
  BstockFundingTargetBalanceSnapshotAccountEnum? get account => _$this._account;
  set account(BstockFundingTargetBalanceSnapshotAccountEnum? account) =>
      _$this._account = account;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  BstockFundingTargetAssetBuilder? _asset;
  BstockFundingTargetAssetBuilder get asset =>
      _$this._asset ??= BstockFundingTargetAssetBuilder();
  set asset(BstockFundingTargetAssetBuilder? asset) => _$this._asset = asset;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  BstockFundingTargetBalanceSnapshotSource_Enum? _source_;
  BstockFundingTargetBalanceSnapshotSource_Enum? get source_ => _$this._source_;
  set source_(BstockFundingTargetBalanceSnapshotSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  BstockFundingTargetBalanceSnapshotBuilder() {
    BstockFundingTargetBalanceSnapshot._defaults(this);
  }

  BstockFundingTargetBalanceSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account;
      _accountRef = $v.accountRef;
      _asset = $v.asset.toBuilder();
      _availableAmount = $v.availableAmount;
      _source_ = $v.source_;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockFundingTargetBalanceSnapshot other) {
    _$v = other as _$BstockFundingTargetBalanceSnapshot;
  }

  @override
  void update(
      void Function(BstockFundingTargetBalanceSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockFundingTargetBalanceSnapshot build() => _build();

  _$BstockFundingTargetBalanceSnapshot _build() {
    _$BstockFundingTargetBalanceSnapshot _$result;
    try {
      _$result = _$v ??
          _$BstockFundingTargetBalanceSnapshot._(
            account: BuiltValueNullFieldError.checkNotNull(
                account, r'BstockFundingTargetBalanceSnapshot', 'account'),
            accountRef: BuiltValueNullFieldError.checkNotNull(accountRef,
                r'BstockFundingTargetBalanceSnapshot', 'accountRef'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'BstockFundingTargetBalanceSnapshot',
                'availableAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'BstockFundingTargetBalanceSnapshot', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'BstockFundingTargetBalanceSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(validUntil,
                r'BstockFundingTargetBalanceSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockFundingTargetBalanceSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
