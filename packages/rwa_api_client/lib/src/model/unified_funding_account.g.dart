// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_funding_account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnifiedFundingAccountValuationCurrencyEnum
    _$unifiedFundingAccountValuationCurrencyEnum_USD =
    const UnifiedFundingAccountValuationCurrencyEnum._('USD');
const UnifiedFundingAccountValuationCurrencyEnum
    _$unifiedFundingAccountValuationCurrencyEnum_unknownDefaultOpenApi =
    const UnifiedFundingAccountValuationCurrencyEnum._('unknownDefaultOpenApi');

UnifiedFundingAccountValuationCurrencyEnum
    _$unifiedFundingAccountValuationCurrencyEnumValueOf(String name) {
  switch (name) {
    case 'USD':
      return _$unifiedFundingAccountValuationCurrencyEnum_USD;
    case 'unknownDefaultOpenApi':
      return _$unifiedFundingAccountValuationCurrencyEnum_unknownDefaultOpenApi;
    default:
      return _$unifiedFundingAccountValuationCurrencyEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnifiedFundingAccountValuationCurrencyEnum>
    _$unifiedFundingAccountValuationCurrencyEnumValues = BuiltSet<
        UnifiedFundingAccountValuationCurrencyEnum>(const <UnifiedFundingAccountValuationCurrencyEnum>[
  _$unifiedFundingAccountValuationCurrencyEnum_USD,
  _$unifiedFundingAccountValuationCurrencyEnum_unknownDefaultOpenApi,
]);

Serializer<UnifiedFundingAccountValuationCurrencyEnum>
    _$unifiedFundingAccountValuationCurrencyEnumSerializer =
    _$UnifiedFundingAccountValuationCurrencyEnumSerializer();

class _$UnifiedFundingAccountValuationCurrencyEnumSerializer
    implements PrimitiveSerializer<UnifiedFundingAccountValuationCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USD': 'USD',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USD': 'USD',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UnifiedFundingAccountValuationCurrencyEnum
  ];
  @override
  final String wireName = 'UnifiedFundingAccountValuationCurrencyEnum';

  @override
  Object serialize(Serializers serializers,
          UnifiedFundingAccountValuationCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnifiedFundingAccountValuationCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnifiedFundingAccountValuationCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnifiedFundingAccount extends UnifiedFundingAccount {
  @override
  final String accountId;
  @override
  final UnifiedFundingAccountValuationCurrencyEnum valuationCurrency;
  @override
  final String valuedTotalUsd;
  @override
  final String availableToFundValueUsd;
  @override
  final String reservedValueUsd;
  @override
  final String inTransitValueUsd;
  @override
  final String unavailableValueUsd;
  @override
  final int unvaluedPositionCount;
  @override
  final BuiltList<UnifiedFundingPosition> positions;
  @override
  final BuiltList<UnifiedFundingTransfer> transfers;
  @override
  final UnifiedFundingDataStatus dataStatus;
  @override
  final BuiltSet<UnifiedFundingBlocker> blockers;
  @override
  final DateTime calculatedAt;

  factory _$UnifiedFundingAccount(
          [void Function(UnifiedFundingAccountBuilder)? updates]) =>
      (UnifiedFundingAccountBuilder()..update(updates))._build();

  _$UnifiedFundingAccount._(
      {required this.accountId,
      required this.valuationCurrency,
      required this.valuedTotalUsd,
      required this.availableToFundValueUsd,
      required this.reservedValueUsd,
      required this.inTransitValueUsd,
      required this.unavailableValueUsd,
      required this.unvaluedPositionCount,
      required this.positions,
      required this.transfers,
      required this.dataStatus,
      required this.blockers,
      required this.calculatedAt})
      : super._();
  @override
  UnifiedFundingAccount rebuild(
          void Function(UnifiedFundingAccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnifiedFundingAccountBuilder toBuilder() =>
      UnifiedFundingAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnifiedFundingAccount &&
        accountId == other.accountId &&
        valuationCurrency == other.valuationCurrency &&
        valuedTotalUsd == other.valuedTotalUsd &&
        availableToFundValueUsd == other.availableToFundValueUsd &&
        reservedValueUsd == other.reservedValueUsd &&
        inTransitValueUsd == other.inTransitValueUsd &&
        unavailableValueUsd == other.unavailableValueUsd &&
        unvaluedPositionCount == other.unvaluedPositionCount &&
        positions == other.positions &&
        transfers == other.transfers &&
        dataStatus == other.dataStatus &&
        blockers == other.blockers &&
        calculatedAt == other.calculatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, valuationCurrency.hashCode);
    _$hash = $jc(_$hash, valuedTotalUsd.hashCode);
    _$hash = $jc(_$hash, availableToFundValueUsd.hashCode);
    _$hash = $jc(_$hash, reservedValueUsd.hashCode);
    _$hash = $jc(_$hash, inTransitValueUsd.hashCode);
    _$hash = $jc(_$hash, unavailableValueUsd.hashCode);
    _$hash = $jc(_$hash, unvaluedPositionCount.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jc(_$hash, transfers.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnifiedFundingAccount')
          ..add('accountId', accountId)
          ..add('valuationCurrency', valuationCurrency)
          ..add('valuedTotalUsd', valuedTotalUsd)
          ..add('availableToFundValueUsd', availableToFundValueUsd)
          ..add('reservedValueUsd', reservedValueUsd)
          ..add('inTransitValueUsd', inTransitValueUsd)
          ..add('unavailableValueUsd', unavailableValueUsd)
          ..add('unvaluedPositionCount', unvaluedPositionCount)
          ..add('positions', positions)
          ..add('transfers', transfers)
          ..add('dataStatus', dataStatus)
          ..add('blockers', blockers)
          ..add('calculatedAt', calculatedAt))
        .toString();
  }
}

class UnifiedFundingAccountBuilder
    implements Builder<UnifiedFundingAccount, UnifiedFundingAccountBuilder> {
  _$UnifiedFundingAccount? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  UnifiedFundingAccountValuationCurrencyEnum? _valuationCurrency;
  UnifiedFundingAccountValuationCurrencyEnum? get valuationCurrency =>
      _$this._valuationCurrency;
  set valuationCurrency(
          UnifiedFundingAccountValuationCurrencyEnum? valuationCurrency) =>
      _$this._valuationCurrency = valuationCurrency;

  String? _valuedTotalUsd;
  String? get valuedTotalUsd => _$this._valuedTotalUsd;
  set valuedTotalUsd(String? valuedTotalUsd) =>
      _$this._valuedTotalUsd = valuedTotalUsd;

  String? _availableToFundValueUsd;
  String? get availableToFundValueUsd => _$this._availableToFundValueUsd;
  set availableToFundValueUsd(String? availableToFundValueUsd) =>
      _$this._availableToFundValueUsd = availableToFundValueUsd;

  String? _reservedValueUsd;
  String? get reservedValueUsd => _$this._reservedValueUsd;
  set reservedValueUsd(String? reservedValueUsd) =>
      _$this._reservedValueUsd = reservedValueUsd;

  String? _inTransitValueUsd;
  String? get inTransitValueUsd => _$this._inTransitValueUsd;
  set inTransitValueUsd(String? inTransitValueUsd) =>
      _$this._inTransitValueUsd = inTransitValueUsd;

  String? _unavailableValueUsd;
  String? get unavailableValueUsd => _$this._unavailableValueUsd;
  set unavailableValueUsd(String? unavailableValueUsd) =>
      _$this._unavailableValueUsd = unavailableValueUsd;

  int? _unvaluedPositionCount;
  int? get unvaluedPositionCount => _$this._unvaluedPositionCount;
  set unvaluedPositionCount(int? unvaluedPositionCount) =>
      _$this._unvaluedPositionCount = unvaluedPositionCount;

  ListBuilder<UnifiedFundingPosition>? _positions;
  ListBuilder<UnifiedFundingPosition> get positions =>
      _$this._positions ??= ListBuilder<UnifiedFundingPosition>();
  set positions(ListBuilder<UnifiedFundingPosition>? positions) =>
      _$this._positions = positions;

  ListBuilder<UnifiedFundingTransfer>? _transfers;
  ListBuilder<UnifiedFundingTransfer> get transfers =>
      _$this._transfers ??= ListBuilder<UnifiedFundingTransfer>();
  set transfers(ListBuilder<UnifiedFundingTransfer>? transfers) =>
      _$this._transfers = transfers;

  UnifiedFundingDataStatus? _dataStatus;
  UnifiedFundingDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(UnifiedFundingDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  SetBuilder<UnifiedFundingBlocker>? _blockers;
  SetBuilder<UnifiedFundingBlocker> get blockers =>
      _$this._blockers ??= SetBuilder<UnifiedFundingBlocker>();
  set blockers(SetBuilder<UnifiedFundingBlocker>? blockers) =>
      _$this._blockers = blockers;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  UnifiedFundingAccountBuilder() {
    UnifiedFundingAccount._defaults(this);
  }

  UnifiedFundingAccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _valuationCurrency = $v.valuationCurrency;
      _valuedTotalUsd = $v.valuedTotalUsd;
      _availableToFundValueUsd = $v.availableToFundValueUsd;
      _reservedValueUsd = $v.reservedValueUsd;
      _inTransitValueUsd = $v.inTransitValueUsd;
      _unavailableValueUsd = $v.unavailableValueUsd;
      _unvaluedPositionCount = $v.unvaluedPositionCount;
      _positions = $v.positions.toBuilder();
      _transfers = $v.transfers.toBuilder();
      _dataStatus = $v.dataStatus;
      _blockers = $v.blockers.toBuilder();
      _calculatedAt = $v.calculatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnifiedFundingAccount other) {
    _$v = other as _$UnifiedFundingAccount;
  }

  @override
  void update(void Function(UnifiedFundingAccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnifiedFundingAccount build() => _build();

  _$UnifiedFundingAccount _build() {
    _$UnifiedFundingAccount _$result;
    try {
      _$result = _$v ??
          _$UnifiedFundingAccount._(
            accountId: BuiltValueNullFieldError.checkNotNull(
                accountId, r'UnifiedFundingAccount', 'accountId'),
            valuationCurrency: BuiltValueNullFieldError.checkNotNull(
                valuationCurrency,
                r'UnifiedFundingAccount',
                'valuationCurrency'),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd, r'UnifiedFundingAccount', 'valuedTotalUsd'),
            availableToFundValueUsd: BuiltValueNullFieldError.checkNotNull(
                availableToFundValueUsd,
                r'UnifiedFundingAccount',
                'availableToFundValueUsd'),
            reservedValueUsd: BuiltValueNullFieldError.checkNotNull(
                reservedValueUsd, r'UnifiedFundingAccount', 'reservedValueUsd'),
            inTransitValueUsd: BuiltValueNullFieldError.checkNotNull(
                inTransitValueUsd,
                r'UnifiedFundingAccount',
                'inTransitValueUsd'),
            unavailableValueUsd: BuiltValueNullFieldError.checkNotNull(
                unavailableValueUsd,
                r'UnifiedFundingAccount',
                'unavailableValueUsd'),
            unvaluedPositionCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedPositionCount,
                r'UnifiedFundingAccount',
                'unvaluedPositionCount'),
            positions: positions.build(),
            transfers: transfers.build(),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'UnifiedFundingAccount', 'dataStatus'),
            blockers: blockers.build(),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'UnifiedFundingAccount', 'calculatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'positions';
        positions.build();
        _$failedField = 'transfers';
        transfers.build();

        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UnifiedFundingAccount', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
