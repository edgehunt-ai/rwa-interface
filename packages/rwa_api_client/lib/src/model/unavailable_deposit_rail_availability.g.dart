// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unavailable_deposit_rail_availability.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnavailableDepositRailAvailabilityStatusEnum
    _$unavailableDepositRailAvailabilityStatusEnum_unavailable =
    const UnavailableDepositRailAvailabilityStatusEnum._('unavailable');
const UnavailableDepositRailAvailabilityStatusEnum
    _$unavailableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi =
    const UnavailableDepositRailAvailabilityStatusEnum._(
        'unknownDefaultOpenApi');

UnavailableDepositRailAvailabilityStatusEnum
    _$unavailableDepositRailAvailabilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'unavailable':
      return _$unavailableDepositRailAvailabilityStatusEnum_unavailable;
    case 'unknownDefaultOpenApi':
      return _$unavailableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$unavailableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnavailableDepositRailAvailabilityStatusEnum>
    _$unavailableDepositRailAvailabilityStatusEnumValues = BuiltSet<
        UnavailableDepositRailAvailabilityStatusEnum>(const <UnavailableDepositRailAvailabilityStatusEnum>[
  _$unavailableDepositRailAvailabilityStatusEnum_unavailable,
  _$unavailableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<UnavailableDepositRailAvailabilityStatusEnum>
    _$unavailableDepositRailAvailabilityStatusEnumSerializer =
    _$UnavailableDepositRailAvailabilityStatusEnumSerializer();

class _$UnavailableDepositRailAvailabilityStatusEnumSerializer
    implements
        PrimitiveSerializer<UnavailableDepositRailAvailabilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UnavailableDepositRailAvailabilityStatusEnum
  ];
  @override
  final String wireName = 'UnavailableDepositRailAvailabilityStatusEnum';

  @override
  Object serialize(Serializers serializers,
          UnavailableDepositRailAvailabilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnavailableDepositRailAvailabilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnavailableDepositRailAvailabilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnavailableDepositRailAvailability
    extends UnavailableDepositRailAvailability {
  @override
  final UnavailableDepositRailAvailabilityStatusEnum status;
  @override
  final BuiltList<DepositRailBlocker> blockers;

  factory _$UnavailableDepositRailAvailability(
          [void Function(UnavailableDepositRailAvailabilityBuilder)?
              updates]) =>
      (UnavailableDepositRailAvailabilityBuilder()..update(updates))._build();

  _$UnavailableDepositRailAvailability._(
      {required this.status, required this.blockers})
      : super._();
  @override
  UnavailableDepositRailAvailability rebuild(
          void Function(UnavailableDepositRailAvailabilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnavailableDepositRailAvailabilityBuilder toBuilder() =>
      UnavailableDepositRailAvailabilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnavailableDepositRailAvailability &&
        status == other.status &&
        blockers == other.blockers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnavailableDepositRailAvailability')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class UnavailableDepositRailAvailabilityBuilder
    implements
        Builder<UnavailableDepositRailAvailability,
            UnavailableDepositRailAvailabilityBuilder> {
  _$UnavailableDepositRailAvailability? _$v;

  UnavailableDepositRailAvailabilityStatusEnum? _status;
  UnavailableDepositRailAvailabilityStatusEnum? get status => _$this._status;
  set status(UnavailableDepositRailAvailabilityStatusEnum? status) =>
      _$this._status = status;

  ListBuilder<DepositRailBlocker>? _blockers;
  ListBuilder<DepositRailBlocker> get blockers =>
      _$this._blockers ??= ListBuilder<DepositRailBlocker>();
  set blockers(ListBuilder<DepositRailBlocker>? blockers) =>
      _$this._blockers = blockers;

  UnavailableDepositRailAvailabilityBuilder() {
    UnavailableDepositRailAvailability._defaults(this);
  }

  UnavailableDepositRailAvailabilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnavailableDepositRailAvailability other) {
    _$v = other as _$UnavailableDepositRailAvailability;
  }

  @override
  void update(
      void Function(UnavailableDepositRailAvailabilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnavailableDepositRailAvailability build() => _build();

  _$UnavailableDepositRailAvailability _build() {
    _$UnavailableDepositRailAvailability _$result;
    try {
      _$result = _$v ??
          _$UnavailableDepositRailAvailability._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'UnavailableDepositRailAvailability', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UnavailableDepositRailAvailability', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
