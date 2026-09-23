// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_transfer_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionTransferSnapshotKindEnum
    _$fundingSessionTransferSnapshotKindEnum_accountTransfer =
    const FundingSessionTransferSnapshotKindEnum._('accountTransfer');
const FundingSessionTransferSnapshotKindEnum
    _$fundingSessionTransferSnapshotKindEnum_unknownDefaultOpenApi =
    const FundingSessionTransferSnapshotKindEnum._('unknownDefaultOpenApi');

FundingSessionTransferSnapshotKindEnum
    _$fundingSessionTransferSnapshotKindEnumValueOf(String name) {
  switch (name) {
    case 'accountTransfer':
      return _$fundingSessionTransferSnapshotKindEnum_accountTransfer;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTransferSnapshotKindEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTransferSnapshotKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTransferSnapshotKindEnum>
    _$fundingSessionTransferSnapshotKindEnumValues = BuiltSet<
        FundingSessionTransferSnapshotKindEnum>(const <FundingSessionTransferSnapshotKindEnum>[
  _$fundingSessionTransferSnapshotKindEnum_accountTransfer,
  _$fundingSessionTransferSnapshotKindEnum_unknownDefaultOpenApi,
]);

const FundingSessionTransferSnapshotDestinationEnum
    _$fundingSessionTransferSnapshotDestinationEnum_hip3Margin =
    const FundingSessionTransferSnapshotDestinationEnum._('hip3Margin');
const FundingSessionTransferSnapshotDestinationEnum
    _$fundingSessionTransferSnapshotDestinationEnum_unknownDefaultOpenApi =
    const FundingSessionTransferSnapshotDestinationEnum._(
        'unknownDefaultOpenApi');

FundingSessionTransferSnapshotDestinationEnum
    _$fundingSessionTransferSnapshotDestinationEnumValueOf(String name) {
  switch (name) {
    case 'hip3Margin':
      return _$fundingSessionTransferSnapshotDestinationEnum_hip3Margin;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTransferSnapshotDestinationEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTransferSnapshotDestinationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTransferSnapshotDestinationEnum>
    _$fundingSessionTransferSnapshotDestinationEnumValues = BuiltSet<
        FundingSessionTransferSnapshotDestinationEnum>(const <FundingSessionTransferSnapshotDestinationEnum>[
  _$fundingSessionTransferSnapshotDestinationEnum_hip3Margin,
  _$fundingSessionTransferSnapshotDestinationEnum_unknownDefaultOpenApi,
]);

Serializer<FundingSessionTransferSnapshotKindEnum>
    _$fundingSessionTransferSnapshotKindEnumSerializer =
    _$FundingSessionTransferSnapshotKindEnumSerializer();
Serializer<FundingSessionTransferSnapshotDestinationEnum>
    _$fundingSessionTransferSnapshotDestinationEnumSerializer =
    _$FundingSessionTransferSnapshotDestinationEnumSerializer();

class _$FundingSessionTransferSnapshotKindEnumSerializer
    implements PrimitiveSerializer<FundingSessionTransferSnapshotKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'accountTransfer': 'account_transfer',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'account_transfer': 'accountTransfer',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionTransferSnapshotKindEnum
  ];
  @override
  final String wireName = 'FundingSessionTransferSnapshotKindEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSessionTransferSnapshotKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTransferSnapshotKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTransferSnapshotKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTransferSnapshotDestinationEnumSerializer
    implements
        PrimitiveSerializer<FundingSessionTransferSnapshotDestinationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Margin': 'hip3_margin',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_margin': 'hip3Margin',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionTransferSnapshotDestinationEnum
  ];
  @override
  final String wireName = 'FundingSessionTransferSnapshotDestinationEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSessionTransferSnapshotDestinationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTransferSnapshotDestinationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTransferSnapshotDestinationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTransferSnapshot extends FundingSessionTransferSnapshot {
  @override
  final FundingSessionTransferSnapshotKindEnum kind;
  @override
  final FundingSessionTransferSnapshotDestinationEnum destination;
  @override
  final String amount;

  factory _$FundingSessionTransferSnapshot(
          [void Function(FundingSessionTransferSnapshotBuilder)? updates]) =>
      (FundingSessionTransferSnapshotBuilder()..update(updates))._build();

  _$FundingSessionTransferSnapshot._(
      {required this.kind, required this.destination, required this.amount})
      : super._();
  @override
  FundingSessionTransferSnapshot rebuild(
          void Function(FundingSessionTransferSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTransferSnapshotBuilder toBuilder() =>
      FundingSessionTransferSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTransferSnapshot &&
        kind == other.kind &&
        destination == other.destination &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionTransferSnapshot')
          ..add('kind', kind)
          ..add('destination', destination)
          ..add('amount', amount))
        .toString();
  }
}

class FundingSessionTransferSnapshotBuilder
    implements
        Builder<FundingSessionTransferSnapshot,
            FundingSessionTransferSnapshotBuilder> {
  _$FundingSessionTransferSnapshot? _$v;

  FundingSessionTransferSnapshotKindEnum? _kind;
  FundingSessionTransferSnapshotKindEnum? get kind => _$this._kind;
  set kind(FundingSessionTransferSnapshotKindEnum? kind) => _$this._kind = kind;

  FundingSessionTransferSnapshotDestinationEnum? _destination;
  FundingSessionTransferSnapshotDestinationEnum? get destination =>
      _$this._destination;
  set destination(FundingSessionTransferSnapshotDestinationEnum? destination) =>
      _$this._destination = destination;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  FundingSessionTransferSnapshotBuilder() {
    FundingSessionTransferSnapshot._defaults(this);
  }

  FundingSessionTransferSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _destination = $v.destination;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTransferSnapshot other) {
    _$v = other as _$FundingSessionTransferSnapshot;
  }

  @override
  void update(void Function(FundingSessionTransferSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTransferSnapshot build() => _build();

  _$FundingSessionTransferSnapshot _build() {
    final _$result = _$v ??
        _$FundingSessionTransferSnapshot._(
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'FundingSessionTransferSnapshot', 'kind'),
          destination: BuiltValueNullFieldError.checkNotNull(
              destination, r'FundingSessionTransferSnapshot', 'destination'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'FundingSessionTransferSnapshot', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
