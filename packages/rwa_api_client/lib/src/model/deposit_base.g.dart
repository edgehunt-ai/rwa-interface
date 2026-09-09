// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_base.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositBaseTokenEnum _$depositBaseTokenEnum_USDC =
    const DepositBaseTokenEnum._('USDC');
const DepositBaseTokenEnum _$depositBaseTokenEnum_unknownDefaultOpenApi =
    const DepositBaseTokenEnum._('unknownDefaultOpenApi');

DepositBaseTokenEnum _$depositBaseTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$depositBaseTokenEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$depositBaseTokenEnum_unknownDefaultOpenApi;
    default:
      return _$depositBaseTokenEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositBaseTokenEnum> _$depositBaseTokenEnumValues =
    BuiltSet<DepositBaseTokenEnum>(const <DepositBaseTokenEnum>[
  _$depositBaseTokenEnum_USDC,
  _$depositBaseTokenEnum_unknownDefaultOpenApi,
]);

Serializer<DepositBaseTokenEnum> _$depositBaseTokenEnumSerializer =
    _$DepositBaseTokenEnumSerializer();

class _$DepositBaseTokenEnumSerializer
    implements PrimitiveSerializer<DepositBaseTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositBaseTokenEnum];
  @override
  final String wireName = 'DepositBaseTokenEnum';

  @override
  Object serialize(Serializers serializers, DepositBaseTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositBaseTokenEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositBaseTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class DepositBaseBuilder {
  void replace(DepositBase other);
  void update(void Function(DepositBaseBuilder) updates);
  String? get depositId;
  set depositId(String? depositId);

  String? get chain;
  set chain(String? chain);

  int? get chainId;
  set chainId(int? chainId);

  DepositBaseTokenEnum? get token;
  set token(DepositBaseTokenEnum? token);

  String? get tokenContract;
  set tokenContract(String? tokenContract);

  int? get tokenDecimals;
  set tokenDecimals(int? tokenDecimals);

  String? get amount;
  set amount(String? amount);

  String? get amountRaw;
  set amountRaw(String? amountRaw);

  DepositStatus? get status;
  set status(DepositStatus? status);

  int? get confirmations;
  set confirmations(int? confirmations);

  int? get confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired);

  String? get txHash;
  set txHash(String? txHash);

  int? get logIndex;
  set logIndex(int? logIndex);

  int? get blockNumber;
  set blockNumber(int? blockNumber);

  String? get blockHash;
  set blockHash(String? blockHash);

  String? get sender;
  set sender(String? sender);

  String? get recipient;
  set recipient(String? recipient);

  DateTime? get detectedAt;
  set detectedAt(DateTime? detectedAt);

  DateTime? get confirmedAt;
  set confirmedAt(DateTime? confirmedAt);

  DateTime? get updatedAt;
  set updatedAt(DateTime? updatedAt);
}

class _$$DepositBase extends $DepositBase {
  @override
  final String depositId;
  @override
  final String chain;
  @override
  final int chainId;
  @override
  final DepositBaseTokenEnum token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final String amount;
  @override
  final String amountRaw;
  @override
  final DepositStatus status;
  @override
  final int confirmations;
  @override
  final int confirmationsRequired;
  @override
  final String txHash;
  @override
  final int logIndex;
  @override
  final int blockNumber;
  @override
  final String blockHash;
  @override
  final String sender;
  @override
  final String recipient;
  @override
  final DateTime detectedAt;
  @override
  final DateTime confirmedAt;
  @override
  final DateTime updatedAt;

  factory _$$DepositBase([void Function($DepositBaseBuilder)? updates]) =>
      ($DepositBaseBuilder()..update(updates))._build();

