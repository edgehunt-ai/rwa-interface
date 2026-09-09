// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_route_capability.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingRouteCapability extends FundingRouteCapability {
  @override
  final ProductKind rail;
  @override
  final FundingProvider provider;
  @override
  final FundingRouteCapabilityStatus status;
  @override
  final BuiltList<FundingRouteBlocker> blockers;
  @override
  final DateTime observedAt;
  @override
  final DateTime expiresAt;

  factory _$FundingRouteCapability(
          [void Function(FundingRouteCapabilityBuilder)? updates]) =>
      (FundingRouteCapabilityBuilder()..update(updates))._build();

  _$FundingRouteCapability._(
      {required this.rail,
      required this.provider,
      required this.status,
      required this.blockers,
      required this.observedAt,
      required this.expiresAt})
      : super._();
  @override
  FundingRouteCapability rebuild(
          void Function(FundingRouteCapabilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRouteCapabilityBuilder toBuilder() =>
      FundingRouteCapabilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRouteCapability &&
        rail == other.rail &&
        provider == other.provider &&
        status == other.status &&
        blockers == other.blockers &&
        observedAt == other.observedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRouteCapability')
          ..add('rail', rail)
          ..add('provider', provider)
          ..add('status', status)
          ..add('blockers', blockers)
          ..add('observedAt', observedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class FundingRouteCapabilityBuilder
    implements Builder<FundingRouteCapability, FundingRouteCapabilityBuilder> {
  _$FundingRouteCapability? _$v;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  FundingProvider? _provider;
  FundingProvider? get provider => _$this._provider;
  set provider(FundingProvider? provider) => _$this._provider = provider;

  FundingRouteCapabilityStatus? _status;
  FundingRouteCapabilityStatus? get status => _$this._status;
  set status(FundingRouteCapabilityStatus? status) => _$this._status = status;

  ListBuilder<FundingRouteBlocker>? _blockers;
  ListBuilder<FundingRouteBlocker> get blockers =>
      _$this._blockers ??= ListBuilder<FundingRouteBlocker>();
  set blockers(ListBuilder<FundingRouteBlocker>? blockers) =>
      _$this._blockers = blockers;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  FundingRouteCapabilityBuilder() {
    FundingRouteCapability._defaults(this);
  }

  FundingRouteCapabilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rail = $v.rail;
      _provider = $v.provider;
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _observedAt = $v.observedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRouteCapability other) {
    _$v = other as _$FundingRouteCapability;
  }

  @override
  void update(void Function(FundingRouteCapabilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRouteCapability build() => _build();

  _$FundingRouteCapability _build() {
    _$FundingRouteCapability _$result;
    try {
      _$result = _$v ??
          _$FundingRouteCapability._(
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'FundingRouteCapability', 'rail'),
            provider: BuiltValueNullFieldError.checkNotNull(
                provider, r'FundingRouteCapability', 'provider'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingRouteCapability', 'status'),
            blockers: blockers.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FundingRouteCapability', 'observedAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'FundingRouteCapability', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingRouteCapability', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
