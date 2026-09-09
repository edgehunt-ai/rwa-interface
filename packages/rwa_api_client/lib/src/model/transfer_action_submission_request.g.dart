// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_action_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferActionSubmissionRequest
    extends TransferActionSubmissionRequest {
  @override
  final String txHash;

  factory _$TransferActionSubmissionRequest(
          [void Function(TransferActionSubmissionRequestBuilder)? updates]) =>
      (TransferActionSubmissionRequestBuilder()..update(updates))._build();

  _$TransferActionSubmissionRequest._({required this.txHash}) : super._();
  @override
  TransferActionSubmissionRequest rebuild(
          void Function(TransferActionSubmissionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferActionSubmissionRequestBuilder toBuilder() =>
      TransferActionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferActionSubmissionRequest && txHash == other.txHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransferActionSubmissionRequest')
          ..add('txHash', txHash))
        .toString();
  }
}

class TransferActionSubmissionRequestBuilder
    implements
        Builder<TransferActionSubmissionRequest,
            TransferActionSubmissionRequestBuilder> {
  _$TransferActionSubmissionRequest? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  TransferActionSubmissionRequestBuilder() {
    TransferActionSubmissionRequest._defaults(this);
  }

  TransferActionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferActionSubmissionRequest other) {
    _$v = other as _$TransferActionSubmissionRequest;
  }

  @override
  void update(void Function(TransferActionSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferActionSubmissionRequest build() => _build();

  _$TransferActionSubmissionRequest _build() {
    final _$result = _$v ??
        _$TransferActionSubmissionRequest._(
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'TransferActionSubmissionRequest', 'txHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
