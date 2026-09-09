// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_funding_target_balance_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpFundingTargetBalanceSnapshotAccountEnum
    _$perpFundingTargetBalanceSnapshotAccountEnum_hip3 =
    const PerpFundingTargetBalanceSnapshotAccountEnum._('hip3');
const PerpFundingTargetBalanceSnapshotAccountEnum
    _$perpFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi =
    const PerpFundingTargetBalanceSnapshotAccountEnum._(
        'unknownDefaultOpenApi');

PerpFundingTargetBalanceSnapshotAccountEnum
    _$perpFundingTargetBalanceSnapshotAccountEnumValueOf(String name) {
  switch (name) {
    case 'hip3':
      return _$perpFundingTargetBalanceSnapshotAccountEnum_hip3;
    case 'unknownDefaultOpenApi':
      return _$perpFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingTargetBalanceSnapshotAccountEnum>
    _$perpFundingTargetBalanceSnapshotAccountEnumValues = BuiltSet<
        PerpFundingTargetBalanceSnapshotAccountEnum>(const <PerpFundingTargetBalanceSnapshotAccountEnum>[
  _$perpFundingTargetBalanceSnapshotAccountEnum_hip3,
  _$perpFundingTargetBalanceSnapshotAccountEnum_unknownDefaultOpenApi,
]);

const PerpFundingTargetBalanceSnapshotSource_Enum
    _$perpFundingTargetBalanceSnapshotSourceEnum_hyperliquidInfo =
    const PerpFundingTargetBalanceSnapshotSource_Enum._('hyperliquidInfo');
const PerpFundingTargetBalanceSnapshotSource_Enum
    _$perpFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi =
    const PerpFundingTargetBalanceSnapshotSource_Enum._(
        'unknownDefaultOpenApi');

PerpFundingTargetBalanceSnapshotSource_Enum
    _$perpFundingTargetBalanceSnapshotSourceEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquidInfo':
      return _$perpFundingTargetBalanceSnapshotSourceEnum_hyperliquidInfo;
    case 'unknownDefaultOpenApi':
      return _$perpFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingTargetBalanceSnapshotSource_Enum>
    _$perpFundingTargetBalanceSnapshotSourceEnumValues = BuiltSet<
        PerpFundingTargetBalanceSnapshotSource_Enum>(const <PerpFundingTargetBalanceSnapshotSource_Enum>[
  _$perpFundingTargetBalanceSnapshotSourceEnum_hyperliquidInfo,
  _$perpFundingTargetBalanceSnapshotSourceEnum_unknownDefaultOpenApi,
]);

Serializer<PerpFundingTargetBalanceSnapshotAccountEnum>
    _$perpFundingTargetBalanceSnapshotAccountEnumSerializer =
    _$PerpFundingTargetBalanceSnapshotAccountEnumSerializer();
Serializer<PerpFundingTargetBalanceSnapshotSource_Enum>
    _$perpFundingTargetBalanceSnapshotSourceEnumSerializer =
    _$PerpFundingTargetBalanceSnapshotSource_EnumSerializer();

class _$PerpFundingTargetBalanceSnapshotAccountEnumSerializer
    implements
        PrimitiveSerializer<PerpFundingTargetBalanceSnapshotAccountEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3': 'hip3',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3': 'hip3',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PerpFundingTargetBalanceSnapshotAccountEnum
  ];
  @override
  final String wireName = 'PerpFundingTargetBalanceSnapshotAccountEnum';

  @override
  Object serialize(Serializers serializers,
          PerpFundingTargetBalanceSnapshotAccountEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingTargetBalanceSnapshotAccountEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingTargetBalanceSnapshotAccountEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingTargetBalanceSnapshotSource_EnumSerializer
    implements
        PrimitiveSerializer<PerpFundingTargetBalanceSnapshotSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquidInfo': 'hyperliquid_info',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hyperliquid_info': 'hyperliquidInfo',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PerpFundingTargetBalanceSnapshotSource_Enum
  ];
  @override
  final String wireName = 'PerpFundingTargetBalanceSnapshotSource_Enum';

  @override
  Object serialize(Serializers serializers,
          PerpFundingTargetBalanceSnapshotSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingTargetBalanceSnapshotSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingTargetBalanceSnapshotSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingTargetBalanceSnapshot
    extends PerpFundingTargetBalanceSnapshot {
  @override
  final PerpFundingTargetBalanceSnapshotAccountEnum account;
  @override
  final String accountRef;
  @override
  final PerpFundingTargetAsset asset;
  @override
  final String availableAmount;
  @override
  final PerpFundingTargetBalanceSnapshotSource_Enum source_;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$PerpFundingTargetBalanceSnapshot(
          [void Function(PerpFundingTargetBalanceSnapshotBuilder)? updates]) =>
      (PerpFundingTargetBalanceSnapshotBuilder()..update(updates))._build();

  _$PerpFundingTargetBalanceSnapshot._(
      {required this.account,
      required this.accountRef,
      required this.asset,
      required this.availableAmount,
      required this.source_,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  PerpFundingTargetBalanceSnapshot rebuild(
          void Function(PerpFundingTargetBalanceSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingTargetBalanceSnapshotBuilder toBuilder() =>
      PerpFundingTargetBalanceSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingTargetBalanceSnapshot &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingTargetBalanceSnapshot')
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

class PerpFundingTargetBalanceSnapshotBuilder
    implements
        Builder<PerpFundingTargetBalanceSnapshot,
            PerpFundingTargetBalanceSnapshotBuilder> {
  _$PerpFundingTargetBalanceSnapshot? _$v;

  PerpFundingTargetBalanceSnapshotAccountEnum? _account;
  PerpFundingTargetBalanceSnapshotAccountEnum? get account => _$this._account;
  set account(PerpFundingTargetBalanceSnapshotAccountEnum? account) =>
      _$this._account = account;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  PerpFundingTargetAssetBuilder? _asset;
  PerpFundingTargetAssetBuilder get asset =>
      _$this._asset ??= PerpFundingTargetAssetBuilder();
  set asset(PerpFundingTargetAssetBuilder? asset) => _$this._asset = asset;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  PerpFundingTargetBalanceSnapshotSource_Enum? _source_;
  PerpFundingTargetBalanceSnapshotSource_Enum? get source_ => _$this._source_;
  set source_(PerpFundingTargetBalanceSnapshotSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  PerpFundingTargetBalanceSnapshotBuilder() {
    PerpFundingTargetBalanceSnapshot._defaults(this);
  }

  PerpFundingTargetBalanceSnapshotBuilder get _$this {
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
  void replace(PerpFundingTargetBalanceSnapshot other) {
    _$v = other as _$PerpFundingTargetBalanceSnapshot;
  }

  @override
  void update(void Function(PerpFundingTargetBalanceSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpFundingTargetBalanceSnapshot build() => _build();

  _$PerpFundingTargetBalanceSnapshot _build() {
    _$PerpFundingTargetBalanceSnapshot _$result;
    try {
      _$result = _$v ??
          _$PerpFundingTargetBalanceSnapshot._(
            account: BuiltValueNullFieldError.checkNotNull(
                account, r'PerpFundingTargetBalanceSnapshot', 'account'),
            accountRef: BuiltValueNullFieldError.checkNotNull(
                accountRef, r'PerpFundingTargetBalanceSnapshot', 'accountRef'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'PerpFundingTargetBalanceSnapshot',
                'availableAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'PerpFundingTargetBalanceSnapshot', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'PerpFundingTargetBalanceSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'PerpFundingTargetBalanceSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpFundingTargetBalanceSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
