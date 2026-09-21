// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3WithdrawalSubmissionRequest
    extends Hip3WithdrawalSubmissionRequest {
  @override
  final String signature;
  @override
  final String payloadHash;

  factory _$Hip3WithdrawalSubmissionRequest(
          [void Function(Hip3WithdrawalSubmissionRequestBuilder)? updates]) =>
      (Hip3WithdrawalSubmissionRequestBuilder()..update(updates))._build();

  _$Hip3WithdrawalSubmissionRequest._(
      {required this.signature, required this.payloadHash})
      : super._();
  @override
  Hip3WithdrawalSubmissionRequest rebuild(
          void Function(Hip3WithdrawalSubmissionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalSubmissionRequestBuilder toBuilder() =>
      Hip3WithdrawalSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3WithdrawalSubmissionRequest &&
        signature == other.signature &&
        payloadHash == other.payloadHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalSubmissionRequest')
          ..add('signature', signature)
          ..add('payloadHash', payloadHash))
        .toString();
  }
}

class Hip3WithdrawalSubmissionRequestBuilder
    implements
        Builder<Hip3WithdrawalSubmissionRequest,
            Hip3WithdrawalSubmissionRequestBuilder> {
  _$Hip3WithdrawalSubmissionRequest? _$v;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  Hip3WithdrawalSubmissionRequestBuilder() {
    Hip3WithdrawalSubmissionRequest._defaults(this);
  }

  Hip3WithdrawalSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signature = $v.signature;
      _payloadHash = $v.payloadHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3WithdrawalSubmissionRequest other) {
    _$v = other as _$Hip3WithdrawalSubmissionRequest;
  }

  @override
  void update(void Function(Hip3WithdrawalSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3WithdrawalSubmissionRequest build() => _build();

  _$Hip3WithdrawalSubmissionRequest _build() {
    final _$result = _$v ??
        _$Hip3WithdrawalSubmissionRequest._(
          signature: BuiltValueNullFieldError.checkNotNull(
              signature, r'Hip3WithdrawalSubmissionRequest', 'signature'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(
              payloadHash, r'Hip3WithdrawalSubmissionRequest', 'payloadHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
