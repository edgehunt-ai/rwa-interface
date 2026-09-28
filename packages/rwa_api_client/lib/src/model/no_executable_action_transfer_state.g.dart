// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_executable_action_transfer_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_awaitingAuthorization =
    const NoExecutableActionTransferStateStatusEnum._('awaitingAuthorization');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_originSubmitted =
    const NoExecutableActionTransferStateStatusEnum._('originSubmitted');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_originConfirmed =
    const NoExecutableActionTransferStateStatusEnum._('originConfirmed');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_filling =
    const NoExecutableActionTransferStateStatusEnum._('filling');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_completed =
    const NoExecutableActionTransferStateStatusEnum._('completed');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_refundPending =
    const NoExecutableActionTransferStateStatusEnum._('refundPending');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_refunded =
    const NoExecutableActionTransferStateStatusEnum._('refunded');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_failed =
    const NoExecutableActionTransferStateStatusEnum._('failed');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_ambiguous =
    const NoExecutableActionTransferStateStatusEnum._('ambiguous');
const NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnum_manualReview =
    const NoExecutableActionTransferStateStatusEnum._('manualReview');

NoExecutableActionTransferStateStatusEnum
    _$noExecutableActionTransferStateStatusEnumValueOf(String name) {
  switch (name) {
    case 'awaitingAuthorization':
      return _$noExecutableActionTransferStateStatusEnum_awaitingAuthorization;
    case 'originSubmitted':
      return _$noExecutableActionTransferStateStatusEnum_originSubmitted;
    case 'originConfirmed':
      return _$noExecutableActionTransferStateStatusEnum_originConfirmed;
    case 'filling':
      return _$noExecutableActionTransferStateStatusEnum_filling;
    case 'completed':
      return _$noExecutableActionTransferStateStatusEnum_completed;
    case 'refundPending':
      return _$noExecutableActionTransferStateStatusEnum_refundPending;
    case 'refunded':
      return _$noExecutableActionTransferStateStatusEnum_refunded;
    case 'failed':
      return _$noExecutableActionTransferStateStatusEnum_failed;
    case 'ambiguous':
      return _$noExecutableActionTransferStateStatusEnum_ambiguous;
    case 'manualReview':
      return _$noExecutableActionTransferStateStatusEnum_manualReview;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NoExecutableActionTransferStateStatusEnum>
    _$noExecutableActionTransferStateStatusEnumValues = BuiltSet<
        NoExecutableActionTransferStateStatusEnum>(const <NoExecutableActionTransferStateStatusEnum>[
  _$noExecutableActionTransferStateStatusEnum_awaitingAuthorization,
  _$noExecutableActionTransferStateStatusEnum_originSubmitted,
  _$noExecutableActionTransferStateStatusEnum_originConfirmed,
  _$noExecutableActionTransferStateStatusEnum_filling,
  _$noExecutableActionTransferStateStatusEnum_completed,
  _$noExecutableActionTransferStateStatusEnum_refundPending,
  _$noExecutableActionTransferStateStatusEnum_refunded,
  _$noExecutableActionTransferStateStatusEnum_failed,
  _$noExecutableActionTransferStateStatusEnum_ambiguous,
  _$noExecutableActionTransferStateStatusEnum_manualReview,
]);

Serializer<NoExecutableActionTransferStateStatusEnum>
    _$noExecutableActionTransferStateStatusEnumSerializer =
    _$NoExecutableActionTransferStateStatusEnumSerializer();

class _$NoExecutableActionTransferStateStatusEnumSerializer
    implements PrimitiveSerializer<NoExecutableActionTransferStateStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingAuthorization': 'awaiting_authorization',
    'originSubmitted': 'origin_submitted',
    'originConfirmed': 'origin_confirmed',
    'filling': 'filling',
    'completed': 'completed',
    'refundPending': 'refund_pending',
    'refunded': 'refunded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_authorization': 'awaitingAuthorization',
    'origin_submitted': 'originSubmitted',
    'origin_confirmed': 'originConfirmed',
    'filling': 'filling',
    'completed': 'completed',
    'refund_pending': 'refundPending',
    'refunded': 'refunded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NoExecutableActionTransferStateStatusEnum
  ];
  @override
  final String wireName = 'NoExecutableActionTransferStateStatusEnum';

  @override
  Object serialize(Serializers serializers,
          NoExecutableActionTransferStateStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NoExecutableActionTransferStateStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NoExecutableActionTransferStateStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$NoExecutableActionTransferState
    extends NoExecutableActionTransferState {
  @override
  final NoExecutableActionTransferStateStatusEnum status;
  @override
  final JsonObject? nextAction;

  factory _$NoExecutableActionTransferState(
          [void Function(NoExecutableActionTransferStateBuilder)? updates]) =>
      (NoExecutableActionTransferStateBuilder()..update(updates))._build();

  _$NoExecutableActionTransferState._({required this.status, this.nextAction})
      : super._();
  @override
  NoExecutableActionTransferState rebuild(
          void Function(NoExecutableActionTransferStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoExecutableActionTransferStateBuilder toBuilder() =>
      NoExecutableActionTransferStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoExecutableActionTransferState &&
        status == other.status &&
        nextAction == other.nextAction;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoExecutableActionTransferState')
          ..add('status', status)
          ..add('nextAction', nextAction))
        .toString();
  }
}

class NoExecutableActionTransferStateBuilder
    implements
        Builder<NoExecutableActionTransferState,
            NoExecutableActionTransferStateBuilder> {
  _$NoExecutableActionTransferState? _$v;

  NoExecutableActionTransferStateStatusEnum? _status;
  NoExecutableActionTransferStateStatusEnum? get status => _$this._status;
  set status(NoExecutableActionTransferStateStatusEnum? status) =>
      _$this._status = status;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(JsonObject? nextAction) => _$this._nextAction = nextAction;

  NoExecutableActionTransferStateBuilder() {
    NoExecutableActionTransferState._defaults(this);
  }

  NoExecutableActionTransferStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _nextAction = $v.nextAction;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoExecutableActionTransferState other) {
    _$v = other as _$NoExecutableActionTransferState;
  }

  @override
  void update(void Function(NoExecutableActionTransferStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoExecutableActionTransferState build() => _build();

  _$NoExecutableActionTransferState _build() {
    final _$result = _$v ??
        _$NoExecutableActionTransferState._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'NoExecutableActionTransferState', 'status'),
          nextAction: nextAction,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
