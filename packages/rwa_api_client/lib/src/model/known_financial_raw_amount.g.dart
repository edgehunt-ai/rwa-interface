// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_financial_raw_amount.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KnownFinancialRawAmountStatusEnum
    _$knownFinancialRawAmountStatusEnum_known =
    const KnownFinancialRawAmountStatusEnum._('known');

KnownFinancialRawAmountStatusEnum _$knownFinancialRawAmountStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'known':
      return _$knownFinancialRawAmountStatusEnum_known;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialRawAmountStatusEnum>
    _$knownFinancialRawAmountStatusEnumValues = BuiltSet<
        KnownFinancialRawAmountStatusEnum>(const <KnownFinancialRawAmountStatusEnum>[
  _$knownFinancialRawAmountStatusEnum_known,
]);

Serializer<KnownFinancialRawAmountStatusEnum>
    _$knownFinancialRawAmountStatusEnumSerializer =
    _$KnownFinancialRawAmountStatusEnumSerializer();

class _$KnownFinancialRawAmountStatusEnumSerializer
    implements PrimitiveSerializer<KnownFinancialRawAmountStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'known': 'known',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'known': 'known',
  };

  @override
  final Iterable<Type> types = const <Type>[KnownFinancialRawAmountStatusEnum];
  @override
  final String wireName = 'KnownFinancialRawAmountStatusEnum';

  @override
  Object serialize(
          Serializers serializers, KnownFinancialRawAmountStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialRawAmountStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialRawAmountStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialRawAmount extends KnownFinancialRawAmount {
  @override
  final KnownFinancialRawAmountStatusEnum status;
  @override
  final String amountRaw;

  factory _$KnownFinancialRawAmount(
          [void Function(KnownFinancialRawAmountBuilder)? updates]) =>
      (KnownFinancialRawAmountBuilder()..update(updates))._build();

  _$KnownFinancialRawAmount._({required this.status, required this.amountRaw})
      : super._();
  @override
  KnownFinancialRawAmount rebuild(
          void Function(KnownFinancialRawAmountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnownFinancialRawAmountBuilder toBuilder() =>
      KnownFinancialRawAmountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnownFinancialRawAmount &&
        status == other.status &&
        amountRaw == other.amountRaw;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, amountRaw.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnownFinancialRawAmount')
          ..add('status', status)
          ..add('amountRaw', amountRaw))
        .toString();
  }
}

class KnownFinancialRawAmountBuilder
    implements
        Builder<KnownFinancialRawAmount, KnownFinancialRawAmountBuilder> {
  _$KnownFinancialRawAmount? _$v;

  KnownFinancialRawAmountStatusEnum? _status;
  KnownFinancialRawAmountStatusEnum? get status => _$this._status;
  set status(KnownFinancialRawAmountStatusEnum? status) =>
      _$this._status = status;

  String? _amountRaw;
  String? get amountRaw => _$this._amountRaw;
  set amountRaw(String? amountRaw) => _$this._amountRaw = amountRaw;

  KnownFinancialRawAmountBuilder() {
    KnownFinancialRawAmount._defaults(this);
  }

  KnownFinancialRawAmountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _amountRaw = $v.amountRaw;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnownFinancialRawAmount other) {
    _$v = other as _$KnownFinancialRawAmount;
  }

  @override
  void update(void Function(KnownFinancialRawAmountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnownFinancialRawAmount build() => _build();

  _$KnownFinancialRawAmount _build() {
    final _$result = _$v ??
        _$KnownFinancialRawAmount._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'KnownFinancialRawAmount', 'status'),
          amountRaw: BuiltValueNullFieldError.checkNotNull(
              amountRaw, r'KnownFinancialRawAmount', 'amountRaw'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
