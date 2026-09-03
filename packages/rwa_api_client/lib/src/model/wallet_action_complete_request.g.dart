// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_complete_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletActionCompleteRequest extends WalletActionCompleteRequest {
  @override
  final String signature;

  factory _$WalletActionCompleteRequest(
          [void Function(WalletActionCompleteRequestBuilder)? updates]) =>
      (WalletActionCompleteRequestBuilder()..update(updates))._build();

  _$WalletActionCompleteRequest._({required this.signature}) : super._();
  @override
  WalletActionCompleteRequest rebuild(
          void Function(WalletActionCompleteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionCompleteRequestBuilder toBuilder() =>
      WalletActionCompleteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionCompleteRequest && signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletActionCompleteRequest')
          ..add('signature', signature))
        .toString();
  }
}

class WalletActionCompleteRequestBuilder
    implements
        Builder<WalletActionCompleteRequest,
            WalletActionCompleteRequestBuilder> {
  _$WalletActionCompleteRequest? _$v;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  WalletActionCompleteRequestBuilder() {
    WalletActionCompleteRequest._defaults(this);
  }

  WalletActionCompleteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionCompleteRequest other) {
    _$v = other as _$WalletActionCompleteRequest;
  }

  @override
  void update(void Function(WalletActionCompleteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionCompleteRequest build() => _build();

  _$WalletActionCompleteRequest _build() {
    final _$result = _$v ??
        _$WalletActionCompleteRequest._(
          signature: BuiltValueNullFieldError.checkNotNull(
              signature, r'WalletActionCompleteRequest', 'signature'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
