// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_transfer_intent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionTransferIntentDestinationEnum
    _$fundingSessionTransferIntentDestinationEnum_hip3Margin =
    const FundingSessionTransferIntentDestinationEnum._('hip3Margin');
const FundingSessionTransferIntentDestinationEnum
    _$fundingSessionTransferIntentDestinationEnum_unknownDefaultOpenApi =
    const FundingSessionTransferIntentDestinationEnum._(
        'unknownDefaultOpenApi');

FundingSessionTransferIntentDestinationEnum
    _$fundingSessionTransferIntentDestinationEnumValueOf(String name) {
  switch (name) {
    case 'hip3Margin':
      return _$fundingSessionTransferIntentDestinationEnum_hip3Margin;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTransferIntentDestinationEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTransferIntentDestinationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTransferIntentDestinationEnum>
    _$fundingSessionTransferIntentDestinationEnumValues = BuiltSet<
        FundingSessionTransferIntentDestinationEnum>(const <FundingSessionTransferIntentDestinationEnum>[
  _$fundingSessionTransferIntentDestinationEnum_hip3Margin,
  _$fundingSessionTransferIntentDestinationEnum_unknownDefaultOpenApi,
]);

Serializer<FundingSessionTransferIntentDestinationEnum>
    _$fundingSessionTransferIntentDestinationEnumSerializer =
    _$FundingSessionTransferIntentDestinationEnumSerializer();

class _$FundingSessionTransferIntentDestinationEnumSerializer
    implements
        PrimitiveSerializer<FundingSessionTransferIntentDestinationEnum> {
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
    FundingSessionTransferIntentDestinationEnum
  ];
  @override
  final String wireName = 'FundingSessionTransferIntentDestinationEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSessionTransferIntentDestinationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTransferIntentDestinationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTransferIntentDestinationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTransferIntent extends FundingSessionTransferIntent {
  @override
  final FundingSessionTransferIntentDestinationEnum destination;
  @override
  final String amount;

  factory _$FundingSessionTransferIntent(
          [void Function(FundingSessionTransferIntentBuilder)? updates]) =>
      (FundingSessionTransferIntentBuilder()..update(updates))._build();

  _$FundingSessionTransferIntent._(
      {required this.destination, required this.amount})
      : super._();
  @override
  FundingSessionTransferIntent rebuild(
          void Function(FundingSessionTransferIntentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTransferIntentBuilder toBuilder() =>
      FundingSessionTransferIntentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTransferIntent &&
        destination == other.destination &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionTransferIntent')
          ..add('destination', destination)
          ..add('amount', amount))
        .toString();
  }
}

class FundingSessionTransferIntentBuilder
    implements
        Builder<FundingSessionTransferIntent,
            FundingSessionTransferIntentBuilder> {
  _$FundingSessionTransferIntent? _$v;

  FundingSessionTransferIntentDestinationEnum? _destination;
  FundingSessionTransferIntentDestinationEnum? get destination =>
      _$this._destination;
  set destination(FundingSessionTransferIntentDestinationEnum? destination) =>
      _$this._destination = destination;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  FundingSessionTransferIntentBuilder() {
    FundingSessionTransferIntent._defaults(this);
  }

  FundingSessionTransferIntentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _destination = $v.destination;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTransferIntent other) {
    _$v = other as _$FundingSessionTransferIntent;
  }

  @override
  void update(void Function(FundingSessionTransferIntentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTransferIntent build() => _build();

  _$FundingSessionTransferIntent _build() {
    final _$result = _$v ??
        _$FundingSessionTransferIntent._(
          destination: BuiltValueNullFieldError.checkNotNull(
              destination, r'FundingSessionTransferIntent', 'destination'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'FundingSessionTransferIntent', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
