// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletActionExecutionCreateRequest
    extends WalletActionExecutionCreateRequest {
  @override
  final GasPaymentMode mode;

  factory _$WalletActionExecutionCreateRequest(
          [void Function(WalletActionExecutionCreateRequestBuilder)?
              updates]) =>
      (WalletActionExecutionCreateRequestBuilder()..update(updates))._build();

  _$WalletActionExecutionCreateRequest._({required this.mode}) : super._();
  @override
  WalletActionExecutionCreateRequest rebuild(
          void Function(WalletActionExecutionCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionExecutionCreateRequestBuilder toBuilder() =>
      WalletActionExecutionCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionExecutionCreateRequest && mode == other.mode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletActionExecutionCreateRequest')
          ..add('mode', mode))
        .toString();
  }
}

class WalletActionExecutionCreateRequestBuilder
    implements
        Builder<WalletActionExecutionCreateRequest,
            WalletActionExecutionCreateRequestBuilder> {
  _$WalletActionExecutionCreateRequest? _$v;

  GasPaymentMode? _mode;
  GasPaymentMode? get mode => _$this._mode;
  set mode(GasPaymentMode? mode) => _$this._mode = mode;

  WalletActionExecutionCreateRequestBuilder() {
    WalletActionExecutionCreateRequest._defaults(this);
  }

  WalletActionExecutionCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mode = $v.mode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionExecutionCreateRequest other) {
    _$v = other as _$WalletActionExecutionCreateRequest;
  }

  @override
  void update(
      void Function(WalletActionExecutionCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionExecutionCreateRequest build() => _build();

  _$WalletActionExecutionCreateRequest _build() {
    final _$result = _$v ??
        _$WalletActionExecutionCreateRequest._(
          mode: BuiltValueNullFieldError.checkNotNull(
              mode, r'WalletActionExecutionCreateRequest', 'mode'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
