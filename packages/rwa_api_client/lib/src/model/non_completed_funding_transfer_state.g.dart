// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_completed_funding_transfer_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_awaitingAuthorization =
    const NonCompletedFundingTransferStateStatusEnum._('awaitingAuthorization');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_awaitingWallet =
    const NonCompletedFundingTransferStateStatusEnum._('awaitingWallet');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_originSubmitted =
    const NonCompletedFundingTransferStateStatusEnum._('originSubmitted');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_originConfirmed =
    const NonCompletedFundingTransferStateStatusEnum._('originConfirmed');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_filling =
    const NonCompletedFundingTransferStateStatusEnum._('filling');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_refundPending =
    const NonCompletedFundingTransferStateStatusEnum._('refundPending');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_refunded =
    const NonCompletedFundingTransferStateStatusEnum._('refunded');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_failed =
    const NonCompletedFundingTransferStateStatusEnum._('failed');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_ambiguous =
    const NonCompletedFundingTransferStateStatusEnum._('ambiguous');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_manualReview =
    const NonCompletedFundingTransferStateStatusEnum._('manualReview');
const NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnum_unknownDefaultOpenApi =
    const NonCompletedFundingTransferStateStatusEnum._('unknownDefaultOpenApi');

NonCompletedFundingTransferStateStatusEnum
    _$nonCompletedFundingTransferStateStatusEnumValueOf(String name) {
  switch (name) {
    case 'awaitingAuthorization':
      return _$nonCompletedFundingTransferStateStatusEnum_awaitingAuthorization;
    case 'awaitingWallet':
      return _$nonCompletedFundingTransferStateStatusEnum_awaitingWallet;
    case 'originSubmitted':
      return _$nonCompletedFundingTransferStateStatusEnum_originSubmitted;
    case 'originConfirmed':
      return _$nonCompletedFundingTransferStateStatusEnum_originConfirmed;
    case 'filling':
      return _$nonCompletedFundingTransferStateStatusEnum_filling;
    case 'refundPending':
      return _$nonCompletedFundingTransferStateStatusEnum_refundPending;
    case 'refunded':
      return _$nonCompletedFundingTransferStateStatusEnum_refunded;
    case 'failed':
      return _$nonCompletedFundingTransferStateStatusEnum_failed;
    case 'ambiguous':
      return _$nonCompletedFundingTransferStateStatusEnum_ambiguous;
    case 'manualReview':
      return _$nonCompletedFundingTransferStateStatusEnum_manualReview;
    case 'unknownDefaultOpenApi':
      return _$nonCompletedFundingTransferStateStatusEnum_unknownDefaultOpenApi;
    default:
      return _$nonCompletedFundingTransferStateStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<NonCompletedFundingTransferStateStatusEnum>
    _$nonCompletedFundingTransferStateStatusEnumValues = BuiltSet<
        NonCompletedFundingTransferStateStatusEnum>(const <NonCompletedFundingTransferStateStatusEnum>[
  _$nonCompletedFundingTransferStateStatusEnum_awaitingAuthorization,
  _$nonCompletedFundingTransferStateStatusEnum_awaitingWallet,
  _$nonCompletedFundingTransferStateStatusEnum_originSubmitted,
  _$nonCompletedFundingTransferStateStatusEnum_originConfirmed,
  _$nonCompletedFundingTransferStateStatusEnum_filling,
  _$nonCompletedFundingTransferStateStatusEnum_refundPending,
  _$nonCompletedFundingTransferStateStatusEnum_refunded,
  _$nonCompletedFundingTransferStateStatusEnum_failed,
  _$nonCompletedFundingTransferStateStatusEnum_ambiguous,
  _$nonCompletedFundingTransferStateStatusEnum_manualReview,
  _$nonCompletedFundingTransferStateStatusEnum_unknownDefaultOpenApi,
]);

Serializer<NonCompletedFundingTransferStateStatusEnum>
    _$nonCompletedFundingTransferStateStatusEnumSerializer =
    _$NonCompletedFundingTransferStateStatusEnumSerializer();

class _$NonCompletedFundingTransferStateStatusEnumSerializer
    implements PrimitiveSerializer<NonCompletedFundingTransferStateStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingAuthorization': 'awaiting_authorization',
    'awaitingWallet': 'awaiting_wallet',
    'originSubmitted': 'origin_submitted',
    'originConfirmed': 'origin_confirmed',
    'filling': 'filling',
    'refundPending': 'refund_pending',
    'refunded': 'refunded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_authorization': 'awaitingAuthorization',
    'awaiting_wallet': 'awaitingWallet',
    'origin_submitted': 'originSubmitted',
    'origin_confirmed': 'originConfirmed',
    'filling': 'filling',
    'refund_pending': 'refundPending',
    'refunded': 'refunded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NonCompletedFundingTransferStateStatusEnum
  ];
  @override
  final String wireName = 'NonCompletedFundingTransferStateStatusEnum';

  @override
  Object serialize(Serializers serializers,
          NonCompletedFundingTransferStateStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NonCompletedFundingTransferStateStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NonCompletedFundingTransferStateStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$NonCompletedFundingTransferState
    extends NonCompletedFundingTransferState {
  @override
  final NonCompletedFundingTransferStateStatusEnum status;

  factory _$NonCompletedFundingTransferState(
          [void Function(NonCompletedFundingTransferStateBuilder)? updates]) =>
      (NonCompletedFundingTransferStateBuilder()..update(updates))._build();

  _$NonCompletedFundingTransferState._({required this.status}) : super._();
  @override
  NonCompletedFundingTransferState rebuild(
          void Function(NonCompletedFundingTransferStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NonCompletedFundingTransferStateBuilder toBuilder() =>
      NonCompletedFundingTransferStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NonCompletedFundingTransferState && status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NonCompletedFundingTransferState')
          ..add('status', status))
        .toString();
  }
}

class NonCompletedFundingTransferStateBuilder
    implements
        Builder<NonCompletedFundingTransferState,
            NonCompletedFundingTransferStateBuilder> {
  _$NonCompletedFundingTransferState? _$v;

  NonCompletedFundingTransferStateStatusEnum? _status;
  NonCompletedFundingTransferStateStatusEnum? get status => _$this._status;
  set status(NonCompletedFundingTransferStateStatusEnum? status) =>
      _$this._status = status;

  NonCompletedFundingTransferStateBuilder() {
    NonCompletedFundingTransferState._defaults(this);
  }

  NonCompletedFundingTransferStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NonCompletedFundingTransferState other) {
    _$v = other as _$NonCompletedFundingTransferState;
  }

  @override
  void update(void Function(NonCompletedFundingTransferStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NonCompletedFundingTransferState build() => _build();

  _$NonCompletedFundingTransferState _build() {
    final _$result = _$v ??
        _$NonCompletedFundingTransferState._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'NonCompletedFundingTransferState', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
