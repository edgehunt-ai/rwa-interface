// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_source_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioSourceSummary extends PortfolioSourceSummary {
  @override
  final PortfolioSourceKind source_;
  @override
  final PortfolioAssetNetwork? network;
  @override
  final PortfolioSourceState status;
  @override
  final PortfolioFreshness? freshness;
  @override
  final DateTime? observedAt;
  @override
  final PortfolioWarningCode? warningCode;

  factory _$PortfolioSourceSummary(
          [void Function(PortfolioSourceSummaryBuilder)? updates]) =>
      (PortfolioSourceSummaryBuilder()..update(updates))._build();

  _$PortfolioSourceSummary._(
      {required this.source_,
      this.network,
      required this.status,
      this.freshness,
      this.observedAt,
      this.warningCode})
      : super._();
  @override
  PortfolioSourceSummary rebuild(
          void Function(PortfolioSourceSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioSourceSummaryBuilder toBuilder() =>
      PortfolioSourceSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioSourceSummary &&
        source_ == other.source_ &&
        network == other.network &&
        status == other.status &&
        freshness == other.freshness &&
        observedAt == other.observedAt &&
        warningCode == other.warningCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, warningCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioSourceSummary')
          ..add('source_', source_)
          ..add('network', network)
          ..add('status', status)
          ..add('freshness', freshness)
          ..add('observedAt', observedAt)
          ..add('warningCode', warningCode))
        .toString();
  }
}

class PortfolioSourceSummaryBuilder
    implements Builder<PortfolioSourceSummary, PortfolioSourceSummaryBuilder> {
  _$PortfolioSourceSummary? _$v;

  PortfolioSourceKind? _source_;
  PortfolioSourceKind? get source_ => _$this._source_;
  set source_(PortfolioSourceKind? source_) => _$this._source_ = source_;

  PortfolioAssetNetwork? _network;
  PortfolioAssetNetwork? get network => _$this._network;
  set network(PortfolioAssetNetwork? network) => _$this._network = network;

  PortfolioSourceState? _status;
  PortfolioSourceState? get status => _$this._status;
  set status(PortfolioSourceState? status) => _$this._status = status;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  PortfolioWarningCode? _warningCode;
  PortfolioWarningCode? get warningCode => _$this._warningCode;
  set warningCode(PortfolioWarningCode? warningCode) =>
      _$this._warningCode = warningCode;

  PortfolioSourceSummaryBuilder() {
    PortfolioSourceSummary._defaults(this);
  }

  PortfolioSourceSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_;
      _network = $v.network;
      _status = $v.status;
      _freshness = $v.freshness;
      _observedAt = $v.observedAt;
      _warningCode = $v.warningCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioSourceSummary other) {
    _$v = other as _$PortfolioSourceSummary;
  }

  @override
  void update(void Function(PortfolioSourceSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioSourceSummary build() => _build();

  _$PortfolioSourceSummary _build() {
    final _$result = _$v ??
        _$PortfolioSourceSummary._(
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'PortfolioSourceSummary', 'source_'),
          network: network,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PortfolioSourceSummary', 'status'),
          freshness: freshness,
          observedAt: observedAt,
          warningCode: warningCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
