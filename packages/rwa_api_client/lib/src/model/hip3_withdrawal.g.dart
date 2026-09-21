// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalHyperliquidChainEnum
    _$hip3WithdrawalHyperliquidChainEnum_testnet =
    const Hip3WithdrawalHyperliquidChainEnum._('testnet');
const Hip3WithdrawalHyperliquidChainEnum
    _$hip3WithdrawalHyperliquidChainEnum_mainnet =
    const Hip3WithdrawalHyperliquidChainEnum._('mainnet');
const Hip3WithdrawalHyperliquidChainEnum
    _$hip3WithdrawalHyperliquidChainEnum_unknownDefaultOpenApi =
    const Hip3WithdrawalHyperliquidChainEnum._('unknownDefaultOpenApi');

Hip3WithdrawalHyperliquidChainEnum _$hip3WithdrawalHyperliquidChainEnumValueOf(
    String name) {
  switch (name) {
    case 'testnet':
      return _$hip3WithdrawalHyperliquidChainEnum_testnet;
    case 'mainnet':
      return _$hip3WithdrawalHyperliquidChainEnum_mainnet;
    case 'unknownDefaultOpenApi':
      return _$hip3WithdrawalHyperliquidChainEnum_unknownDefaultOpenApi;
    default:
      return _$hip3WithdrawalHyperliquidChainEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3WithdrawalHyperliquidChainEnum>
    _$hip3WithdrawalHyperliquidChainEnumValues = BuiltSet<
        Hip3WithdrawalHyperliquidChainEnum>(const <Hip3WithdrawalHyperliquidChainEnum>[
  _$hip3WithdrawalHyperliquidChainEnum_testnet,
  _$hip3WithdrawalHyperliquidChainEnum_mainnet,
  _$hip3WithdrawalHyperliquidChainEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3WithdrawalHyperliquidChainEnum>
    _$hip3WithdrawalHyperliquidChainEnumSerializer =
    _$Hip3WithdrawalHyperliquidChainEnumSerializer();

class _$Hip3WithdrawalHyperliquidChainEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalHyperliquidChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'testnet': 'Testnet',
    'mainnet': 'Mainnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Testnet': 'testnet',
    'Mainnet': 'mainnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalHyperliquidChainEnum];
  @override
  final String wireName = 'Hip3WithdrawalHyperliquidChainEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalHyperliquidChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalHyperliquidChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalHyperliquidChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Withdrawal extends Hip3Withdrawal {
  @override
  final String withdrawalId;
  @override
  final String ownerAddress;
  @override
  final String destinationAddress;
  @override
  final String amount;
  @override
  final String fee;
  @override
  final String minimumReceived;
  @override
  final Hip3WithdrawalStatus status;
  @override
  final Hip3WithdrawalRail rail;
  @override
  final int nonce;
  @override
  final Hip3WithdrawalHyperliquidChainEnum? hyperliquidChain;
  @override
  final String? chainId;
  @override
  final String? amountText;
  @override
  final String? typedDataJson;
  @override
  final String? payloadHash;
  @override
  final String? failureReason;
  @override
  final int? observedLedgerTime;
  @override
  final String? payoutTxHash;
  @override
  final DateTime expiresAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? confirmedAt;

  factory _$Hip3Withdrawal([void Function(Hip3WithdrawalBuilder)? updates]) =>
      (Hip3WithdrawalBuilder()..update(updates))._build();

  _$Hip3Withdrawal._(
      {required this.withdrawalId,
      required this.ownerAddress,
      required this.destinationAddress,
      required this.amount,
      required this.fee,
      required this.minimumReceived,
      required this.status,
      required this.rail,
      required this.nonce,
      this.hyperliquidChain,
      this.chainId,
      this.amountText,
      this.typedDataJson,
      this.payloadHash,
      this.failureReason,
      this.observedLedgerTime,
      this.payoutTxHash,
      required this.expiresAt,
      required this.createdAt,
      required this.updatedAt,
      this.submittedAt,
      this.confirmedAt})
      : super._();
  @override
  Hip3Withdrawal rebuild(void Function(Hip3WithdrawalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalBuilder toBuilder() => Hip3WithdrawalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Withdrawal &&
        withdrawalId == other.withdrawalId &&
        ownerAddress == other.ownerAddress &&
        destinationAddress == other.destinationAddress &&
        amount == other.amount &&
        fee == other.fee &&
        minimumReceived == other.minimumReceived &&
        status == other.status &&
        rail == other.rail &&
        nonce == other.nonce &&
        hyperliquidChain == other.hyperliquidChain &&
        chainId == other.chainId &&
        amountText == other.amountText &&
        typedDataJson == other.typedDataJson &&
        payloadHash == other.payloadHash &&
        failureReason == other.failureReason &&
        observedLedgerTime == other.observedLedgerTime &&
        payoutTxHash == other.payoutTxHash &&
        expiresAt == other.expiresAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        submittedAt == other.submittedAt &&
        confirmedAt == other.confirmedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, withdrawalId.hashCode);
    _$hash = $jc(_$hash, ownerAddress.hashCode);
    _$hash = $jc(_$hash, destinationAddress.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, minimumReceived.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, hyperliquidChain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, amountText.hashCode);
    _$hash = $jc(_$hash, typedDataJson.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, observedLedgerTime.hashCode);
    _$hash = $jc(_$hash, payoutTxHash.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Withdrawal')
          ..add('withdrawalId', withdrawalId)
          ..add('ownerAddress', ownerAddress)
          ..add('destinationAddress', destinationAddress)
          ..add('amount', amount)
          ..add('fee', fee)
          ..add('minimumReceived', minimumReceived)
          ..add('status', status)
          ..add('rail', rail)
          ..add('nonce', nonce)
          ..add('hyperliquidChain', hyperliquidChain)
          ..add('chainId', chainId)
          ..add('amountText', amountText)
          ..add('typedDataJson', typedDataJson)
          ..add('payloadHash', payloadHash)
          ..add('failureReason', failureReason)
          ..add('observedLedgerTime', observedLedgerTime)
          ..add('payoutTxHash', payoutTxHash)
          ..add('expiresAt', expiresAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('submittedAt', submittedAt)
          ..add('confirmedAt', confirmedAt))
        .toString();
  }
}

class Hip3WithdrawalBuilder
    implements Builder<Hip3Withdrawal, Hip3WithdrawalBuilder> {
  _$Hip3Withdrawal? _$v;

  String? _withdrawalId;
  String? get withdrawalId => _$this._withdrawalId;
  set withdrawalId(String? withdrawalId) => _$this._withdrawalId = withdrawalId;

  String? _ownerAddress;
  String? get ownerAddress => _$this._ownerAddress;
  set ownerAddress(String? ownerAddress) => _$this._ownerAddress = ownerAddress;

  String? _destinationAddress;
  String? get destinationAddress => _$this._destinationAddress;
  set destinationAddress(String? destinationAddress) =>
      _$this._destinationAddress = destinationAddress;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  String? _minimumReceived;
  String? get minimumReceived => _$this._minimumReceived;
  set minimumReceived(String? minimumReceived) =>
      _$this._minimumReceived = minimumReceived;

  Hip3WithdrawalStatus? _status;
  Hip3WithdrawalStatus? get status => _$this._status;
  set status(Hip3WithdrawalStatus? status) => _$this._status = status;

  Hip3WithdrawalRail? _rail;
  Hip3WithdrawalRail? get rail => _$this._rail;
  set rail(Hip3WithdrawalRail? rail) => _$this._rail = rail;

  int? _nonce;
  int? get nonce => _$this._nonce;
  set nonce(int? nonce) => _$this._nonce = nonce;

  Hip3WithdrawalHyperliquidChainEnum? _hyperliquidChain;
  Hip3WithdrawalHyperliquidChainEnum? get hyperliquidChain =>
      _$this._hyperliquidChain;
  set hyperliquidChain(Hip3WithdrawalHyperliquidChainEnum? hyperliquidChain) =>
      _$this._hyperliquidChain = hyperliquidChain;

  String? _chainId;
  String? get chainId => _$this._chainId;
  set chainId(String? chainId) => _$this._chainId = chainId;

  String? _amountText;
  String? get amountText => _$this._amountText;
  set amountText(String? amountText) => _$this._amountText = amountText;

  String? _typedDataJson;
  String? get typedDataJson => _$this._typedDataJson;
  set typedDataJson(String? typedDataJson) =>
      _$this._typedDataJson = typedDataJson;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  int? _observedLedgerTime;
  int? get observedLedgerTime => _$this._observedLedgerTime;
  set observedLedgerTime(int? observedLedgerTime) =>
      _$this._observedLedgerTime = observedLedgerTime;

  String? _payoutTxHash;
  String? get payoutTxHash => _$this._payoutTxHash;
  set payoutTxHash(String? payoutTxHash) => _$this._payoutTxHash = payoutTxHash;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(DateTime? confirmedAt) => _$this._confirmedAt = confirmedAt;

  Hip3WithdrawalBuilder() {
    Hip3Withdrawal._defaults(this);
  }

  Hip3WithdrawalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _withdrawalId = $v.withdrawalId;
      _ownerAddress = $v.ownerAddress;
      _destinationAddress = $v.destinationAddress;
      _amount = $v.amount;
      _fee = $v.fee;
      _minimumReceived = $v.minimumReceived;
      _status = $v.status;
      _rail = $v.rail;
      _nonce = $v.nonce;
      _hyperliquidChain = $v.hyperliquidChain;
      _chainId = $v.chainId;
      _amountText = $v.amountText;
      _typedDataJson = $v.typedDataJson;
      _payloadHash = $v.payloadHash;
      _failureReason = $v.failureReason;
      _observedLedgerTime = $v.observedLedgerTime;
      _payoutTxHash = $v.payoutTxHash;
      _expiresAt = $v.expiresAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _submittedAt = $v.submittedAt;
      _confirmedAt = $v.confirmedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Withdrawal other) {
    _$v = other as _$Hip3Withdrawal;
  }

  @override
  void update(void Function(Hip3WithdrawalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Withdrawal build() => _build();

  _$Hip3Withdrawal _build() {
    final _$result = _$v ??
        _$Hip3Withdrawal._(
          withdrawalId: BuiltValueNullFieldError.checkNotNull(
              withdrawalId, r'Hip3Withdrawal', 'withdrawalId'),
          ownerAddress: BuiltValueNullFieldError.checkNotNull(
              ownerAddress, r'Hip3Withdrawal', 'ownerAddress'),
          destinationAddress: BuiltValueNullFieldError.checkNotNull(
              destinationAddress, r'Hip3Withdrawal', 'destinationAddress'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Hip3Withdrawal', 'amount'),
          fee: BuiltValueNullFieldError.checkNotNull(
              fee, r'Hip3Withdrawal', 'fee'),
          minimumReceived: BuiltValueNullFieldError.checkNotNull(
              minimumReceived, r'Hip3Withdrawal', 'minimumReceived'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Hip3Withdrawal', 'status'),
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'Hip3Withdrawal', 'rail'),
          nonce: BuiltValueNullFieldError.checkNotNull(
              nonce, r'Hip3Withdrawal', 'nonce'),
          hyperliquidChain: hyperliquidChain,
          chainId: chainId,
          amountText: amountText,
          typedDataJson: typedDataJson,
          payloadHash: payloadHash,
          failureReason: failureReason,
          observedLedgerTime: observedLedgerTime,
          payoutTxHash: payoutTxHash,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Hip3Withdrawal', 'expiresAt'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Hip3Withdrawal', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Hip3Withdrawal', 'updatedAt'),
          submittedAt: submittedAt,
          confirmedAt: confirmedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
