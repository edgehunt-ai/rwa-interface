// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_testnet_funding_target_balance_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockTestnetFundingTargetBalanceSnapshotAccountEnum
    _$bstockTestnetFundingTargetBalanceSnapshotAccountEnum_bstocks =
    const BstockTestnetFundingTargetBalanceSnapshotAccountEnum._('bstocks');

BstockTestnetFundingTargetBalanceSnapshotAccountEnum
    _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumValueOf(String name) {
  switch (name) {
    case 'bstocks':
      return _$bstockTestnetFundingTargetBalanceSnapshotAccountEnum_bstocks;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingTargetBalanceSnapshotAccountEnum>
    _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumValues = BuiltSet<
        BstockTestnetFundingTargetBalanceSnapshotAccountEnum>(const <BstockTestnetFundingTargetBalanceSnapshotAccountEnum>[
  _$bstockTestnetFundingTargetBalanceSnapshotAccountEnum_bstocks,
]);

const BstockTestnetFundingTargetBalanceSnapshotSource_Enum
    _$bstockTestnetFundingTargetBalanceSnapshotSourceEnum_bscRpc =
    const BstockTestnetFundingTargetBalanceSnapshotSource_Enum._('bscRpc');

BstockTestnetFundingTargetBalanceSnapshotSource_Enum
    _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumValueOf(String name) {
  switch (name) {
    case 'bscRpc':
      return _$bstockTestnetFundingTargetBalanceSnapshotSourceEnum_bscRpc;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingTargetBalanceSnapshotSource_Enum>
    _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumValues = BuiltSet<
        BstockTestnetFundingTargetBalanceSnapshotSource_Enum>(const <BstockTestnetFundingTargetBalanceSnapshotSource_Enum>[
  _$bstockTestnetFundingTargetBalanceSnapshotSourceEnum_bscRpc,
]);

Serializer<BstockTestnetFundingTargetBalanceSnapshotAccountEnum>
    _$bstockTestnetFundingTargetBalanceSnapshotAccountEnumSerializer =
    _$BstockTestnetFundingTargetBalanceSnapshotAccountEnumSerializer();
Serializer<BstockTestnetFundingTargetBalanceSnapshotSource_Enum>
    _$bstockTestnetFundingTargetBalanceSnapshotSourceEnumSerializer =
    _$BstockTestnetFundingTargetBalanceSnapshotSource_EnumSerializer();

class _$BstockTestnetFundingTargetBalanceSnapshotAccountEnumSerializer
    implements
        PrimitiveSerializer<
            BstockTestnetFundingTargetBalanceSnapshotAccountEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstocks': 'bstocks',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstocks': 'bstocks',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockTestnetFundingTargetBalanceSnapshotAccountEnum
  ];
  @override
  final String wireName =
      'BstockTestnetFundingTargetBalanceSnapshotAccountEnum';

  @override
  Object serialize(Serializers serializers,
          BstockTestnetFundingTargetBalanceSnapshotAccountEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingTargetBalanceSnapshotAccountEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingTargetBalanceSnapshotAccountEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingTargetBalanceSnapshotSource_EnumSerializer
    implements
        PrimitiveSerializer<
            BstockTestnetFundingTargetBalanceSnapshotSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bscRpc': 'bsc_rpc',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bsc_rpc': 'bscRpc',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockTestnetFundingTargetBalanceSnapshotSource_Enum
  ];
  @override
  final String wireName =
      'BstockTestnetFundingTargetBalanceSnapshotSource_Enum';

  @override
  Object serialize(Serializers serializers,
          BstockTestnetFundingTargetBalanceSnapshotSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingTargetBalanceSnapshotSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingTargetBalanceSnapshotSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingTargetBalanceSnapshot
    extends BstockTestnetFundingTargetBalanceSnapshot {
  @override
  final BstockTestnetFundingTargetBalanceSnapshotAccountEnum account;
  @override
  final String accountRef;
  @override
  final BstockTestnetFundingTargetAsset asset;
  @override
  final String availableAmount;
  @override
  final BstockTestnetFundingTargetBalanceSnapshotSource_Enum source_;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$BstockTestnetFundingTargetBalanceSnapshot(
          [void Function(BstockTestnetFundingTargetBalanceSnapshotBuilder)?
              updates]) =>
      (BstockTestnetFundingTargetBalanceSnapshotBuilder()..update(updates))
          ._build();

  _$BstockTestnetFundingTargetBalanceSnapshot._(
      {required this.account,
      required this.accountRef,
      required this.asset,
      required this.availableAmount,
      required this.source_,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  BstockTestnetFundingTargetBalanceSnapshot rebuild(
          void Function(BstockTestnetFundingTargetBalanceSnapshotBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockTestnetFundingTargetBalanceSnapshotBuilder toBuilder() =>
      BstockTestnetFundingTargetBalanceSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockTestnetFundingTargetBalanceSnapshot &&
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
    return (newBuiltValueToStringHelper(
            r'BstockTestnetFundingTargetBalanceSnapshot')
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

class BstockTestnetFundingTargetBalanceSnapshotBuilder
    implements
        Builder<BstockTestnetFundingTargetBalanceSnapshot,
            BstockTestnetFundingTargetBalanceSnapshotBuilder> {
  _$BstockTestnetFundingTargetBalanceSnapshot? _$v;

  BstockTestnetFundingTargetBalanceSnapshotAccountEnum? _account;
  BstockTestnetFundingTargetBalanceSnapshotAccountEnum? get account =>
      _$this._account;
  set account(BstockTestnetFundingTargetBalanceSnapshotAccountEnum? account) =>
      _$this._account = account;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  BstockTestnetFundingTargetAssetBuilder? _asset;
  BstockTestnetFundingTargetAssetBuilder get asset =>
      _$this._asset ??= BstockTestnetFundingTargetAssetBuilder();
  set asset(BstockTestnetFundingTargetAssetBuilder? asset) =>
      _$this._asset = asset;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  BstockTestnetFundingTargetBalanceSnapshotSource_Enum? _source_;
  BstockTestnetFundingTargetBalanceSnapshotSource_Enum? get source_ =>
      _$this._source_;
  set source_(BstockTestnetFundingTargetBalanceSnapshotSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  BstockTestnetFundingTargetBalanceSnapshotBuilder() {
    BstockTestnetFundingTargetBalanceSnapshot._defaults(this);
  }

  BstockTestnetFundingTargetBalanceSnapshotBuilder get _$this {
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
  void replace(BstockTestnetFundingTargetBalanceSnapshot other) {
    _$v = other as _$BstockTestnetFundingTargetBalanceSnapshot;
  }

  @override
  void update(
      void Function(BstockTestnetFundingTargetBalanceSnapshotBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockTestnetFundingTargetBalanceSnapshot build() => _build();

  _$BstockTestnetFundingTargetBalanceSnapshot _build() {
    _$BstockTestnetFundingTargetBalanceSnapshot _$result;
    try {
      _$result = _$v ??
          _$BstockTestnetFundingTargetBalanceSnapshot._(
            account: BuiltValueNullFieldError.checkNotNull(account,
                r'BstockTestnetFundingTargetBalanceSnapshot', 'account'),
            accountRef: BuiltValueNullFieldError.checkNotNull(accountRef,
                r'BstockTestnetFundingTargetBalanceSnapshot', 'accountRef'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'BstockTestnetFundingTargetBalanceSnapshot',
                'availableAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(source_,
                r'BstockTestnetFundingTargetBalanceSnapshot', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'BstockTestnetFundingTargetBalanceSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(validUntil,
                r'BstockTestnetFundingTargetBalanceSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockTestnetFundingTargetBalanceSnapshot',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
