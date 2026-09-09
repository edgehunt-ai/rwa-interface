// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_rail_availability.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositRailAvailabilityStatusEnum
    _$depositRailAvailabilityStatusEnum_unavailable =
    const DepositRailAvailabilityStatusEnum._('unavailable');
const DepositRailAvailabilityStatusEnum
    _$depositRailAvailabilityStatusEnum_unknownDefaultOpenApi =
    const DepositRailAvailabilityStatusEnum._('unknownDefaultOpenApi');

DepositRailAvailabilityStatusEnum _$depositRailAvailabilityStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'unavailable':
      return _$depositRailAvailabilityStatusEnum_unavailable;
    case 'unknownDefaultOpenApi':
      return _$depositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$depositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositRailAvailabilityStatusEnum>
    _$depositRailAvailabilityStatusEnumValues = BuiltSet<
        DepositRailAvailabilityStatusEnum>(const <DepositRailAvailabilityStatusEnum>[
  _$depositRailAvailabilityStatusEnum_unavailable,
  _$depositRailAvailabilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<DepositRailAvailabilityStatusEnum>
    _$depositRailAvailabilityStatusEnumSerializer =
    _$DepositRailAvailabilityStatusEnumSerializer();

class _$DepositRailAvailabilityStatusEnumSerializer
    implements PrimitiveSerializer<DepositRailAvailabilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailAvailabilityStatusEnum];
  @override
  final String wireName = 'DepositRailAvailabilityStatusEnum';

  @override
  Object serialize(
          Serializers serializers, DepositRailAvailabilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailAvailabilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailAvailabilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailAvailability extends DepositRailAvailability {
  @override
  final OneOf oneOf;

  factory _$DepositRailAvailability(
          [void Function(DepositRailAvailabilityBuilder)? updates]) =>
      (DepositRailAvailabilityBuilder()..update(updates))._build();

  _$DepositRailAvailability._({required this.oneOf}) : super._();
  @override
  DepositRailAvailability rebuild(
          void Function(DepositRailAvailabilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositRailAvailabilityBuilder toBuilder() =>
      DepositRailAvailabilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositRailAvailability && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositRailAvailability')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class DepositRailAvailabilityBuilder
    implements
        Builder<DepositRailAvailability, DepositRailAvailabilityBuilder> {
  _$DepositRailAvailability? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  DepositRailAvailabilityBuilder() {
    DepositRailAvailability._defaults(this);
  }

  DepositRailAvailabilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositRailAvailability other) {
    _$v = other as _$DepositRailAvailability;
  }

  @override
  void update(void Function(DepositRailAvailabilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositRailAvailability build() => _build();

  _$DepositRailAvailability _build() {
    final _$result = _$v ??
        _$DepositRailAvailability._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'DepositRailAvailability', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
