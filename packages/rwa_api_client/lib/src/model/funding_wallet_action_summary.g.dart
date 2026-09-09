// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_wallet_action_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingWalletActionSummaryKindEnum
    _$fundingWalletActionSummaryKindEnum_erc20Approval =
    const FundingWalletActionSummaryKindEnum._('erc20Approval');
const FundingWalletActionSummaryKindEnum
    _$fundingWalletActionSummaryKindEnum_originTransaction =
    const FundingWalletActionSummaryKindEnum._('originTransaction');
const FundingWalletActionSummaryKindEnum
    _$fundingWalletActionSummaryKindEnum_unknownDefaultOpenApi =
    const FundingWalletActionSummaryKindEnum._('unknownDefaultOpenApi');

FundingWalletActionSummaryKindEnum _$fundingWalletActionSummaryKindEnumValueOf(
    String name) {
  switch (name) {
    case 'erc20Approval':
      return _$fundingWalletActionSummaryKindEnum_erc20Approval;
    case 'originTransaction':
      return _$fundingWalletActionSummaryKindEnum_originTransaction;
    case 'unknownDefaultOpenApi':
      return _$fundingWalletActionSummaryKindEnum_unknownDefaultOpenApi;
    default:
      return _$fundingWalletActionSummaryKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingWalletActionSummaryKindEnum>
    _$fundingWalletActionSummaryKindEnumValues = BuiltSet<
        FundingWalletActionSummaryKindEnum>(const <FundingWalletActionSummaryKindEnum>[
  _$fundingWalletActionSummaryKindEnum_erc20Approval,
  _$fundingWalletActionSummaryKindEnum_originTransaction,
  _$fundingWalletActionSummaryKindEnum_unknownDefaultOpenApi,
]);

Serializer<FundingWalletActionSummaryKindEnum>
    _$fundingWalletActionSummaryKindEnumSerializer =
    _$FundingWalletActionSummaryKindEnumSerializer();

class _$FundingWalletActionSummaryKindEnumSerializer
    implements PrimitiveSerializer<FundingWalletActionSummaryKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erc20Approval': 'erc20_approval',
    'originTransaction': 'origin_transaction',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erc20_approval': 'erc20Approval',
    'origin_transaction': 'originTransaction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingWalletActionSummaryKindEnum];
  @override
  final String wireName = 'FundingWalletActionSummaryKindEnum';

  @override
  Object serialize(
          Serializers serializers, FundingWalletActionSummaryKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingWalletActionSummaryKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingWalletActionSummaryKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingWalletActionSummary extends FundingWalletActionSummary {
  @override
  final String actionId;
  @override
  final int ordinal;
  @override
  final FundingWalletActionSummaryKindEnum kind;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;
  @override
  final TransferActionStatus status;

  factory _$FundingWalletActionSummary(
          [void Function(FundingWalletActionSummaryBuilder)? updates]) =>
      (FundingWalletActionSummaryBuilder()..update(updates))._build();

  _$FundingWalletActionSummary._(
      {required this.actionId,
      required this.ordinal,
      required this.kind,
      required this.payloadHash,
      required this.validUntil,
      required this.status})
      : super._();
  @override
  FundingWalletActionSummary rebuild(
          void Function(FundingWalletActionSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingWalletActionSummaryBuilder toBuilder() =>
      FundingWalletActionSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingWalletActionSummary &&
        actionId == other.actionId &&
        ordinal == other.ordinal &&
        kind == other.kind &&
        payloadHash == other.payloadHash &&
        validUntil == other.validUntil &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, ordinal.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingWalletActionSummary')
          ..add('actionId', actionId)
          ..add('ordinal', ordinal)
          ..add('kind', kind)
          ..add('payloadHash', payloadHash)
          ..add('validUntil', validUntil)
          ..add('status', status))
        .toString();
  }
}

class FundingWalletActionSummaryBuilder
    implements
        Builder<FundingWalletActionSummary, FundingWalletActionSummaryBuilder> {
  _$FundingWalletActionSummary? _$v;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  FundingWalletActionSummaryKindEnum? _kind;
  FundingWalletActionSummaryKindEnum? get kind => _$this._kind;
  set kind(FundingWalletActionSummaryKindEnum? kind) => _$this._kind = kind;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  TransferActionStatus? _status;
  TransferActionStatus? get status => _$this._status;
  set status(TransferActionStatus? status) => _$this._status = status;

  FundingWalletActionSummaryBuilder() {
    FundingWalletActionSummary._defaults(this);
  }

  FundingWalletActionSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actionId = $v.actionId;
      _ordinal = $v.ordinal;
      _kind = $v.kind;
      _payloadHash = $v.payloadHash;
      _validUntil = $v.validUntil;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingWalletActionSummary other) {
    _$v = other as _$FundingWalletActionSummary;
  }

  @override
  void update(void Function(FundingWalletActionSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingWalletActionSummary build() => _build();

  _$FundingWalletActionSummary _build() {
    final _$result = _$v ??
        _$FundingWalletActionSummary._(
          actionId: BuiltValueNullFieldError.checkNotNull(
              actionId, r'FundingWalletActionSummary', 'actionId'),
          ordinal: BuiltValueNullFieldError.checkNotNull(
              ordinal, r'FundingWalletActionSummary', 'ordinal'),
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'FundingWalletActionSummary', 'kind'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(
              payloadHash, r'FundingWalletActionSummary', 'payloadHash'),
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'FundingWalletActionSummary', 'validUntil'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'FundingWalletActionSummary', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
