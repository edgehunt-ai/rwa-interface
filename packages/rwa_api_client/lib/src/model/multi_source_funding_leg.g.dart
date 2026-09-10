// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_funding_leg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MultiSourceFundingLeg extends MultiSourceFundingLeg {
  @override
  final String legId;
  @override
  final int ordinal;
  @override
  final FundingSourcePositionSnapshot sourcePositionSnapshot;
  @override
  final FundingRouteQuote route;
  @override
  final String outputAmount;
  @override
  final MultiSourceFundingLegStatus status;
  @override
  final String? transferId;
  @override
  final BuiltList<FundingWalletActionSummary> walletActions;

  factory _$MultiSourceFundingLeg(
          [void Function(MultiSourceFundingLegBuilder)? updates]) =>
      (MultiSourceFundingLegBuilder()..update(updates))._build();

  _$MultiSourceFundingLeg._(
      {required this.legId,
      required this.ordinal,
      required this.sourcePositionSnapshot,
      required this.route,
      required this.outputAmount,
      required this.status,
      this.transferId,
      required this.walletActions})
      : super._();
  @override
  MultiSourceFundingLeg rebuild(
          void Function(MultiSourceFundingLegBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourceFundingLegBuilder toBuilder() =>
      MultiSourceFundingLegBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourceFundingLeg &&
        legId == other.legId &&
        ordinal == other.ordinal &&
        sourcePositionSnapshot == other.sourcePositionSnapshot &&
        route == other.route &&
        outputAmount == other.outputAmount &&
        status == other.status &&
        transferId == other.transferId &&
        walletActions == other.walletActions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, legId.hashCode);
    _$hash = $jc(_$hash, ordinal.hashCode);
    _$hash = $jc(_$hash, sourcePositionSnapshot.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jc(_$hash, outputAmount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, walletActions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MultiSourceFundingLeg')
          ..add('legId', legId)
          ..add('ordinal', ordinal)
          ..add('sourcePositionSnapshot', sourcePositionSnapshot)
          ..add('route', route)
          ..add('outputAmount', outputAmount)
          ..add('status', status)
          ..add('transferId', transferId)
          ..add('walletActions', walletActions))
        .toString();
  }
}

class MultiSourceFundingLegBuilder
    implements Builder<MultiSourceFundingLeg, MultiSourceFundingLegBuilder> {
  _$MultiSourceFundingLeg? _$v;

  String? _legId;
  String? get legId => _$this._legId;
  set legId(String? legId) => _$this._legId = legId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  FundingSourcePositionSnapshotBuilder? _sourcePositionSnapshot;
  FundingSourcePositionSnapshotBuilder get sourcePositionSnapshot =>
      _$this._sourcePositionSnapshot ??= FundingSourcePositionSnapshotBuilder();
  set sourcePositionSnapshot(
          FundingSourcePositionSnapshotBuilder? sourcePositionSnapshot) =>
      _$this._sourcePositionSnapshot = sourcePositionSnapshot;

  FundingRouteQuoteBuilder? _route;
  FundingRouteQuoteBuilder get route =>
      _$this._route ??= FundingRouteQuoteBuilder();
  set route(FundingRouteQuoteBuilder? route) => _$this._route = route;

  String? _outputAmount;
  String? get outputAmount => _$this._outputAmount;
  set outputAmount(String? outputAmount) => _$this._outputAmount = outputAmount;

  MultiSourceFundingLegStatus? _status;
  MultiSourceFundingLegStatus? get status => _$this._status;
  set status(MultiSourceFundingLegStatus? status) => _$this._status = status;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  ListBuilder<FundingWalletActionSummary>? _walletActions;
  ListBuilder<FundingWalletActionSummary> get walletActions =>
      _$this._walletActions ??= ListBuilder<FundingWalletActionSummary>();
  set walletActions(ListBuilder<FundingWalletActionSummary>? walletActions) =>
      _$this._walletActions = walletActions;

  MultiSourceFundingLegBuilder() {
    MultiSourceFundingLeg._defaults(this);
  }

  MultiSourceFundingLegBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _legId = $v.legId;
      _ordinal = $v.ordinal;
      _sourcePositionSnapshot = $v.sourcePositionSnapshot.toBuilder();
      _route = $v.route.toBuilder();
      _outputAmount = $v.outputAmount;
      _status = $v.status;
      _transferId = $v.transferId;
      _walletActions = $v.walletActions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiSourceFundingLeg other) {
    _$v = other as _$MultiSourceFundingLeg;
  }

  @override
  void update(void Function(MultiSourceFundingLegBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourceFundingLeg build() => _build();

  _$MultiSourceFundingLeg _build() {
    _$MultiSourceFundingLeg _$result;
    try {
      _$result = _$v ??
          _$MultiSourceFundingLeg._(
            legId: BuiltValueNullFieldError.checkNotNull(
                legId, r'MultiSourceFundingLeg', 'legId'),
            ordinal: BuiltValueNullFieldError.checkNotNull(
                ordinal, r'MultiSourceFundingLeg', 'ordinal'),
            sourcePositionSnapshot: sourcePositionSnapshot.build(),
            route: route.build(),
            outputAmount: BuiltValueNullFieldError.checkNotNull(
                outputAmount, r'MultiSourceFundingLeg', 'outputAmount'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'MultiSourceFundingLeg', 'status'),
            transferId: transferId,
            walletActions: walletActions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sourcePositionSnapshot';
        sourcePositionSnapshot.build();
        _$failedField = 'route';
        route.build();

        _$failedField = 'walletActions';
        walletActions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MultiSourceFundingLeg', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
