// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_depth_side_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksDepthSideStateReasonEnum
    _$bstocksDepthSideStateReasonEnum_admissionInputLimit =
    const BstocksDepthSideStateReasonEnum._('admissionInputLimit');
const BstocksDepthSideStateReasonEnum
    _$bstocksDepthSideStateReasonEnum_quoteRejected =
    const BstocksDepthSideStateReasonEnum._('quoteRejected');
const BstocksDepthSideStateReasonEnum
    _$bstocksDepthSideStateReasonEnum_quoterUnavailable =
    const BstocksDepthSideStateReasonEnum._('quoterUnavailable');
const BstocksDepthSideStateReasonEnum
    _$bstocksDepthSideStateReasonEnum_samplingTimeout =
    const BstocksDepthSideStateReasonEnum._('samplingTimeout');
const BstocksDepthSideStateReasonEnum
    _$bstocksDepthSideStateReasonEnum_unknownDefaultOpenApi =
    const BstocksDepthSideStateReasonEnum._('unknownDefaultOpenApi');

BstocksDepthSideStateReasonEnum _$bstocksDepthSideStateReasonEnumValueOf(
    String name) {
  switch (name) {
    case 'admissionInputLimit':
      return _$bstocksDepthSideStateReasonEnum_admissionInputLimit;
    case 'quoteRejected':
      return _$bstocksDepthSideStateReasonEnum_quoteRejected;
    case 'quoterUnavailable':
      return _$bstocksDepthSideStateReasonEnum_quoterUnavailable;
    case 'samplingTimeout':
      return _$bstocksDepthSideStateReasonEnum_samplingTimeout;
    case 'unknownDefaultOpenApi':
      return _$bstocksDepthSideStateReasonEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksDepthSideStateReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksDepthSideStateReasonEnum>
    _$bstocksDepthSideStateReasonEnumValues = BuiltSet<
        BstocksDepthSideStateReasonEnum>(const <BstocksDepthSideStateReasonEnum>[
  _$bstocksDepthSideStateReasonEnum_admissionInputLimit,
  _$bstocksDepthSideStateReasonEnum_quoteRejected,
  _$bstocksDepthSideStateReasonEnum_quoterUnavailable,
  _$bstocksDepthSideStateReasonEnum_samplingTimeout,
  _$bstocksDepthSideStateReasonEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksDepthSideStateReasonEnum>
    _$bstocksDepthSideStateReasonEnumSerializer =
    _$BstocksDepthSideStateReasonEnumSerializer();

class _$BstocksDepthSideStateReasonEnumSerializer
    implements PrimitiveSerializer<BstocksDepthSideStateReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'admissionInputLimit': 'admission_input_limit',
    'quoteRejected': 'quote_rejected',
    'quoterUnavailable': 'quoter_unavailable',
    'samplingTimeout': 'sampling_timeout',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'admission_input_limit': 'admissionInputLimit',
    'quote_rejected': 'quoteRejected',
    'quoter_unavailable': 'quoterUnavailable',
    'sampling_timeout': 'samplingTimeout',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksDepthSideStateReasonEnum];
  @override
  final String wireName = 'BstocksDepthSideStateReasonEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksDepthSideStateReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksDepthSideStateReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksDepthSideStateReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksDepthSideState extends BstocksDepthSideState {
  @override
  final BstocksDepthStatus status;
  @override
  final BstocksDepthSideStateReasonEnum? reason;

  factory _$BstocksDepthSideState(
          [void Function(BstocksDepthSideStateBuilder)? updates]) =>
      (BstocksDepthSideStateBuilder()..update(updates))._build();

  _$BstocksDepthSideState._({required this.status, this.reason}) : super._();
  @override
  BstocksDepthSideState rebuild(
          void Function(BstocksDepthSideStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksDepthSideStateBuilder toBuilder() =>
      BstocksDepthSideStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksDepthSideState &&
        status == other.status &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksDepthSideState')
          ..add('status', status)
          ..add('reason', reason))
        .toString();
  }
}

class BstocksDepthSideStateBuilder
    implements Builder<BstocksDepthSideState, BstocksDepthSideStateBuilder> {
  _$BstocksDepthSideState? _$v;

  BstocksDepthStatus? _status;
  BstocksDepthStatus? get status => _$this._status;
  set status(BstocksDepthStatus? status) => _$this._status = status;

  BstocksDepthSideStateReasonEnum? _reason;
  BstocksDepthSideStateReasonEnum? get reason => _$this._reason;
  set reason(BstocksDepthSideStateReasonEnum? reason) =>
      _$this._reason = reason;

  BstocksDepthSideStateBuilder() {
    BstocksDepthSideState._defaults(this);
  }

  BstocksDepthSideStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksDepthSideState other) {
    _$v = other as _$BstocksDepthSideState;
  }

  @override
  void update(void Function(BstocksDepthSideStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksDepthSideState build() => _build();

  _$BstocksDepthSideState _build() {
    final _$result = _$v ??
        _$BstocksDepthSideState._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'BstocksDepthSideState', 'status'),
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
