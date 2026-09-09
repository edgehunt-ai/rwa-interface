// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_chain_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionChainObservationValueEnum
    _$walletActionChainObservationValueEnum_n0x0 =
    const WalletActionChainObservationValueEnum._('n0x0');
const WalletActionChainObservationValueEnum
    _$walletActionChainObservationValueEnum_unknownDefaultOpenApi =
    const WalletActionChainObservationValueEnum._('unknownDefaultOpenApi');

WalletActionChainObservationValueEnum
    _$walletActionChainObservationValueEnumValueOf(String name) {
  switch (name) {
    case 'n0x0':
      return _$walletActionChainObservationValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$walletActionChainObservationValueEnum_unknownDefaultOpenApi;
    default:
      return _$walletActionChainObservationValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionChainObservationValueEnum>
    _$walletActionChainObservationValueEnumValues = BuiltSet<
        WalletActionChainObservationValueEnum>(const <WalletActionChainObservationValueEnum>[
  _$walletActionChainObservationValueEnum_n0x0,
  _$walletActionChainObservationValueEnum_unknownDefaultOpenApi,
]);

Serializer<WalletActionChainObservationValueEnum>
    _$walletActionChainObservationValueEnumSerializer =
    _$WalletActionChainObservationValueEnumSerializer();

class _$WalletActionChainObservationValueEnumSerializer
    implements PrimitiveSerializer<WalletActionChainObservationValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    WalletActionChainObservationValueEnum
  ];
  @override
  final String wireName = 'WalletActionChainObservationValueEnum';

  @override
  Object serialize(
          Serializers serializers, WalletActionChainObservationValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionChainObservationValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionChainObservationValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WalletActionChainObservation extends WalletActionChainObservation {
  @override
  final String txHash;
  @override
  final String sender;
  @override
  final String recipient;
  @override
  final String payloadHash;
  @override
  final WalletActionChainObservationValueEnum value;
  @override
  final bool receiptSuccess;
  @override
  final bool canonical;
  @override
  final int blockNumber;
  @override
  final String blockHash;
  @override
  final int confirmations;
  @override
  final DateTime observedAt;

  factory _$WalletActionChainObservation(
          [void Function(WalletActionChainObservationBuilder)? updates]) =>
      (WalletActionChainObservationBuilder()..update(updates))._build();

  _$WalletActionChainObservation._(
      {required this.txHash,
      required this.sender,
      required this.recipient,
      required this.payloadHash,
      required this.value,
      required this.receiptSuccess,
      required this.canonical,
      required this.blockNumber,
      required this.blockHash,
      required this.confirmations,
      required this.observedAt})
      : super._();
  @override
  WalletActionChainObservation rebuild(
          void Function(WalletActionChainObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionChainObservationBuilder toBuilder() =>
      WalletActionChainObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionChainObservation &&
        txHash == other.txHash &&
        sender == other.sender &&
        recipient == other.recipient &&
        payloadHash == other.payloadHash &&
        value == other.value &&
        receiptSuccess == other.receiptSuccess &&
        canonical == other.canonical &&
        blockNumber == other.blockNumber &&
        blockHash == other.blockHash &&
        confirmations == other.confirmations &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, sender.hashCode);
    _$hash = $jc(_$hash, recipient.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, receiptSuccess.hashCode);
    _$hash = $jc(_$hash, canonical.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletActionChainObservation')
          ..add('txHash', txHash)
          ..add('sender', sender)
          ..add('recipient', recipient)
          ..add('payloadHash', payloadHash)
          ..add('value', value)
          ..add('receiptSuccess', receiptSuccess)
          ..add('canonical', canonical)
          ..add('blockNumber', blockNumber)
          ..add('blockHash', blockHash)
          ..add('confirmations', confirmations)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class WalletActionChainObservationBuilder
    implements
        Builder<WalletActionChainObservation,
            WalletActionChainObservationBuilder> {
  _$WalletActionChainObservation? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  String? _sender;
  String? get sender => _$this._sender;
  set sender(String? sender) => _$this._sender = sender;

  String? _recipient;
  String? get recipient => _$this._recipient;
  set recipient(String? recipient) => _$this._recipient = recipient;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  WalletActionChainObservationValueEnum? _value;
  WalletActionChainObservationValueEnum? get value => _$this._value;
  set value(WalletActionChainObservationValueEnum? value) =>
      _$this._value = value;

  bool? _receiptSuccess;
  bool? get receiptSuccess => _$this._receiptSuccess;
  set receiptSuccess(bool? receiptSuccess) =>
      _$this._receiptSuccess = receiptSuccess;

  bool? _canonical;
  bool? get canonical => _$this._canonical;
  set canonical(bool? canonical) => _$this._canonical = canonical;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(String? blockHash) => _$this._blockHash = blockHash;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  WalletActionChainObservationBuilder() {
    WalletActionChainObservation._defaults(this);
  }

  WalletActionChainObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _sender = $v.sender;
      _recipient = $v.recipient;
      _payloadHash = $v.payloadHash;
      _value = $v.value;
      _receiptSuccess = $v.receiptSuccess;
      _canonical = $v.canonical;
      _blockNumber = $v.blockNumber;
      _blockHash = $v.blockHash;
      _confirmations = $v.confirmations;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionChainObservation other) {
    _$v = other as _$WalletActionChainObservation;
  }

  @override
  void update(void Function(WalletActionChainObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionChainObservation build() => _build();

  _$WalletActionChainObservation _build() {
    final _$result = _$v ??
        _$WalletActionChainObservation._(
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'WalletActionChainObservation', 'txHash'),
          sender: BuiltValueNullFieldError.checkNotNull(
              sender, r'WalletActionChainObservation', 'sender'),
          recipient: BuiltValueNullFieldError.checkNotNull(
              recipient, r'WalletActionChainObservation', 'recipient'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(
              payloadHash, r'WalletActionChainObservation', 'payloadHash'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'WalletActionChainObservation', 'value'),
          receiptSuccess: BuiltValueNullFieldError.checkNotNull(receiptSuccess,
              r'WalletActionChainObservation', 'receiptSuccess'),
          canonical: BuiltValueNullFieldError.checkNotNull(
              canonical, r'WalletActionChainObservation', 'canonical'),
          blockNumber: BuiltValueNullFieldError.checkNotNull(
              blockNumber, r'WalletActionChainObservation', 'blockNumber'),
          blockHash: BuiltValueNullFieldError.checkNotNull(
              blockHash, r'WalletActionChainObservation', 'blockHash'),
          confirmations: BuiltValueNullFieldError.checkNotNull(
              confirmations, r'WalletActionChainObservation', 'confirmations'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'WalletActionChainObservation', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
