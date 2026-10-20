// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unknown_financial_raw_amount.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnknownFinancialRawAmountStatusEnum
    _$unknownFinancialRawAmountStatusEnum_unknown =
    const UnknownFinancialRawAmountStatusEnum._('unknown');

UnknownFinancialRawAmountStatusEnum
    _$unknownFinancialRawAmountStatusEnumValueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknownFinancialRawAmountStatusEnum_unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UnknownFinancialRawAmountStatusEnum>
    _$unknownFinancialRawAmountStatusEnumValues = BuiltSet<
        UnknownFinancialRawAmountStatusEnum>(const <UnknownFinancialRawAmountStatusEnum>[
  _$unknownFinancialRawAmountStatusEnum_unknown,
]);

Serializer<UnknownFinancialRawAmountStatusEnum>
    _$unknownFinancialRawAmountStatusEnumSerializer =
    _$UnknownFinancialRawAmountStatusEnumSerializer();

class _$UnknownFinancialRawAmountStatusEnumSerializer
    implements PrimitiveSerializer<UnknownFinancialRawAmountStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UnknownFinancialRawAmountStatusEnum
  ];
  @override
  final String wireName = 'UnknownFinancialRawAmountStatusEnum';

  @override
  Object serialize(
          Serializers serializers, UnknownFinancialRawAmountStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnknownFinancialRawAmountStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnknownFinancialRawAmountStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnknownFinancialRawAmount extends UnknownFinancialRawAmount {
  @override
  final UnknownFinancialRawAmountStatusEnum status;
  @override
  final String reason;

  factory _$UnknownFinancialRawAmount(
          [void Function(UnknownFinancialRawAmountBuilder)? updates]) =>
      (UnknownFinancialRawAmountBuilder()..update(updates))._build();

  _$UnknownFinancialRawAmount._({required this.status, required this.reason})
      : super._();
  @override
  UnknownFinancialRawAmount rebuild(
          void Function(UnknownFinancialRawAmountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnknownFinancialRawAmountBuilder toBuilder() =>
      UnknownFinancialRawAmountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnknownFinancialRawAmount &&
        status == other.status &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnknownFinancialRawAmount')
          ..add('status', status)
          ..add('reason', reason))
        .toString();
  }
}

class UnknownFinancialRawAmountBuilder
    implements
        Builder<UnknownFinancialRawAmount, UnknownFinancialRawAmountBuilder> {
  _$UnknownFinancialRawAmount? _$v;

  UnknownFinancialRawAmountStatusEnum? _status;
  UnknownFinancialRawAmountStatusEnum? get status => _$this._status;
  set status(UnknownFinancialRawAmountStatusEnum? status) =>
      _$this._status = status;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  UnknownFinancialRawAmountBuilder() {
    UnknownFinancialRawAmount._defaults(this);
  }

  UnknownFinancialRawAmountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnknownFinancialRawAmount other) {
    _$v = other as _$UnknownFinancialRawAmount;
  }

  @override
  void update(void Function(UnknownFinancialRawAmountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnknownFinancialRawAmount build() => _build();

  _$UnknownFinancialRawAmount _build() {
    final _$result = _$v ??
        _$UnknownFinancialRawAmount._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'UnknownFinancialRawAmount', 'status'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'UnknownFinancialRawAmount', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
