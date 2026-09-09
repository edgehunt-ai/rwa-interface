// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_funding_target_credit_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockFundingTargetCreditObservationSource_Enum
    _$bstockFundingTargetCreditObservationSourceEnum_bscRpc =
    const BstockFundingTargetCreditObservationSource_Enum._('bscRpc');
const BstockFundingTargetCreditObservationSource_Enum
    _$bstockFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi =
    const BstockFundingTargetCreditObservationSource_Enum._(
        'unknownDefaultOpenApi');

BstockFundingTargetCreditObservationSource_Enum
    _$bstockFundingTargetCreditObservationSourceEnumValueOf(String name) {
  switch (name) {
    case 'bscRpc':
      return _$bstockFundingTargetCreditObservationSourceEnum_bscRpc;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingTargetCreditObservationSource_Enum>
    _$bstockFundingTargetCreditObservationSourceEnumValues = BuiltSet<
        BstockFundingTargetCreditObservationSource_Enum>(const <BstockFundingTargetCreditObservationSource_Enum>[
  _$bstockFundingTargetCreditObservationSourceEnum_bscRpc,
  _$bstockFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingTargetCreditObservationSource_Enum>
    _$bstockFundingTargetCreditObservationSourceEnumSerializer =
    _$BstockFundingTargetCreditObservationSource_EnumSerializer();

class _$BstockFundingTargetCreditObservationSource_EnumSerializer
    implements
        PrimitiveSerializer<BstockFundingTargetCreditObservationSource_Enum> {
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
    BstockFundingTargetCreditObservationSource_Enum
  ];
  @override
  final String wireName = 'BstockFundingTargetCreditObservationSource_Enum';

  @override
  Object serialize(Serializers serializers,
          BstockFundingTargetCreditObservationSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingTargetCreditObservationSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingTargetCreditObservationSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingTargetCreditObservation
    extends BstockFundingTargetCreditObservation {
  @override
  final String accountRef;
  @override
  final BstockFundingTargetAsset asset;
  @override
  final String availableBefore;
  @override
  final String availableAfter;
  @override
  final String creditedAmount;
  @override
  final BstockFundingTargetCreditObservationSource_Enum source_;
  @override
  final DateTime observedAt;

  factory _$BstockFundingTargetCreditObservation(
          [void Function(BstockFundingTargetCreditObservationBuilder)?
              updates]) =>
      (BstockFundingTargetCreditObservationBuilder()..update(updates))._build();

  _$BstockFundingTargetCreditObservation._(
      {required this.accountRef,
      required this.asset,
      required this.availableBefore,
      required this.availableAfter,
      required this.creditedAmount,
      required this.source_,
      required this.observedAt})
      : super._();
  @override
  BstockFundingTargetCreditObservation rebuild(
          void Function(BstockFundingTargetCreditObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockFundingTargetCreditObservationBuilder toBuilder() =>
      BstockFundingTargetCreditObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockFundingTargetCreditObservation &&
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
    return (newBuiltValueToStringHelper(r'BstockFundingTargetCreditObservation')
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

class BstockFundingTargetCreditObservationBuilder
    implements
        Builder<BstockFundingTargetCreditObservation,
            BstockFundingTargetCreditObservationBuilder> {
  _$BstockFundingTargetCreditObservation? _$v;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  BstockFundingTargetAssetBuilder? _asset;
  BstockFundingTargetAssetBuilder get asset =>
      _$this._asset ??= BstockFundingTargetAssetBuilder();
  set asset(BstockFundingTargetAssetBuilder? asset) => _$this._asset = asset;

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

  BstockFundingTargetCreditObservationSource_Enum? _source_;
  BstockFundingTargetCreditObservationSource_Enum? get source_ =>
      _$this._source_;
  set source_(BstockFundingTargetCreditObservationSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  BstockFundingTargetCreditObservationBuilder() {
    BstockFundingTargetCreditObservation._defaults(this);
  }

  BstockFundingTargetCreditObservationBuilder get _$this {
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
  void replace(BstockFundingTargetCreditObservation other) {
    _$v = other as _$BstockFundingTargetCreditObservation;
  }

  @override
  void update(
      void Function(BstockFundingTargetCreditObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockFundingTargetCreditObservation build() => _build();

  _$BstockFundingTargetCreditObservation _build() {
    _$BstockFundingTargetCreditObservation _$result;
    try {
      _$result = _$v ??
          _$BstockFundingTargetCreditObservation._(
            accountRef: BuiltValueNullFieldError.checkNotNull(accountRef,
                r'BstockFundingTargetCreditObservation', 'accountRef'),
            asset: asset.build(),
            availableBefore: BuiltValueNullFieldError.checkNotNull(
                availableBefore,
                r'BstockFundingTargetCreditObservation',
                'availableBefore'),
            availableAfter: BuiltValueNullFieldError.checkNotNull(
                availableAfter,
                r'BstockFundingTargetCreditObservation',
                'availableAfter'),
            creditedAmount: BuiltValueNullFieldError.checkNotNull(
                creditedAmount,
                r'BstockFundingTargetCreditObservation',
                'creditedAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'BstockFundingTargetCreditObservation', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'BstockFundingTargetCreditObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockFundingTargetCreditObservation',
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
