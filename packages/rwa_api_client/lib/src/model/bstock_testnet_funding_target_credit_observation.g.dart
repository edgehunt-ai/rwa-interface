// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_testnet_funding_target_credit_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockTestnetFundingTargetCreditObservationSource_Enum
    _$bstockTestnetFundingTargetCreditObservationSourceEnum_bscRpc =
    const BstockTestnetFundingTargetCreditObservationSource_Enum._('bscRpc');

BstockTestnetFundingTargetCreditObservationSource_Enum
    _$bstockTestnetFundingTargetCreditObservationSourceEnumValueOf(
        String name) {
  switch (name) {
    case 'bscRpc':
      return _$bstockTestnetFundingTargetCreditObservationSourceEnum_bscRpc;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingTargetCreditObservationSource_Enum>
    _$bstockTestnetFundingTargetCreditObservationSourceEnumValues = BuiltSet<
        BstockTestnetFundingTargetCreditObservationSource_Enum>(const <BstockTestnetFundingTargetCreditObservationSource_Enum>[
  _$bstockTestnetFundingTargetCreditObservationSourceEnum_bscRpc,
]);

Serializer<BstockTestnetFundingTargetCreditObservationSource_Enum>
    _$bstockTestnetFundingTargetCreditObservationSourceEnumSerializer =
    _$BstockTestnetFundingTargetCreditObservationSource_EnumSerializer();

class _$BstockTestnetFundingTargetCreditObservationSource_EnumSerializer
    implements
        PrimitiveSerializer<
            BstockTestnetFundingTargetCreditObservationSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bscRpc': 'bsc_rpc',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bsc_rpc': 'bscRpc',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockTestnetFundingTargetCreditObservationSource_Enum
  ];
  @override
  final String wireName =
      'BstockTestnetFundingTargetCreditObservationSource_Enum';

  @override
  Object serialize(Serializers serializers,
          BstockTestnetFundingTargetCreditObservationSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingTargetCreditObservationSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingTargetCreditObservationSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingTargetCreditObservation
    extends BstockTestnetFundingTargetCreditObservation {
  @override
  final String accountRef;
  @override
  final BstockTestnetFundingTargetAsset asset;
  @override
  final String availableBefore;
  @override
  final String availableAfter;
  @override
  final String creditedAmount;
  @override
  final BstockTestnetFundingTargetCreditObservationSource_Enum source_;
  @override
  final DateTime observedAt;

  factory _$BstockTestnetFundingTargetCreditObservation(
          [void Function(BstockTestnetFundingTargetCreditObservationBuilder)?
              updates]) =>
      (BstockTestnetFundingTargetCreditObservationBuilder()..update(updates))
          ._build();

  _$BstockTestnetFundingTargetCreditObservation._(
      {required this.accountRef,
      required this.asset,
      required this.availableBefore,
      required this.availableAfter,
      required this.creditedAmount,
      required this.source_,
      required this.observedAt})
      : super._();
  @override
  BstockTestnetFundingTargetCreditObservation rebuild(
          void Function(BstockTestnetFundingTargetCreditObservationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockTestnetFundingTargetCreditObservationBuilder toBuilder() =>
      BstockTestnetFundingTargetCreditObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockTestnetFundingTargetCreditObservation &&
        accountRef == other.accountRef &&
        asset == other.asset &&
        availableBefore == other.availableBefore &&
        availableAfter == other.availableAfter &&
        creditedAmount == other.creditedAmount &&
        source_ == other.source_ &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableBefore.hashCode);
    _$hash = $jc(_$hash, availableAfter.hashCode);
    _$hash = $jc(_$hash, creditedAmount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'BstockTestnetFundingTargetCreditObservation')
          ..add('accountRef', accountRef)
          ..add('asset', asset)
          ..add('availableBefore', availableBefore)
          ..add('availableAfter', availableAfter)
          ..add('creditedAmount', creditedAmount)
          ..add('source_', source_)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class BstockTestnetFundingTargetCreditObservationBuilder
    implements
        Builder<BstockTestnetFundingTargetCreditObservation,
            BstockTestnetFundingTargetCreditObservationBuilder> {
  _$BstockTestnetFundingTargetCreditObservation? _$v;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  BstockTestnetFundingTargetAssetBuilder? _asset;
  BstockTestnetFundingTargetAssetBuilder get asset =>
      _$this._asset ??= BstockTestnetFundingTargetAssetBuilder();
  set asset(BstockTestnetFundingTargetAssetBuilder? asset) =>
      _$this._asset = asset;

  String? _availableBefore;
  String? get availableBefore => _$this._availableBefore;
  set availableBefore(String? availableBefore) =>
      _$this._availableBefore = availableBefore;

  String? _availableAfter;
  String? get availableAfter => _$this._availableAfter;
  set availableAfter(String? availableAfter) =>
      _$this._availableAfter = availableAfter;

  String? _creditedAmount;
  String? get creditedAmount => _$this._creditedAmount;
  set creditedAmount(String? creditedAmount) =>
      _$this._creditedAmount = creditedAmount;

  BstockTestnetFundingTargetCreditObservationSource_Enum? _source_;
  BstockTestnetFundingTargetCreditObservationSource_Enum? get source_ =>
      _$this._source_;
  set source_(
          BstockTestnetFundingTargetCreditObservationSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  BstockTestnetFundingTargetCreditObservationBuilder() {
    BstockTestnetFundingTargetCreditObservation._defaults(this);
  }

  BstockTestnetFundingTargetCreditObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountRef = $v.accountRef;
      _asset = $v.asset.toBuilder();
      _availableBefore = $v.availableBefore;
      _availableAfter = $v.availableAfter;
      _creditedAmount = $v.creditedAmount;
      _source_ = $v.source_;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockTestnetFundingTargetCreditObservation other) {
    _$v = other as _$BstockTestnetFundingTargetCreditObservation;
  }

  @override
  void update(
      void Function(BstockTestnetFundingTargetCreditObservationBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockTestnetFundingTargetCreditObservation build() => _build();

  _$BstockTestnetFundingTargetCreditObservation _build() {
    _$BstockTestnetFundingTargetCreditObservation _$result;
    try {
      _$result = _$v ??
          _$BstockTestnetFundingTargetCreditObservation._(
            accountRef: BuiltValueNullFieldError.checkNotNull(accountRef,
                r'BstockTestnetFundingTargetCreditObservation', 'accountRef'),
            asset: asset.build(),
            availableBefore: BuiltValueNullFieldError.checkNotNull(
                availableBefore,
                r'BstockTestnetFundingTargetCreditObservation',
                'availableBefore'),
            availableAfter: BuiltValueNullFieldError.checkNotNull(
                availableAfter,
                r'BstockTestnetFundingTargetCreditObservation',
                'availableAfter'),
            creditedAmount: BuiltValueNullFieldError.checkNotNull(
                creditedAmount,
                r'BstockTestnetFundingTargetCreditObservation',
                'creditedAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(source_,
                r'BstockTestnetFundingTargetCreditObservation', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'BstockTestnetFundingTargetCreditObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockTestnetFundingTargetCreditObservation',
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
