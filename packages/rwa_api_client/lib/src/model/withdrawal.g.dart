// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WithdrawalAssetEnum _$withdrawalAssetEnum_USDC =
    const WithdrawalAssetEnum._('USDC');
const WithdrawalAssetEnum _$withdrawalAssetEnum_unknownDefaultOpenApi =
    const WithdrawalAssetEnum._('unknownDefaultOpenApi');

WithdrawalAssetEnum _$withdrawalAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$withdrawalAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$withdrawalAssetEnum_unknownDefaultOpenApi;
    default:
      return _$withdrawalAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WithdrawalAssetEnum> _$withdrawalAssetEnumValues =
    BuiltSet<WithdrawalAssetEnum>(const <WithdrawalAssetEnum>[
  _$withdrawalAssetEnum_USDC,
  _$withdrawalAssetEnum_unknownDefaultOpenApi,
]);

Serializer<WithdrawalAssetEnum> _$withdrawalAssetEnumSerializer =
    _$WithdrawalAssetEnumSerializer();

class _$WithdrawalAssetEnumSerializer
    implements PrimitiveSerializer<WithdrawalAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WithdrawalAssetEnum];
  @override
  final String wireName = 'WithdrawalAssetEnum';

  @override
  Object serialize(Serializers serializers, WithdrawalAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WithdrawalAssetEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WithdrawalAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Withdrawal extends Withdrawal {
  @override
  final String withdrawalId;
  @override
  final WithdrawalAssetEnum asset;
  @override
  final Chain chain;
  @override
  final String amount;
  @override
  final String? receivedAmount;
  @override
  final String? totalFee;
  @override
  final String? address;
  @override
  final String? memo;
  @override
  final WithdrawalStatus status;
  @override
  final String? failureReason;
  @override
  final String? txHash;
  @override
  final String? activityId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  factory _$Withdrawal([void Function(WithdrawalBuilder)? updates]) =>
      (WithdrawalBuilder()..update(updates))._build();

  _$Withdrawal._(
      {required this.withdrawalId,
      required this.asset,
      required this.chain,
      required this.amount,
      this.receivedAmount,
      this.totalFee,
      this.address,
      this.memo,
      required this.status,
      this.failureReason,
      this.txHash,
      this.activityId,
      this.createdAt,
      this.completedAt})
      : super._();
  @override
  Withdrawal rebuild(void Function(WithdrawalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalBuilder toBuilder() => WithdrawalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Withdrawal &&
        withdrawalId == other.withdrawalId &&
        asset == other.asset &&
        chain == other.chain &&
        amount == other.amount &&
        receivedAmount == other.receivedAmount &&
        totalFee == other.totalFee &&
        address == other.address &&
        memo == other.memo &&
        status == other.status &&
        failureReason == other.failureReason &&
        txHash == other.txHash &&
        activityId == other.activityId &&
        createdAt == other.createdAt &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, withdrawalId.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, receivedAmount.hashCode);
    _$hash = $jc(_$hash, totalFee.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Withdrawal')
          ..add('withdrawalId', withdrawalId)
          ..add('asset', asset)
          ..add('chain', chain)
          ..add('amount', amount)
          ..add('receivedAmount', receivedAmount)
          ..add('totalFee', totalFee)
          ..add('address', address)
          ..add('memo', memo)
          ..add('status', status)
          ..add('failureReason', failureReason)
          ..add('txHash', txHash)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class WithdrawalBuilder implements Builder<Withdrawal, WithdrawalBuilder> {
  _$Withdrawal? _$v;

  String? _withdrawalId;
  String? get withdrawalId => _$this._withdrawalId;
  set withdrawalId(String? withdrawalId) => _$this._withdrawalId = withdrawalId;

  WithdrawalAssetEnum? _asset;
  WithdrawalAssetEnum? get asset => _$this._asset;
  set asset(WithdrawalAssetEnum? asset) => _$this._asset = asset;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _receivedAmount;
  String? get receivedAmount => _$this._receivedAmount;
  set receivedAmount(String? receivedAmount) =>
      _$this._receivedAmount = receivedAmount;

  String? _totalFee;
  String? get totalFee => _$this._totalFee;
  set totalFee(String? totalFee) => _$this._totalFee = totalFee;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  WithdrawalStatus? _status;
  WithdrawalStatus? get status => _$this._status;
  set status(WithdrawalStatus? status) => _$this._status = status;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  WithdrawalBuilder() {
    Withdrawal._defaults(this);
  }

  WithdrawalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _withdrawalId = $v.withdrawalId;
      _asset = $v.asset;
      _chain = $v.chain;
      _amount = $v.amount;
      _receivedAmount = $v.receivedAmount;
      _totalFee = $v.totalFee;
      _address = $v.address;
      _memo = $v.memo;
      _status = $v.status;
      _failureReason = $v.failureReason;
      _txHash = $v.txHash;
      _activityId = $v.activityId;
      _createdAt = $v.createdAt;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Withdrawal other) {
    _$v = other as _$Withdrawal;
  }

  @override
  void update(void Function(WithdrawalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Withdrawal build() => _build();

  _$Withdrawal _build() {
    final _$result = _$v ??
        _$Withdrawal._(
          withdrawalId: BuiltValueNullFieldError.checkNotNull(
              withdrawalId, r'Withdrawal', 'withdrawalId'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'Withdrawal', 'asset'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'Withdrawal', 'chain'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Withdrawal', 'amount'),
          receivedAmount: receivedAmount,
          totalFee: totalFee,
          address: address,
          memo: memo,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Withdrawal', 'status'),
          failureReason: failureReason,
          txHash: txHash,
          activityId: activityId,
          createdAt: createdAt,
          completedAt: completedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