  _$$DepositBase._(
      {required this.depositId,
      required this.chain,
      required this.chainId,
      required this.token,
      required this.tokenContract,
      required this.tokenDecimals,
      required this.amount,
      required this.amountRaw,
      required this.status,
      required this.confirmations,
      required this.confirmationsRequired,
      required this.txHash,
      required this.logIndex,
      required this.blockNumber,
      required this.blockHash,
      required this.sender,
      required this.recipient,
      required this.detectedAt,
      required this.confirmedAt,
      required this.updatedAt})
      : super._();
  @override
  $DepositBase rebuild(void Function($DepositBaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $DepositBaseBuilder toBuilder() => $DepositBaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $DepositBase &&
        depositId == other.depositId &&
        chain == other.chain &&
        chainId == other.chainId &&
        token == other.token &&
        tokenContract == other.tokenContract &&
        tokenDecimals == other.tokenDecimals &&
        amount == other.amount &&
        amountRaw == other.amountRaw &&
        status == other.status &&
        confirmations == other.confirmations &&
        confirmationsRequired == other.confirmationsRequired &&
        txHash == other.txHash &&
        logIndex == other.logIndex &&
        blockNumber == other.blockNumber &&
        blockHash == other.blockHash &&
        sender == other.sender &&
        recipient == other.recipient &&
        detectedAt == other.detectedAt &&
        confirmedAt == other.confirmedAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, depositId.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, tokenDecimals.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, amountRaw.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, logIndex.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, sender.hashCode);
    _$hash = $jc(_$hash, recipient.hashCode);
    _$hash = $jc(_$hash, detectedAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$DepositBase')
          ..add('depositId', depositId)
          ..add('chain', chain)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('amount', amount)
          ..add('amountRaw', amountRaw)
          ..add('status', status)
          ..add('confirmations', confirmations)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('txHash', txHash)
          ..add('logIndex', logIndex)
          ..add('blockNumber', blockNumber)
          ..add('blockHash', blockHash)
          ..add('sender', sender)
          ..add('recipient', recipient)
          ..add('detectedAt', detectedAt)
          ..add('confirmedAt', confirmedAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class $DepositBaseBuilder
    implements Builder<$DepositBase, $DepositBaseBuilder>, DepositBaseBuilder {
  _$$DepositBase? _$v;

  String? _depositId;
  String? get depositId => _$this._depositId;
  set depositId(covariant String? depositId) => _$this._depositId = depositId;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(covariant String? chain) => _$this._chain = chain;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(covariant int? chainId) => _$this._chainId = chainId;

  DepositBaseTokenEnum? _token;
  DepositBaseTokenEnum? get token => _$this._token;
  set token(covariant DepositBaseTokenEnum? token) => _$this._token = token;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(covariant String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _tokenDecimals;
  int? get tokenDecimals => _$this._tokenDecimals;
  set tokenDecimals(covariant int? tokenDecimals) =>
      _$this._tokenDecimals = tokenDecimals;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(covariant String? amount) => _$this._amount = amount;

  String? _amountRaw;
  String? get amountRaw => _$this._amountRaw;
  set amountRaw(covariant String? amountRaw) => _$this._amountRaw = amountRaw;

  DepositStatus? _status;
  DepositStatus? get status => _$this._status;
  set status(covariant DepositStatus? status) => _$this._status = status;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(covariant int? confirmations) =>
      _$this._confirmations = confirmations;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(covariant int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(covariant String? txHash) => _$this._txHash = txHash;

  int? _logIndex;
  int? get logIndex => _$this._logIndex;
  set logIndex(covariant int? logIndex) => _$this._logIndex = logIndex;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(covariant int? blockNumber) =>
      _$this._blockNumber = blockNumber;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(covariant String? blockHash) => _$this._blockHash = blockHash;

  String? _sender;
  String? get sender => _$this._sender;
  set sender(covariant String? sender) => _$this._sender = sender;

  String? _recipient;
  String? get recipient => _$this._recipient;
  set recipient(covariant String? recipient) => _$this._recipient = recipient;

  DateTime? _detectedAt;
  DateTime? get detectedAt => _$this._detectedAt;
  set detectedAt(covariant DateTime? detectedAt) =>
      _$this._detectedAt = detectedAt;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(covariant DateTime? confirmedAt) =>
      _$this._confirmedAt = confirmedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  $DepositBaseBuilder() {
    $DepositBase._defaults(this);
  }

  $DepositBaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _depositId = $v.depositId;
      _chain = $v.chain;
      _chainId = $v.chainId;
      _token = $v.token;
      _tokenContract = $v.tokenContract;
      _tokenDecimals = $v.tokenDecimals;
      _amount = $v.amount;
      _amountRaw = $v.amountRaw;
      _status = $v.status;
      _confirmations = $v.confirmations;
      _confirmationsRequired = $v.confirmationsRequired;
      _txHash = $v.txHash;
      _logIndex = $v.logIndex;
      _blockNumber = $v.blockNumber;
      _blockHash = $v.blockHash;
      _sender = $v.sender;
      _recipient = $v.recipient;
      _detectedAt = $v.detectedAt;
      _confirmedAt = $v.confirmedAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $DepositBase other) {
    _$v = other as _$$DepositBase;
  }

  @override
  void update(void Function($DepositBaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $DepositBase build() => _build();

  _$$DepositBase _build() {
    final _$result = _$v ??
        _$$DepositBase._(
          depositId: BuiltValueNullFieldError.checkNotNull(
              depositId, r'$DepositBase', 'depositId'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'$DepositBase', 'chain'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'$DepositBase', 'chainId'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'$DepositBase', 'token'),
          tokenContract: BuiltValueNullFieldError.checkNotNull(
              tokenContract, r'$DepositBase', 'tokenContract'),
          tokenDecimals: BuiltValueNullFieldError.checkNotNull(
              tokenDecimals, r'$DepositBase', 'tokenDecimals'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'$DepositBase', 'amount'),
          amountRaw: BuiltValueNullFieldError.checkNotNull(
              amountRaw, r'$DepositBase', 'amountRaw'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'$DepositBase', 'status'),
          confirmations: BuiltValueNullFieldError.checkNotNull(
              confirmations, r'$DepositBase', 'confirmations'),
          confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
              confirmationsRequired, r'$DepositBase', 'confirmationsRequired'),
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'$DepositBase', 'txHash'),
          logIndex: BuiltValueNullFieldError.checkNotNull(
              logIndex, r'$DepositBase', 'logIndex'),
          blockNumber: BuiltValueNullFieldError.checkNotNull(
              blockNumber, r'$DepositBase', 'blockNumber'),
          blockHash: BuiltValueNullFieldError.checkNotNull(
              blockHash, r'$DepositBase', 'blockHash'),
          sender: BuiltValueNullFieldError.checkNotNull(
              sender, r'$DepositBase', 'sender'),
          recipient: BuiltValueNullFieldError.checkNotNull(
              recipient, r'$DepositBase', 'recipient'),
          detectedAt: BuiltValueNullFieldError.checkNotNull(
              detectedAt, r'$DepositBase', 'detectedAt'),
          confirmedAt: BuiltValueNullFieldError.checkNotNull(
              confirmedAt, r'$DepositBase', 'confirmedAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'$DepositBase', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
