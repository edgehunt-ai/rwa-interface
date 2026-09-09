// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletActionExecutionSubmissionRequest
    extends WalletActionExecutionSubmissionRequest {
  @override
  final OneOf oneOf;

  factory _$WalletActionExecutionSubmissionRequest(
          [void Function(WalletActionExecutionSubmissionRequestBuilder)?
              updates]) =>
      (WalletActionExecutionSubmissionRequestBuilder()..update(updates))
          ._build();

  _$WalletActionExecutionSubmissionRequest._({required this.oneOf}) : super._();
  @override
  WalletActionExecutionSubmissionRequest rebuild(
          void Function(WalletActionExecutionSubmissionRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionExecutionSubmissionRequestBuilder toBuilder() =>
      WalletActionExecutionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionExecutionSubmissionRequest &&
        oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WalletActionExecutionSubmissionRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class WalletActionExecutionSubmissionRequestBuilder
    implements
        Builder<WalletActionExecutionSubmissionRequest,
            WalletActionExecutionSubmissionRequestBuilder> {
  _$WalletActionExecutionSubmissionRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  WalletActionExecutionSubmissionRequestBuilder() {
    WalletActionExecutionSubmissionRequest._defaults(this);
  }

  WalletActionExecutionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionExecutionSubmissionRequest other) {
    _$v = other as _$WalletActionExecutionSubmissionRequest;
  }

  @override
  void update(
      void Function(WalletActionExecutionSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionExecutionSubmissionRequest build() => _build();

  _$WalletActionExecutionSubmissionRequest _build() {
    final _$result = _$v ??
        _$WalletActionExecutionSubmissionRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'WalletActionExecutionSubmissionRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
