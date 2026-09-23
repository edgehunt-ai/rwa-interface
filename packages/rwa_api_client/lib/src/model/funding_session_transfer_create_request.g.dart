// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_transfer_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionTransferCreateRequest
    extends FundingSessionTransferCreateRequest {
  @override
  final FundingSessionTransferIntent transfer;

  factory _$FundingSessionTransferCreateRequest(
          [void Function(FundingSessionTransferCreateRequestBuilder)?
              updates]) =>
      (FundingSessionTransferCreateRequestBuilder()..update(updates))._build();

  _$FundingSessionTransferCreateRequest._({required this.transfer}) : super._();
  @override
  FundingSessionTransferCreateRequest rebuild(
          void Function(FundingSessionTransferCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTransferCreateRequestBuilder toBuilder() =>
      FundingSessionTransferCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTransferCreateRequest &&
        transfer == other.transfer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transfer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionTransferCreateRequest')
          ..add('transfer', transfer))
        .toString();
  }
}

class FundingSessionTransferCreateRequestBuilder
    implements
        Builder<FundingSessionTransferCreateRequest,
            FundingSessionTransferCreateRequestBuilder> {
  _$FundingSessionTransferCreateRequest? _$v;

  FundingSessionTransferIntentBuilder? _transfer;
  FundingSessionTransferIntentBuilder get transfer =>
      _$this._transfer ??= FundingSessionTransferIntentBuilder();
  set transfer(FundingSessionTransferIntentBuilder? transfer) =>
      _$this._transfer = transfer;

  FundingSessionTransferCreateRequestBuilder() {
    FundingSessionTransferCreateRequest._defaults(this);
  }

  FundingSessionTransferCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transfer = $v.transfer.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTransferCreateRequest other) {
    _$v = other as _$FundingSessionTransferCreateRequest;
  }

  @override
  void update(
      void Function(FundingSessionTransferCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTransferCreateRequest build() => _build();

  _$FundingSessionTransferCreateRequest _build() {
    _$FundingSessionTransferCreateRequest _$result;
    try {
      _$result = _$v ??
          _$FundingSessionTransferCreateRequest._(
            transfer: transfer.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transfer';
        transfer.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'FundingSessionTransferCreateRequest',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
