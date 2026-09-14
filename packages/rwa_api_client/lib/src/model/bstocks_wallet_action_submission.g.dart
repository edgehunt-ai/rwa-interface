// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_wallet_action_submission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksWalletActionSubmissionStatusEnum
    _$bstocksWalletActionSubmissionStatusEnum_submitted =
    const BstocksWalletActionSubmissionStatusEnum._('submitted');
const BstocksWalletActionSubmissionStatusEnum
    _$bstocksWalletActionSubmissionStatusEnum_confirmed =
    const BstocksWalletActionSubmissionStatusEnum._('confirmed');
const BstocksWalletActionSubmissionStatusEnum
    _$bstocksWalletActionSubmissionStatusEnum_manualReview =
    const BstocksWalletActionSubmissionStatusEnum._('manualReview');
const BstocksWalletActionSubmissionStatusEnum
    _$bstocksWalletActionSubmissionStatusEnum_unknownDefaultOpenApi =
    const BstocksWalletActionSubmissionStatusEnum._('unknownDefaultOpenApi');

BstocksWalletActionSubmissionStatusEnum
    _$bstocksWalletActionSubmissionStatusEnumValueOf(String name) {
  switch (name) {
    case 'submitted':
      return _$bstocksWalletActionSubmissionStatusEnum_submitted;
    case 'confirmed':
      return _$bstocksWalletActionSubmissionStatusEnum_confirmed;
    case 'manualReview':
      return _$bstocksWalletActionSubmissionStatusEnum_manualReview;
    case 'unknownDefaultOpenApi':
      return _$bstocksWalletActionSubmissionStatusEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksWalletActionSubmissionStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksWalletActionSubmissionStatusEnum>
    _$bstocksWalletActionSubmissionStatusEnumValues = BuiltSet<
        BstocksWalletActionSubmissionStatusEnum>(const <BstocksWalletActionSubmissionStatusEnum>[
  _$bstocksWalletActionSubmissionStatusEnum_submitted,
  _$bstocksWalletActionSubmissionStatusEnum_confirmed,
  _$bstocksWalletActionSubmissionStatusEnum_manualReview,
  _$bstocksWalletActionSubmissionStatusEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksWalletActionSubmissionStatusEnum>
    _$bstocksWalletActionSubmissionStatusEnumSerializer =
    _$BstocksWalletActionSubmissionStatusEnumSerializer();

class _$BstocksWalletActionSubmissionStatusEnumSerializer
    implements PrimitiveSerializer<BstocksWalletActionSubmissionStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksWalletActionSubmissionStatusEnum
  ];
  @override
  final String wireName = 'BstocksWalletActionSubmissionStatusEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksWalletActionSubmissionStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksWalletActionSubmissionStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksWalletActionSubmissionStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksWalletActionSubmission extends BstocksWalletActionSubmission {
  @override
  final String orderId;
  @override
  final String actionId;
  @override
  final BstocksWalletActionSubmissionStatusEnum status;
  @override
  final String submittedTransactionHash;
  @override
  final DateTime updatedAt;

  factory _$BstocksWalletActionSubmission(
          [void Function(BstocksWalletActionSubmissionBuilder)? updates]) =>
      (BstocksWalletActionSubmissionBuilder()..update(updates))._build();

  _$BstocksWalletActionSubmission._(
      {required this.orderId,
      required this.actionId,
      required this.status,
      required this.submittedTransactionHash,
      required this.updatedAt})
      : super._();
  @override
  BstocksWalletActionSubmission rebuild(
          void Function(BstocksWalletActionSubmissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksWalletActionSubmissionBuilder toBuilder() =>
      BstocksWalletActionSubmissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksWalletActionSubmission &&
        orderId == other.orderId &&
        actionId == other.actionId &&
        status == other.status &&
        submittedTransactionHash == other.submittedTransactionHash &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, submittedTransactionHash.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksWalletActionSubmission')
          ..add('orderId', orderId)
          ..add('actionId', actionId)
          ..add('status', status)
          ..add('submittedTransactionHash', submittedTransactionHash)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class BstocksWalletActionSubmissionBuilder
    implements
        Builder<BstocksWalletActionSubmission,
            BstocksWalletActionSubmissionBuilder> {
  _$BstocksWalletActionSubmission? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  BstocksWalletActionSubmissionStatusEnum? _status;
  BstocksWalletActionSubmissionStatusEnum? get status => _$this._status;
  set status(BstocksWalletActionSubmissionStatusEnum? status) =>
      _$this._status = status;

  String? _submittedTransactionHash;
  String? get submittedTransactionHash => _$this._submittedTransactionHash;
  set submittedTransactionHash(String? submittedTransactionHash) =>
      _$this._submittedTransactionHash = submittedTransactionHash;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  BstocksWalletActionSubmissionBuilder() {
    BstocksWalletActionSubmission._defaults(this);
  }

  BstocksWalletActionSubmissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _actionId = $v.actionId;
      _status = $v.status;
      _submittedTransactionHash = $v.submittedTransactionHash;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksWalletActionSubmission other) {
    _$v = other as _$BstocksWalletActionSubmission;
  }

  @override
  void update(void Function(BstocksWalletActionSubmissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksWalletActionSubmission build() => _build();

  _$BstocksWalletActionSubmission _build() {
    final _$result = _$v ??
        _$BstocksWalletActionSubmission._(
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'BstocksWalletActionSubmission', 'orderId'),
          actionId: BuiltValueNullFieldError.checkNotNull(
              actionId, r'BstocksWalletActionSubmission', 'actionId'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'BstocksWalletActionSubmission', 'status'),
          submittedTransactionHash: BuiltValueNullFieldError.checkNotNull(
              submittedTransactionHash,
              r'BstocksWalletActionSubmission',
              'submittedTransactionHash'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'BstocksWalletActionSubmission', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
