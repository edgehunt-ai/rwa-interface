// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionCreateRequest extends FundingSessionCreateRequest {
  @override
  final OrderPreviewRequest trade;

  factory _$FundingSessionCreateRequest(
          [void Function(FundingSessionCreateRequestBuilder)? updates]) =>
      (FundingSessionCreateRequestBuilder()..update(updates))._build();

  _$FundingSessionCreateRequest._({required this.trade}) : super._();
  @override
  FundingSessionCreateRequest rebuild(
          void Function(FundingSessionCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionCreateRequestBuilder toBuilder() =>
      FundingSessionCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionCreateRequest && trade == other.trade;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, trade.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionCreateRequest')
          ..add('trade', trade))
        .toString();
  }
}

class FundingSessionCreateRequestBuilder
    implements
        Builder<FundingSessionCreateRequest,
            FundingSessionCreateRequestBuilder> {
  _$FundingSessionCreateRequest? _$v;

  OrderPreviewRequestBuilder? _trade;
  OrderPreviewRequestBuilder get trade =>
      _$this._trade ??= OrderPreviewRequestBuilder();
  set trade(OrderPreviewRequestBuilder? trade) => _$this._trade = trade;

  FundingSessionCreateRequestBuilder() {
    FundingSessionCreateRequest._defaults(this);
  }

  FundingSessionCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trade = $v.trade.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionCreateRequest other) {
    _$v = other as _$FundingSessionCreateRequest;
  }

  @override
  void update(void Function(FundingSessionCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionCreateRequest build() => _build();

  _$FundingSessionCreateRequest _build() {
    _$FundingSessionCreateRequest _$result;
    try {
      _$result = _$v ??
          _$FundingSessionCreateRequest._(
            trade: trade.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'trade';
        trade.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionCreateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
