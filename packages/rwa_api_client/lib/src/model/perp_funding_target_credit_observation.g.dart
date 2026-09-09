// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_funding_target_credit_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpFundingTargetCreditObservationSource_Enum
    _$perpFundingTargetCreditObservationSourceEnum_hyperliquidInfo =
    const PerpFundingTargetCreditObservationSource_Enum._('hyperliquidInfo');
const PerpFundingTargetCreditObservationSource_Enum
    _$perpFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi =
    const PerpFundingTargetCreditObservationSource_Enum._(
        'unknownDefaultOpenApi');

PerpFundingTargetCreditObservationSource_Enum
    _$perpFundingTargetCreditObservationSourceEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquidInfo':
      return _$perpFundingTargetCreditObservationSourceEnum_hyperliquidInfo;
    case 'unknownDefaultOpenApi':
      return _$perpFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingTargetCreditObservationSource_Enum>
    _$perpFundingTargetCreditObservationSourceEnumValues = BuiltSet<
        PerpFundingTargetCreditObservationSource_Enum>(const <PerpFundingTargetCreditObservationSource_Enum>[
  _$perpFundingTargetCreditObservationSourceEnum_hyperliquidInfo,
  _$perpFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi,
]);

Serializer<PerpFundingTargetCreditObservationSource_Enum>
    _$perpFundingTargetCreditObservationSourceEnumSerializer =
    _$PerpFundingTargetCreditObservationSource_EnumSerializer();

class _$PerpFundingTargetCreditObservationSource_EnumSerializer
    implements
        PrimitiveSerializer<PerpFundingTargetCreditObservationSource_Enum> {
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
    PerpFundingTargetCreditObservationSource_Enum
  ];
  @override
  final String wireName = 'PerpFundingTargetCreditObservationSource_Enum';

  @override
  Object serialize(Serializers serializers,
          PerpFundingTargetCreditObservationSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingTargetCreditObservationSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingTargetCreditObservationSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingTargetCreditObservation
    extends PerpFundingTargetCreditObservation {
  @override
  final String accountRef;
  @override
  final PerpFundingTargetAsset asset;
  @override
  final String availableBefore;
  @override
  final String availableAfter;
  @override
  final String creditedAmount;
  @override
  final PerpFundingTargetCreditObservationSource_Enum source_;
  @override
  final DateTime observedAt;

  factory _$PerpFundingTargetCreditObservation(
          [void Function(PerpFundingTargetCreditObservationBuilder)?
              updates]) =>
      (PerpFundingTargetCreditObservationBuilder()..update(updates))._build();

  _$PerpFundingTargetCreditObservation._(
      {required this.accountRef,
      required this.asset,
      required this.availableBefore,
      required this.availableAfter,
      required this.creditedAmount,
      required this.source_,
      required this.observedAt})
      : super._();
  @override
  PerpFundingTargetCreditObservation rebuild(
          void Function(PerpFundingTargetCreditObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingTargetCreditObservationBuilder toBuilder() =>
      PerpFundingTargetCreditObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingTargetCreditObservation &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingTargetCreditObservation')
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

class PerpFundingTargetCreditObservationBuilder
    implements
        Builder<PerpFundingTargetCreditObservation,
            PerpFundingTargetCreditObservationBuilder> {
  _$PerpFundingTargetCreditObservation? _$v;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  PerpFundingTargetAssetBuilder? _asset;
  PerpFundingTargetAssetBuilder get asset =>
      _$this._asset ??= PerpFundingTargetAssetBuilder();
  set asset(PerpFundingTargetAssetBuilder? asset) => _$this._asset = asset;

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

  PerpFundingTargetCreditObservationSource_Enum? _source_;
  PerpFundingTargetCreditObservationSource_Enum? get source_ => _$this._source_;
  set source_(PerpFundingTargetCreditObservationSource_Enum? source_) =>
      _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  PerpFundingTargetCreditObservationBuilder() {
    PerpFundingTargetCreditObservation._defaults(this);
  }

  PerpFundingTargetCreditObservationBuilder get _$this {
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
  void replace(PerpFundingTargetCreditObservation other) {
    _$v = other as _$PerpFundingTargetCreditObservation;
  }

  @override
  void update(
      void Function(PerpFundingTargetCreditObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpFundingTargetCreditObservation build() => _build();

  _$PerpFundingTargetCreditObservation _build() {
    _$PerpFundingTargetCreditObservation _$result;
    try {
      _$result = _$v ??
          _$PerpFundingTargetCreditObservation._(
            accountRef: BuiltValueNullFieldError.checkNotNull(accountRef,
                r'PerpFundingTargetCreditObservation', 'accountRef'),
            asset: asset.build(),
            availableBefore: BuiltValueNullFieldError.checkNotNull(
                availableBefore,
                r'PerpFundingTargetCreditObservation',
                'availableBefore'),
            availableAfter: BuiltValueNullFieldError.checkNotNull(
                availableAfter,
                r'PerpFundingTargetCreditObservation',
                'availableAfter'),
            creditedAmount: BuiltValueNullFieldError.checkNotNull(
                creditedAmount,
                r'PerpFundingTargetCreditObservation',
                'creditedAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'PerpFundingTargetCreditObservation', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'PerpFundingTargetCreditObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpFundingTargetCreditObservation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
