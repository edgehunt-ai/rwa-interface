// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_route_quote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingRouteQuote extends FundingRouteQuote {
  @override
  final String quoteId;
  @override
  final FundingProvider provider;
  @override
  final String inputAmount;
  @override
  final String maximumInputAmount;
  @override
  final String minimumReceived;
  @override
  final FundingFeeBreakdown fees;
  @override
  final int etaSeconds;
  @override
  final DateTime quotedAt;
  @override
  final DateTime expiresAt;
  @override
  final String quoteHash;
  @override
  final FundingRefundPolicy refund;

  factory _$FundingRouteQuote(
          [void Function(FundingRouteQuoteBuilder)? updates]) =>
      (FundingRouteQuoteBuilder()..update(updates))._build();

  _$FundingRouteQuote._(
      {required this.quoteId,
      required this.provider,
      required this.inputAmount,
      required this.maximumInputAmount,
      required this.minimumReceived,
      required this.fees,
      required this.etaSeconds,
      required this.quotedAt,
      required this.expiresAt,
      required this.quoteHash,
      required this.refund})
      : super._();
  @override
  FundingRouteQuote rebuild(void Function(FundingRouteQuoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRouteQuoteBuilder toBuilder() =>
      FundingRouteQuoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRouteQuote &&
        quoteId == other.quoteId &&
        provider == other.provider &&
        inputAmount == other.inputAmount &&
        maximumInputAmount == other.maximumInputAmount &&
        minimumReceived == other.minimumReceived &&
        fees == other.fees &&
        etaSeconds == other.etaSeconds &&
        quotedAt == other.quotedAt &&
        expiresAt == other.expiresAt &&
        quoteHash == other.quoteHash &&
        refund == other.refund;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quoteId.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, inputAmount.hashCode);
    _$hash = $jc(_$hash, maximumInputAmount.hashCode);
    _$hash = $jc(_$hash, minimumReceived.hashCode);
    _$hash = $jc(_$hash, fees.hashCode);
    _$hash = $jc(_$hash, etaSeconds.hashCode);
    _$hash = $jc(_$hash, quotedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, quoteHash.hashCode);
    _$hash = $jc(_$hash, refund.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRouteQuote')
          ..add('quoteId', quoteId)
          ..add('provider', provider)
          ..add('inputAmount', inputAmount)
          ..add('maximumInputAmount', maximumInputAmount)
          ..add('minimumReceived', minimumReceived)
          ..add('fees', fees)
          ..add('etaSeconds', etaSeconds)
          ..add('quotedAt', quotedAt)
          ..add('expiresAt', expiresAt)
          ..add('quoteHash', quoteHash)
          ..add('refund', refund))
        .toString();
  }
}

class FundingRouteQuoteBuilder
    implements Builder<FundingRouteQuote, FundingRouteQuoteBuilder> {
  _$FundingRouteQuote? _$v;

  String? _quoteId;
  String? get quoteId => _$this._quoteId;
  set quoteId(String? quoteId) => _$this._quoteId = quoteId;

  FundingProvider? _provider;
  FundingProvider? get provider => _$this._provider;
  set provider(FundingProvider? provider) => _$this._provider = provider;

  String? _inputAmount;
  String? get inputAmount => _$this._inputAmount;
  set inputAmount(String? inputAmount) => _$this._inputAmount = inputAmount;

  String? _maximumInputAmount;
  String? get maximumInputAmount => _$this._maximumInputAmount;
  set maximumInputAmount(String? maximumInputAmount) =>
      _$this._maximumInputAmount = maximumInputAmount;

  String? _minimumReceived;
  String? get minimumReceived => _$this._minimumReceived;
  set minimumReceived(String? minimumReceived) =>
      _$this._minimumReceived = minimumReceived;

  FundingFeeBreakdownBuilder? _fees;
  FundingFeeBreakdownBuilder get fees =>
      _$this._fees ??= FundingFeeBreakdownBuilder();
  set fees(FundingFeeBreakdownBuilder? fees) => _$this._fees = fees;

  int? _etaSeconds;
  int? get etaSeconds => _$this._etaSeconds;
  set etaSeconds(int? etaSeconds) => _$this._etaSeconds = etaSeconds;

  DateTime? _quotedAt;
  DateTime? get quotedAt => _$this._quotedAt;
  set quotedAt(DateTime? quotedAt) => _$this._quotedAt = quotedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  String? _quoteHash;
  String? get quoteHash => _$this._quoteHash;
  set quoteHash(String? quoteHash) => _$this._quoteHash = quoteHash;

  FundingRefundPolicyBuilder? _refund;
  FundingRefundPolicyBuilder get refund =>
      _$this._refund ??= FundingRefundPolicyBuilder();
  set refund(FundingRefundPolicyBuilder? refund) => _$this._refund = refund;

  FundingRouteQuoteBuilder() {
    FundingRouteQuote._defaults(this);
  }

  FundingRouteQuoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quoteId = $v.quoteId;
      _provider = $v.provider;
      _inputAmount = $v.inputAmount;
      _maximumInputAmount = $v.maximumInputAmount;
      _minimumReceived = $v.minimumReceived;
      _fees = $v.fees.toBuilder();
      _etaSeconds = $v.etaSeconds;
      _quotedAt = $v.quotedAt;
      _expiresAt = $v.expiresAt;
      _quoteHash = $v.quoteHash;
      _refund = $v.refund.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRouteQuote other) {
    _$v = other as _$FundingRouteQuote;
  }

  @override
  void update(void Function(FundingRouteQuoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRouteQuote build() => _build();

  _$FundingRouteQuote _build() {
    _$FundingRouteQuote _$result;
    try {
      _$result = _$v ??
          _$FundingRouteQuote._(
            quoteId: BuiltValueNullFieldError.checkNotNull(
                quoteId, r'FundingRouteQuote', 'quoteId'),
            provider: BuiltValueNullFieldError.checkNotNull(
                provider, r'FundingRouteQuote', 'provider'),
            inputAmount: BuiltValueNullFieldError.checkNotNull(
                inputAmount, r'FundingRouteQuote', 'inputAmount'),
            maximumInputAmount: BuiltValueNullFieldError.checkNotNull(
                maximumInputAmount, r'FundingRouteQuote', 'maximumInputAmount'),
            minimumReceived: BuiltValueNullFieldError.checkNotNull(
                minimumReceived, r'FundingRouteQuote', 'minimumReceived'),
            fees: fees.build(),
            etaSeconds: BuiltValueNullFieldError.checkNotNull(
                etaSeconds, r'FundingRouteQuote', 'etaSeconds'),
            quotedAt: BuiltValueNullFieldError.checkNotNull(
                quotedAt, r'FundingRouteQuote', 'quotedAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'FundingRouteQuote', 'expiresAt'),
            quoteHash: BuiltValueNullFieldError.checkNotNull(
                quoteHash, r'FundingRouteQuote', 'quoteHash'),
            refund: refund.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fees';
        fees.build();

        _$failedField = 'refund';
        refund.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingRouteQuote', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
