// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_deposit_rail_availability.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AvailableDepositRailAvailabilityStatusEnum
    _$availableDepositRailAvailabilityStatusEnum_available =
    const AvailableDepositRailAvailabilityStatusEnum._('available');
const AvailableDepositRailAvailabilityStatusEnum
    _$availableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi =
    const AvailableDepositRailAvailabilityStatusEnum._('unknownDefaultOpenApi');

AvailableDepositRailAvailabilityStatusEnum
    _$availableDepositRailAvailabilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'available':
      return _$availableDepositRailAvailabilityStatusEnum_available;
    case 'unknownDefaultOpenApi':
      return _$availableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
    default:
      return _$availableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AvailableDepositRailAvailabilityStatusEnum>
    _$availableDepositRailAvailabilityStatusEnumValues = BuiltSet<
        AvailableDepositRailAvailabilityStatusEnum>(const <AvailableDepositRailAvailabilityStatusEnum>[
  _$availableDepositRailAvailabilityStatusEnum_available,
  _$availableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi,
]);

Serializer<AvailableDepositRailAvailabilityStatusEnum>
    _$availableDepositRailAvailabilityStatusEnumSerializer =
    _$AvailableDepositRailAvailabilityStatusEnumSerializer();

class _$AvailableDepositRailAvailabilityStatusEnumSerializer
    implements PrimitiveSerializer<AvailableDepositRailAvailabilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AvailableDepositRailAvailabilityStatusEnum
  ];
  @override
  final String wireName = 'AvailableDepositRailAvailabilityStatusEnum';

  @override
  Object serialize(Serializers serializers,
          AvailableDepositRailAvailabilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AvailableDepositRailAvailabilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AvailableDepositRailAvailabilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AvailableDepositRailAvailability
    extends AvailableDepositRailAvailability {
  @override
  final AvailableDepositRailAvailabilityStatusEnum status;
  @override
  final BuiltList<DepositRailBlocker> blockers;

  factory _$AvailableDepositRailAvailability(
          [void Function(AvailableDepositRailAvailabilityBuilder)? updates]) =>
      (AvailableDepositRailAvailabilityBuilder()..update(updates))._build();

  _$AvailableDepositRailAvailability._(
      {required this.status, required this.blockers})
      : super._();
  @override
  AvailableDepositRailAvailability rebuild(
          void Function(AvailableDepositRailAvailabilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AvailableDepositRailAvailabilityBuilder toBuilder() =>
      AvailableDepositRailAvailabilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailableDepositRailAvailability &&
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
    return (newBuiltValueToStringHelper(r'AvailableDepositRailAvailability')
          ..add('status', status)
          ..add('blockers', blockers))
        .toString();
  }
}

class AvailableDepositRailAvailabilityBuilder
    implements
        Builder<AvailableDepositRailAvailability,
            AvailableDepositRailAvailabilityBuilder> {
  _$AvailableDepositRailAvailability? _$v;

  AvailableDepositRailAvailabilityStatusEnum? _status;
  AvailableDepositRailAvailabilityStatusEnum? get status => _$this._status;
  set status(AvailableDepositRailAvailabilityStatusEnum? status) =>
      _$this._status = status;

  ListBuilder<DepositRailBlocker>? _blockers;
  ListBuilder<DepositRailBlocker> get blockers =>
      _$this._blockers ??= ListBuilder<DepositRailBlocker>();
  set blockers(ListBuilder<DepositRailBlocker>? blockers) =>
      _$this._blockers = blockers;

  AvailableDepositRailAvailabilityBuilder() {
    AvailableDepositRailAvailability._defaults(this);
  }

  AvailableDepositRailAvailabilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _blockers = $v.blockers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailableDepositRailAvailability other) {
    _$v = other as _$AvailableDepositRailAvailability;
  }

  @override
  void update(void Function(AvailableDepositRailAvailabilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailableDepositRailAvailability build() => _build();

  _$AvailableDepositRailAvailability _build() {
    _$AvailableDepositRailAvailability _$result;
    try {
      _$result = _$v ??
          _$AvailableDepositRailAvailability._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'AvailableDepositRailAvailability', 'status'),
            blockers: blockers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'blockers';
        blockers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AvailableDepositRailAvailability', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
