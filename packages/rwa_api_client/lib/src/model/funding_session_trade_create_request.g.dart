// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_trade_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionTradeCreateRequest
    extends FundingSessionTradeCreateRequest {
  @override
  final OrderPreviewRequest trade;

  factory _$FundingSessionTradeCreateRequest(
          [void Function(FundingSessionTradeCreateRequestBuilder)? updates]) =>
      (FundingSessionTradeCreateRequestBuilder()..update(updates))._build();

  _$FundingSessionTradeCreateRequest._({required this.trade}) : super._();
  @override
  FundingSessionTradeCreateRequest rebuild(
          void Function(FundingSessionTradeCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTradeCreateRequestBuilder toBuilder() =>
      FundingSessionTradeCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTradeCreateRequest && trade == other.trade;
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
    return (newBuiltValueToStringHelper(r'FundingSessionTradeCreateRequest')
          ..add('trade', trade))
        .toString();
  }
}

class FundingSessionTradeCreateRequestBuilder
    implements
        Builder<FundingSessionTradeCreateRequest,
            FundingSessionTradeCreateRequestBuilder> {
  _$FundingSessionTradeCreateRequest? _$v;

  OrderPreviewRequestBuilder? _trade;
  OrderPreviewRequestBuilder get trade =>
      _$this._trade ??= OrderPreviewRequestBuilder();
  set trade(OrderPreviewRequestBuilder? trade) => _$this._trade = trade;

  FundingSessionTradeCreateRequestBuilder() {
    FundingSessionTradeCreateRequest._defaults(this);
  }

  FundingSessionTradeCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trade = $v.trade.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTradeCreateRequest other) {
    _$v = other as _$FundingSessionTradeCreateRequest;
  }

  @override
  void update(void Function(FundingSessionTradeCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTradeCreateRequest build() => _build();

  _$FundingSessionTradeCreateRequest _build() {
    _$FundingSessionTradeCreateRequest _$result;
    try {
      _$result = _$v ??
          _$FundingSessionTradeCreateRequest._(
            trade: trade.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'trade';
        trade.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionTradeCreateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
