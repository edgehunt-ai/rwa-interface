// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_action_submission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferActionSubmission extends TransferActionSubmission {
  @override
  final String submissionId;
  @override
  final String transferId;
  @override
  final String actionId;
  @override
  final String txHash;
  @override
  final TransferActionSubmissionStatus status;
  @override
  final DateTime reportedAt;
  @override
  final DateTime? verifiedAt;

  factory _$TransferActionSubmission(
          [void Function(TransferActionSubmissionBuilder)? updates]) =>
      (TransferActionSubmissionBuilder()..update(updates))._build();

  _$TransferActionSubmission._(
      {required this.submissionId,
      required this.transferId,
      required this.actionId,
      required this.txHash,
      required this.status,
      required this.reportedAt,
      this.verifiedAt})
      : super._();
  @override
  TransferActionSubmission rebuild(
          void Function(TransferActionSubmissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferActionSubmissionBuilder toBuilder() =>
      TransferActionSubmissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferActionSubmission &&
        submissionId == other.submissionId &&
        transferId == other.transferId &&
        actionId == other.actionId &&
        txHash == other.txHash &&
        status == other.status &&
        reportedAt == other.reportedAt &&
        verifiedAt == other.verifiedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, submissionId.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reportedAt.hashCode);
    _$hash = $jc(_$hash, verifiedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransferActionSubmission')
          ..add('submissionId', submissionId)
          ..add('transferId', transferId)
          ..add('actionId', actionId)
          ..add('txHash', txHash)
          ..add('status', status)
          ..add('reportedAt', reportedAt)
          ..add('verifiedAt', verifiedAt))
        .toString();
  }
}

class TransferActionSubmissionBuilder
    implements
        Builder<TransferActionSubmission, TransferActionSubmissionBuilder> {
  _$TransferActionSubmission? _$v;

  String? _submissionId;
  String? get submissionId => _$this._submissionId;
  set submissionId(String? submissionId) => _$this._submissionId = submissionId;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  TransferActionSubmissionStatus? _status;
  TransferActionSubmissionStatus? get status => _$this._status;
  set status(TransferActionSubmissionStatus? status) => _$this._status = status;

  DateTime? _reportedAt;
  DateTime? get reportedAt => _$this._reportedAt;
  set reportedAt(DateTime? reportedAt) => _$this._reportedAt = reportedAt;

  DateTime? _verifiedAt;
  DateTime? get verifiedAt => _$this._verifiedAt;
  set verifiedAt(DateTime? verifiedAt) => _$this._verifiedAt = verifiedAt;

  TransferActionSubmissionBuilder() {
    TransferActionSubmission._defaults(this);
  }

  TransferActionSubmissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _submissionId = $v.submissionId;
      _transferId = $v.transferId;
      _actionId = $v.actionId;
      _txHash = $v.txHash;
      _status = $v.status;
      _reportedAt = $v.reportedAt;
      _verifiedAt = $v.verifiedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferActionSubmission other) {
    _$v = other as _$TransferActionSubmission;
  }

  @override
  void update(void Function(TransferActionSubmissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferActionSubmission build() => _build();

  _$TransferActionSubmission _build() {
    final _$result = _$v ??
        _$TransferActionSubmission._(
          submissionId: BuiltValueNullFieldError.checkNotNull(
              submissionId, r'TransferActionSubmission', 'submissionId'),
          transferId: BuiltValueNullFieldError.checkNotNull(
              transferId, r'TransferActionSubmission', 'transferId'),
          actionId: BuiltValueNullFieldError.checkNotNull(
              actionId, r'TransferActionSubmission', 'actionId'),
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'TransferActionSubmission', 'txHash'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'TransferActionSubmission', 'status'),
          reportedAt: BuiltValueNullFieldError.checkNotNull(
              reportedAt, r'TransferActionSubmission', 'reportedAt'),
          verifiedAt: verifiedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
