// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_cancellation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NativeCancellation extends NativeCancellation {
  @override
  final String cancellationId;
  @override
  final String nonce;
  @override
  final String to;
  @override
  final NativeCancellationStatus status;
  @override
  final PrivyAuthorizationPayload? privyAuthorizationPayload;
  @override
  final DateTime? authorizationExpiresAt;
  @override
  final String? txHash;
  @override
  final WalletActionChainObservation? chainObservation;

  factory _$NativeCancellation(
          [void Function(NativeCancellationBuilder)? updates]) =>
      (NativeCancellationBuilder()..update(updates))._build();

  _$NativeCancellation._(
      {required this.cancellationId,
      required this.nonce,
      required this.to,
      required this.status,
      this.privyAuthorizationPayload,
      this.authorizationExpiresAt,
      this.txHash,
      this.chainObservation})
      : super._();
  @override
  NativeCancellation rebuild(
          void Function(NativeCancellationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NativeCancellationBuilder toBuilder() =>
      NativeCancellationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NativeCancellation &&
        cancellationId == other.cancellationId &&
        nonce == other.nonce &&
        to == other.to &&
        status == other.status &&
        privyAuthorizationPayload == other.privyAuthorizationPayload &&
        authorizationExpiresAt == other.authorizationExpiresAt &&
        txHash == other.txHash &&
        chainObservation == other.chainObservation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cancellationId.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, privyAuthorizationPayload.hashCode);
    _$hash = $jc(_$hash, authorizationExpiresAt.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, chainObservation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NativeCancellation')
          ..add('cancellationId', cancellationId)
          ..add('nonce', nonce)
          ..add('to', to)
          ..add('status', status)
          ..add('privyAuthorizationPayload', privyAuthorizationPayload)
          ..add('authorizationExpiresAt', authorizationExpiresAt)
          ..add('txHash', txHash)
          ..add('chainObservation', chainObservation))
        .toString();
  }
}

class NativeCancellationBuilder
    implements Builder<NativeCancellation, NativeCancellationBuilder> {
  _$NativeCancellation? _$v;

  String? _cancellationId;
  String? get cancellationId => _$this._cancellationId;
  set cancellationId(String? cancellationId) =>
      _$this._cancellationId = cancellationId;

  String? _nonce;
  String? get nonce => _$this._nonce;
  set nonce(String? nonce) => _$this._nonce = nonce;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  NativeCancellationStatus? _status;
  NativeCancellationStatus? get status => _$this._status;
  set status(NativeCancellationStatus? status) => _$this._status = status;

  PrivyAuthorizationPayloadBuilder? _privyAuthorizationPayload;
  PrivyAuthorizationPayloadBuilder get privyAuthorizationPayload =>
      _$this._privyAuthorizationPayload ??= PrivyAuthorizationPayloadBuilder();
  set privyAuthorizationPayload(
          PrivyAuthorizationPayloadBuilder? privyAuthorizationPayload) =>
      _$this._privyAuthorizationPayload = privyAuthorizationPayload;

  DateTime? _authorizationExpiresAt;
  DateTime? get authorizationExpiresAt => _$this._authorizationExpiresAt;
  set authorizationExpiresAt(DateTime? authorizationExpiresAt) =>
      _$this._authorizationExpiresAt = authorizationExpiresAt;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  WalletActionChainObservationBuilder? _chainObservation;
  WalletActionChainObservationBuilder get chainObservation =>
      _$this._chainObservation ??= WalletActionChainObservationBuilder();
  set chainObservation(WalletActionChainObservationBuilder? chainObservation) =>
      _$this._chainObservation = chainObservation;

  NativeCancellationBuilder() {
    NativeCancellation._defaults(this);
  }

  NativeCancellationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cancellationId = $v.cancellationId;
      _nonce = $v.nonce;
      _to = $v.to;
      _status = $v.status;
      _privyAuthorizationPayload = $v.privyAuthorizationPayload?.toBuilder();
      _authorizationExpiresAt = $v.authorizationExpiresAt;
      _txHash = $v.txHash;
      _chainObservation = $v.chainObservation?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NativeCancellation other) {
    _$v = other as _$NativeCancellation;
  }

  @override
  void update(void Function(NativeCancellationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NativeCancellation build() => _build();

  _$NativeCancellation _build() {
    _$NativeCancellation _$result;
    try {
      _$result = _$v ??
          _$NativeCancellation._(
            cancellationId: BuiltValueNullFieldError.checkNotNull(
                cancellationId, r'NativeCancellation', 'cancellationId'),
            nonce: BuiltValueNullFieldError.checkNotNull(
                nonce, r'NativeCancellation', 'nonce'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'NativeCancellation', 'to'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'NativeCancellation', 'status'),
            privyAuthorizationPayload: _privyAuthorizationPayload?.build(),
            authorizationExpiresAt: authorizationExpiresAt,
            txHash: txHash,
            chainObservation: _chainObservation?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'privyAuthorizationPayload';
        _privyAuthorizationPayload?.build();

        _$failedField = 'chainObservation';
        _chainObservation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NativeCancellation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
