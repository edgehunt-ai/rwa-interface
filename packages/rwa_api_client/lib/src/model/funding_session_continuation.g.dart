// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_continuation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionContinuationActionEnum
    _$fundingSessionContinuationActionEnum_resumeBstocksOrder =
    const FundingSessionContinuationActionEnum._('resumeBstocksOrder');
const FundingSessionContinuationActionEnum
    _$fundingSessionContinuationActionEnum_unknownDefaultOpenApi =
    const FundingSessionContinuationActionEnum._('unknownDefaultOpenApi');

FundingSessionContinuationActionEnum
    _$fundingSessionContinuationActionEnumValueOf(String name) {
  switch (name) {
    case 'resumeBstocksOrder':
      return _$fundingSessionContinuationActionEnum_resumeBstocksOrder;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionContinuationActionEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionContinuationActionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionContinuationActionEnum>
    _$fundingSessionContinuationActionEnumValues = BuiltSet<
        FundingSessionContinuationActionEnum>(const <FundingSessionContinuationActionEnum>[
  _$fundingSessionContinuationActionEnum_resumeBstocksOrder,
  _$fundingSessionContinuationActionEnum_unknownDefaultOpenApi,
]);

const FundingSessionContinuationStatusEnum
    _$fundingSessionContinuationStatusEnum_readyToRequote =
    const FundingSessionContinuationStatusEnum._('readyToRequote');
const FundingSessionContinuationStatusEnum
    _$fundingSessionContinuationStatusEnum_unknownDefaultOpenApi =
    const FundingSessionContinuationStatusEnum._('unknownDefaultOpenApi');

FundingSessionContinuationStatusEnum
    _$fundingSessionContinuationStatusEnumValueOf(String name) {
  switch (name) {
    case 'readyToRequote':
      return _$fundingSessionContinuationStatusEnum_readyToRequote;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionContinuationStatusEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionContinuationStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionContinuationStatusEnum>
    _$fundingSessionContinuationStatusEnumValues = BuiltSet<
        FundingSessionContinuationStatusEnum>(const <FundingSessionContinuationStatusEnum>[
  _$fundingSessionContinuationStatusEnum_readyToRequote,
  _$fundingSessionContinuationStatusEnum_unknownDefaultOpenApi,
]);

Serializer<FundingSessionContinuationActionEnum>
    _$fundingSessionContinuationActionEnumSerializer =
    _$FundingSessionContinuationActionEnumSerializer();
Serializer<FundingSessionContinuationStatusEnum>
    _$fundingSessionContinuationStatusEnumSerializer =
    _$FundingSessionContinuationStatusEnumSerializer();

class _$FundingSessionContinuationActionEnumSerializer
    implements PrimitiveSerializer<FundingSessionContinuationActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'resumeBstocksOrder': 'resume_bstocks_order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'resume_bstocks_order': 'resumeBstocksOrder',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionContinuationActionEnum
  ];
  @override
  final String wireName = 'FundingSessionContinuationActionEnum';

  @override
  Object serialize(
          Serializers serializers, FundingSessionContinuationActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionContinuationActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionContinuationActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionContinuationStatusEnumSerializer
    implements PrimitiveSerializer<FundingSessionContinuationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'readyToRequote': 'ready_to_requote',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ready_to_requote': 'readyToRequote',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionContinuationStatusEnum
  ];
  @override
  final String wireName = 'FundingSessionContinuationStatusEnum';

  @override
  Object serialize(
          Serializers serializers, FundingSessionContinuationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionContinuationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionContinuationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionContinuation extends FundingSessionContinuation {
  @override
  final FundingSessionContinuationActionEnum action;
  @override
  final FundingSessionContinuationStatusEnum status;
  @override
  final String fundingSessionId;
  @override
  final OrderPreviewRequest trade;
  @override
  final bool requiresNewQuote;
  @override
  final bool autoSubmit;

  factory _$FundingSessionContinuation(
          [void Function(FundingSessionContinuationBuilder)? updates]) =>
      (FundingSessionContinuationBuilder()..update(updates))._build();

  _$FundingSessionContinuation._(
      {required this.action,
      required this.status,
      required this.fundingSessionId,
      required this.trade,
      required this.requiresNewQuote,
      required this.autoSubmit})
      : super._();
  @override
  FundingSessionContinuation rebuild(
          void Function(FundingSessionContinuationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionContinuationBuilder toBuilder() =>
      FundingSessionContinuationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionContinuation &&
        action == other.action &&
        status == other.status &&
        fundingSessionId == other.fundingSessionId &&
        trade == other.trade &&
        requiresNewQuote == other.requiresNewQuote &&
        autoSubmit == other.autoSubmit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, trade.hashCode);
    _$hash = $jc(_$hash, requiresNewQuote.hashCode);
    _$hash = $jc(_$hash, autoSubmit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionContinuation')
          ..add('action', action)
          ..add('status', status)
          ..add('fundingSessionId', fundingSessionId)
          ..add('trade', trade)
          ..add('requiresNewQuote', requiresNewQuote)
          ..add('autoSubmit', autoSubmit))
        .toString();
  }
}

class FundingSessionContinuationBuilder
    implements
        Builder<FundingSessionContinuation, FundingSessionContinuationBuilder> {
  _$FundingSessionContinuation? _$v;

  FundingSessionContinuationActionEnum? _action;
  FundingSessionContinuationActionEnum? get action => _$this._action;
  set action(FundingSessionContinuationActionEnum? action) =>
      _$this._action = action;

  FundingSessionContinuationStatusEnum? _status;
  FundingSessionContinuationStatusEnum? get status => _$this._status;
  set status(FundingSessionContinuationStatusEnum? status) =>
      _$this._status = status;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  OrderPreviewRequestBuilder? _trade;
  OrderPreviewRequestBuilder get trade =>
      _$this._trade ??= OrderPreviewRequestBuilder();
  set trade(OrderPreviewRequestBuilder? trade) => _$this._trade = trade;

  bool? _requiresNewQuote;
  bool? get requiresNewQuote => _$this._requiresNewQuote;
  set requiresNewQuote(bool? requiresNewQuote) =>
      _$this._requiresNewQuote = requiresNewQuote;

  bool? _autoSubmit;
  bool? get autoSubmit => _$this._autoSubmit;
  set autoSubmit(bool? autoSubmit) => _$this._autoSubmit = autoSubmit;

  FundingSessionContinuationBuilder() {
    FundingSessionContinuation._defaults(this);
  }

  FundingSessionContinuationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _status = $v.status;
      _fundingSessionId = $v.fundingSessionId;
      _trade = $v.trade.toBuilder();
      _requiresNewQuote = $v.requiresNewQuote;
      _autoSubmit = $v.autoSubmit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionContinuation other) {
    _$v = other as _$FundingSessionContinuation;
  }

  @override
  void update(void Function(FundingSessionContinuationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionContinuation build() => _build();

  _$FundingSessionContinuation _build() {
    _$FundingSessionContinuation _$result;
    try {
      _$result = _$v ??
          _$FundingSessionContinuation._(
            action: BuiltValueNullFieldError.checkNotNull(
                action, r'FundingSessionContinuation', 'action'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingSessionContinuation', 'status'),
            fundingSessionId: BuiltValueNullFieldError.checkNotNull(
                fundingSessionId,
                r'FundingSessionContinuation',
                'fundingSessionId'),
            trade: trade.build(),
            requiresNewQuote: BuiltValueNullFieldError.checkNotNull(
                requiresNewQuote,
                r'FundingSessionContinuation',
                'requiresNewQuote'),
            autoSubmit: BuiltValueNullFieldError.checkNotNull(
                autoSubmit, r'FundingSessionContinuation', 'autoSubmit'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'trade';
        trade.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionContinuation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
