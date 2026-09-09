// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_provider_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingProviderObservation extends FundingProviderObservation {
  @override
  final FundingProvider provider;
  @override
  final TransferProviderStatus status;
  @override
  final DateTime observedAt;

  factory _$FundingProviderObservation(
          [void Function(FundingProviderObservationBuilder)? updates]) =>
      (FundingProviderObservationBuilder()..update(updates))._build();

  _$FundingProviderObservation._(
      {required this.provider, required this.status, required this.observedAt})
      : super._();
  @override
  FundingProviderObservation rebuild(
          void Function(FundingProviderObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingProviderObservationBuilder toBuilder() =>
      FundingProviderObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingProviderObservation &&
        provider == other.provider &&
        status == other.status &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingProviderObservation')
          ..add('provider', provider)
          ..add('status', status)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class FundingProviderObservationBuilder
    implements
        Builder<FundingProviderObservation, FundingProviderObservationBuilder> {
  _$FundingProviderObservation? _$v;

  FundingProvider? _provider;
  FundingProvider? get provider => _$this._provider;
  set provider(FundingProvider? provider) => _$this._provider = provider;

  TransferProviderStatus? _status;
  TransferProviderStatus? get status => _$this._status;
  set status(TransferProviderStatus? status) => _$this._status = status;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  FundingProviderObservationBuilder() {
    FundingProviderObservation._defaults(this);
  }

  FundingProviderObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _status = $v.status;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingProviderObservation other) {
    _$v = other as _$FundingProviderObservation;
  }

  @override
  void update(void Function(FundingProviderObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingProviderObservation build() => _build();

  _$FundingProviderObservation _build() {
    final _$result = _$v ??
        _$FundingProviderObservation._(
          provider: BuiltValueNullFieldError.checkNotNull(
              provider, r'FundingProviderObservation', 'provider'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'FundingProviderObservation', 'status'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'FundingProviderObservation', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
