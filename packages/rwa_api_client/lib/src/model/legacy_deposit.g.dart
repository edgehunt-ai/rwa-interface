// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_deposit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyDepositTokenEnum _$legacyDepositTokenEnum_USDC =
    const LegacyDepositTokenEnum._('USDC');
const LegacyDepositTokenEnum _$legacyDepositTokenEnum_unknownDefaultOpenApi =
    const LegacyDepositTokenEnum._('unknownDefaultOpenApi');

LegacyDepositTokenEnum _$legacyDepositTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$legacyDepositTokenEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$legacyDepositTokenEnum_unknownDefaultOpenApi;
    default:
      return _$legacyDepositTokenEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyDepositTokenEnum> _$legacyDepositTokenEnumValues =
    BuiltSet<LegacyDepositTokenEnum>(const <LegacyDepositTokenEnum>[
  _$legacyDepositTokenEnum_USDC,
  _$legacyDepositTokenEnum_unknownDefaultOpenApi,
]);

Serializer<LegacyDepositTokenEnum> _$legacyDepositTokenEnumSerializer =
    _$LegacyDepositTokenEnumSerializer();

class _$LegacyDepositTokenEnumSerializer
    implements PrimitiveSerializer<LegacyDepositTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyDepositTokenEnum];
  @override
  final String wireName = 'LegacyDepositTokenEnum';

  @override
  Object serialize(Serializers serializers, LegacyDepositTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyDepositTokenEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyDepositTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyDeposit extends LegacyDeposit {
  @override
  final String depositId;
  @override
  final Chain chain;
  @override
  final LegacyDepositTokenEnum token;
  @override
  final String? amount;
  @override
  final LegacyDepositStatus status;
  @override
  final int? confirmations;
  @override
  final int? confirmationsRequired;
  @override
  final AccountKind? creditedTo;
  @override
  final bool? requiresTransfer;
  @override
  final String? txHash;
  @override
  final String? activityId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? creditedAt;
  @override
  final DepositAddress instructions;

  factory _$LegacyDeposit([void Function(LegacyDepositBuilder)? updates]) =>
      (LegacyDepositBuilder()..update(updates))._build();

  _$LegacyDeposit._(
      {required this.depositId,
      required this.chain,
      required this.token,
      this.amount,
      required this.status,
      this.confirmations,
      this.confirmationsRequired,
      this.creditedTo,
      this.requiresTransfer,
      this.txHash,
      this.activityId,
      this.createdAt,
      this.creditedAt,
      required this.instructions})
      : super._();
  @override
  LegacyDeposit rebuild(void Function(LegacyDepositBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyDepositBuilder toBuilder() => LegacyDepositBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyDeposit &&
        depositId == other.depositId &&
        chain == other.chain &&
        token == other.token &&
        amount == other.amount &&
        status == other.status &&
        confirmations == other.confirmations &&
        confirmationsRequired == other.confirmationsRequired &&
        creditedTo == other.creditedTo &&
        requiresTransfer == other.requiresTransfer &&
        txHash == other.txHash &&
        activityId == other.activityId &&
        createdAt == other.createdAt &&
        creditedAt == other.creditedAt &&
        instructions == other.instructions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, depositId.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, requiresTransfer.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, creditedAt.hashCode);
    _$hash = $jc(_$hash, instructions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LegacyDeposit')
          ..add('depositId', depositId)
          ..add('chain', chain)
          ..add('token', token)
          ..add('amount', amount)
          ..add('status', status)
          ..add('confirmations', confirmations)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('creditedTo', creditedTo)
          ..add('requiresTransfer', requiresTransfer)
          ..add('txHash', txHash)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('creditedAt', creditedAt)
          ..add('instructions', instructions))
        .toString();
  }
}

class LegacyDepositBuilder
    implements Builder<LegacyDeposit, LegacyDepositBuilder> {
  _$LegacyDeposit? _$v;

  String? _depositId;
  String? get depositId => _$this._depositId;
  set depositId(String? depositId) => _$this._depositId = depositId;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  LegacyDepositTokenEnum? _token;
  LegacyDepositTokenEnum? get token => _$this._token;
  set token(LegacyDepositTokenEnum? token) => _$this._token = token;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  LegacyDepositStatus? _status;
  LegacyDepositStatus? get status => _$this._status;
  set status(LegacyDepositStatus? status) => _$this._status = status;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  AccountKind? _creditedTo;
  AccountKind? get creditedTo => _$this._creditedTo;
  set creditedTo(AccountKind? creditedTo) => _$this._creditedTo = creditedTo;

  bool? _requiresTransfer;
  bool? get requiresTransfer => _$this._requiresTransfer;
  set requiresTransfer(bool? requiresTransfer) =>
      _$this._requiresTransfer = requiresTransfer;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _creditedAt;
  DateTime? get creditedAt => _$this._creditedAt;
  set creditedAt(DateTime? creditedAt) => _$this._creditedAt = creditedAt;

  DepositAddressBuilder? _instructions;
  DepositAddressBuilder get instructions =>
      _$this._instructions ??= DepositAddressBuilder();
  set instructions(DepositAddressBuilder? instructions) =>
      _$this._instructions = instructions;

  LegacyDepositBuilder() {
    LegacyDeposit._defaults(this);
  }

  LegacyDepositBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _depositId = $v.depositId;
      _chain = $v.chain;
      _token = $v.token;
      _amount = $v.amount;
      _status = $v.status;
      _confirmations = $v.confirmations;
      _confirmationsRequired = $v.confirmationsRequired;
      _creditedTo = $v.creditedTo;
      _requiresTransfer = $v.requiresTransfer;
      _txHash = $v.txHash;
      _activityId = $v.activityId;
      _createdAt = $v.createdAt;
      _creditedAt = $v.creditedAt;
      _instructions = $v.instructions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LegacyDeposit other) {
    _$v = other as _$LegacyDeposit;
  }

  @override
  void update(void Function(LegacyDepositBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyDeposit build() => _build();

  _$LegacyDeposit _build() {
    _$LegacyDeposit _$result;
    try {
      _$result = _$v ??
          _$LegacyDeposit._(
            depositId: BuiltValueNullFieldError.checkNotNull(
                depositId, r'LegacyDeposit', 'depositId'),
            chain: BuiltValueNullFieldError.checkNotNull(
                chain, r'LegacyDeposit', 'chain'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'LegacyDeposit', 'token'),
            amount: amount,
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'LegacyDeposit', 'status'),
            confirmations: confirmations,
            confirmationsRequired: confirmationsRequired,
            creditedTo: creditedTo,
            requiresTransfer: requiresTransfer,
            txHash: txHash,
            activityId: activityId,
            createdAt: createdAt,
            creditedAt: creditedAt,
            instructions: instructions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'instructions';
        instructions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LegacyDeposit', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
