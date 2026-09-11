// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountDeletionRequest extends AccountDeletionRequest {
  @override
  final String deletionRequestId;
  @override
  final AccountDeletionStatus status;
  @override
  final BuiltList<AccountDeletionBlocker> blockers;
  @override
  final String? failureReason;
  @override
  final DateTime requestedAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? anonymizedAt;

  factory _$AccountDeletionRequest(
          [void Function(AccountDeletionRequestBuilder)? updates]) =>
      (AccountDeletionRequestBuilder()..update(updates))._build();

  _$AccountDeletionRequest._(
      {required this.deletionRequestId,
      required this.status,
      required this.blockers,
      this.failureReason,
      required this.requestedAt,
      required this.updatedAt,
      this.anonymizedAt})
      : super._();
  @override
  AccountDeletionRequest rebuild(
          void Function(AccountDeletionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountDeletionRequestBuilder toBuilder() =>
      AccountDeletionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountDeletionRequest &&
        deletionRequestId == other.deletionRequestId &&
        status == other.status &&
        blockers == other.blockers &&
        failureReason == other.failureReason &&
        requestedAt == other.requestedAt &&
        updatedAt == other.updatedAt &&
        anonymizedAt == other.anonymizedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deletionRequestId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, anonymizedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountDeletionRequest')
          ..add('deletionRequestId', deletionRequestId)
          ..add('status', status)
          ..add('blockers', blockers)
          ..add('failureReason', failureReason)
          ..add('requestedAt', requestedAt)
          ..add('updatedAt', updatedAt)
          ..add('anonymizedAt', anonymizedAt))
        .toString();
  }
}

class AccountDeletionRequestBuilder
    implements Builder<AccountDeletionRequest, AccountDeletionRequestBuilder> {
  _$AccountDeletionRequest? _$v;

  String? _deletionRequestId;
  String? get deletionRequestId => _$this._deletionRequestId;
  set deletionRequestId(String? deletionRequestId) =>
      _$this._deletionRequestId = deletionRequestId;

  AccountDeletionStatus? _status;
  AccountDeletionStatus? get status => _$this._status;
  set status(AccountDeletionStatus? status) => _$this._status = status;

  ListBuilder<AccountDeletionBlocker>? _blockers;
  ListBuilder<AccountDeletionBlocker> get blockers =>
      _$this._blockers ??= ListBuilder<AccountDeletionBlocker>();
  set blockers(ListBuilder<AccountDeletionBlocker>? blockers) =>
      _$this._blockers = blockers;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _anonymizedAt;
  DateTime? get anonymizedAt => _$this._anonymizedAt;
  set anonymizedAt(DateTime? anonymizedAt) =>
      _$this._anonymizedAt = anonymizedAt;

  AccountDeletionRequestBuilder() {
    AccountDeletionRequest._defaults(this);
  }

  AccountDeletionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deletionRequestId = $v.deletionRequestId;
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _failureReason = $v.failureReason;
      _requestedAt = $v.requestedAt;
      _updatedAt = $v.updatedAt;
      _anonymizedAt = $v.anonymizedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountDeletionRequest other) {
    _$v = other as _$AccountDeletionRequest;
  }

  @override
  void update(void Function(AccountDeletionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountDeletionRequest build() => _build();

  _$AccountDeletionRequest _build() {
    _$AccountDeletionRequest _$result;
    try {
      _$result = _$v ??
          _$AccountDeletionRequest._(
            deletionRequestId: BuiltValueNullFieldError.checkNotNull(
                deletionRequestId,
                r'AccountDeletionRequest',
                'deletionRequestId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'AccountDeletionRequest', 'status'),
            blockers: blockers.build(),
            failureReason: failureReason,
            requestedAt: BuiltValueNullFieldError.checkNotNull(
                requestedAt, r'AccountDeletionRequest', 'requestedAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'AccountDeletionRequest', 'updatedAt'),
            anonymizedAt: anonymizedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccountDeletionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
