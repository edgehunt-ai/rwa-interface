// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_step_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionStepOrderRoleEnum
    _$hip3ProtectionStepOrderRoleEnum_takeProfit =
    const Hip3ProtectionStepOrderRoleEnum._('takeProfit');
const Hip3ProtectionStepOrderRoleEnum
    _$hip3ProtectionStepOrderRoleEnum_stopLoss =
    const Hip3ProtectionStepOrderRoleEnum._('stopLoss');

Hip3ProtectionStepOrderRoleEnum _$hip3ProtectionStepOrderRoleEnumValueOf(
    String name) {
  switch (name) {
    case 'takeProfit':
      return _$hip3ProtectionStepOrderRoleEnum_takeProfit;
    case 'stopLoss':
      return _$hip3ProtectionStepOrderRoleEnum_stopLoss;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionStepOrderRoleEnum>
    _$hip3ProtectionStepOrderRoleEnumValues = BuiltSet<
        Hip3ProtectionStepOrderRoleEnum>(const <Hip3ProtectionStepOrderRoleEnum>[
  _$hip3ProtectionStepOrderRoleEnum_takeProfit,
  _$hip3ProtectionStepOrderRoleEnum_stopLoss,
]);

const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_waiting =
    const Hip3ProtectionStepOrderStatusEnum._('waiting');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_prepared =
    const Hip3ProtectionStepOrderStatusEnum._('prepared');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_submitting =
    const Hip3ProtectionStepOrderStatusEnum._('submitting');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_acknowledged =
    const Hip3ProtectionStepOrderStatusEnum._('acknowledged');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_confirmed =
    const Hip3ProtectionStepOrderStatusEnum._('confirmed');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_rejected =
    const Hip3ProtectionStepOrderStatusEnum._('rejected');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_unknown =
    const Hip3ProtectionStepOrderStatusEnum._('unknown');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_cancelled =
    const Hip3ProtectionStepOrderStatusEnum._('cancelled');
const Hip3ProtectionStepOrderStatusEnum
    _$hip3ProtectionStepOrderStatusEnum_expired =
    const Hip3ProtectionStepOrderStatusEnum._('expired');

Hip3ProtectionStepOrderStatusEnum _$hip3ProtectionStepOrderStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'waiting':
      return _$hip3ProtectionStepOrderStatusEnum_waiting;
    case 'prepared':
      return _$hip3ProtectionStepOrderStatusEnum_prepared;
    case 'submitting':
      return _$hip3ProtectionStepOrderStatusEnum_submitting;
    case 'acknowledged':
      return _$hip3ProtectionStepOrderStatusEnum_acknowledged;
    case 'confirmed':
      return _$hip3ProtectionStepOrderStatusEnum_confirmed;
    case 'rejected':
      return _$hip3ProtectionStepOrderStatusEnum_rejected;
    case 'unknown':
      return _$hip3ProtectionStepOrderStatusEnum_unknown;
    case 'cancelled':
      return _$hip3ProtectionStepOrderStatusEnum_cancelled;
    case 'expired':
      return _$hip3ProtectionStepOrderStatusEnum_expired;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionStepOrderStatusEnum>
    _$hip3ProtectionStepOrderStatusEnumValues = BuiltSet<
        Hip3ProtectionStepOrderStatusEnum>(const <Hip3ProtectionStepOrderStatusEnum>[
  _$hip3ProtectionStepOrderStatusEnum_waiting,
  _$hip3ProtectionStepOrderStatusEnum_prepared,
  _$hip3ProtectionStepOrderStatusEnum_submitting,
  _$hip3ProtectionStepOrderStatusEnum_acknowledged,
  _$hip3ProtectionStepOrderStatusEnum_confirmed,
  _$hip3ProtectionStepOrderStatusEnum_rejected,
  _$hip3ProtectionStepOrderStatusEnum_unknown,
  _$hip3ProtectionStepOrderStatusEnum_cancelled,
  _$hip3ProtectionStepOrderStatusEnum_expired,
]);

Serializer<Hip3ProtectionStepOrderRoleEnum>
    _$hip3ProtectionStepOrderRoleEnumSerializer =
    _$Hip3ProtectionStepOrderRoleEnumSerializer();
Serializer<Hip3ProtectionStepOrderStatusEnum>
    _$hip3ProtectionStepOrderStatusEnumSerializer =
    _$Hip3ProtectionStepOrderStatusEnumSerializer();

class _$Hip3ProtectionStepOrderRoleEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionStepOrderRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'takeProfit': 'take_profit',
    'stopLoss': 'stop_loss',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'take_profit': 'takeProfit',
    'stop_loss': 'stopLoss',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ProtectionStepOrderRoleEnum];
  @override
  final String wireName = 'Hip3ProtectionStepOrderRoleEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ProtectionStepOrderRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionStepOrderRoleEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionStepOrderRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionStepOrderStatusEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionStepOrderStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'waiting': 'waiting',
    'prepared': 'prepared',
    'submitting': 'submitting',
    'acknowledged': 'acknowledged',
    'confirmed': 'confirmed',
    'rejected': 'rejected',
    'unknown': 'unknown',
    'cancelled': 'cancelled',
    'expired': 'expired',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'waiting': 'waiting',
    'prepared': 'prepared',
    'submitting': 'submitting',
    'acknowledged': 'acknowledged',
    'confirmed': 'confirmed',
    'rejected': 'rejected',
    'unknown': 'unknown',
    'cancelled': 'cancelled',
    'expired': 'expired',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ProtectionStepOrderStatusEnum];
  @override
  final String wireName = 'Hip3ProtectionStepOrderStatusEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ProtectionStepOrderStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionStepOrderStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionStepOrderStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionStepOrder extends Hip3ProtectionStepOrder {
  @override
  final int changeIndex;
  @override
  final String orderId;
  @override
  final String? replacedOrderId;
  @override
  final Hip3ProtectionStepOrderRoleEnum role;
  @override
  final Hip3SingleProtectionSpec? protection;
  @override
  final Hip3ProtectionStepOrderStatusEnum status;
  @override
  final String? failureReason;

  factory _$Hip3ProtectionStepOrder(
          [void Function(Hip3ProtectionStepOrderBuilder)? updates]) =>
      (Hip3ProtectionStepOrderBuilder()..update(updates))._build();

  _$Hip3ProtectionStepOrder._(
      {required this.changeIndex,
      required this.orderId,
      this.replacedOrderId,
      required this.role,
      this.protection,
      required this.status,
      this.failureReason})
      : super._();
  @override
  Hip3ProtectionStepOrder rebuild(
          void Function(Hip3ProtectionStepOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionStepOrderBuilder toBuilder() =>
      Hip3ProtectionStepOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionStepOrder &&
        changeIndex == other.changeIndex &&
        orderId == other.orderId &&
        replacedOrderId == other.replacedOrderId &&
        role == other.role &&
        protection == other.protection &&
        status == other.status &&
        failureReason == other.failureReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, changeIndex.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, replacedOrderId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, protection.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionStepOrder')
          ..add('changeIndex', changeIndex)
          ..add('orderId', orderId)
          ..add('replacedOrderId', replacedOrderId)
          ..add('role', role)
          ..add('protection', protection)
          ..add('status', status)
          ..add('failureReason', failureReason))
        .toString();
  }
}

class Hip3ProtectionStepOrderBuilder
    implements
        Builder<Hip3ProtectionStepOrder, Hip3ProtectionStepOrderBuilder> {
  _$Hip3ProtectionStepOrder? _$v;

  int? _changeIndex;
  int? get changeIndex => _$this._changeIndex;
  set changeIndex(int? changeIndex) => _$this._changeIndex = changeIndex;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _replacedOrderId;
  String? get replacedOrderId => _$this._replacedOrderId;
  set replacedOrderId(String? replacedOrderId) =>
      _$this._replacedOrderId = replacedOrderId;

  Hip3ProtectionStepOrderRoleEnum? _role;
  Hip3ProtectionStepOrderRoleEnum? get role => _$this._role;
  set role(Hip3ProtectionStepOrderRoleEnum? role) => _$this._role = role;

  Hip3SingleProtectionSpecBuilder? _protection;
  Hip3SingleProtectionSpecBuilder get protection =>
      _$this._protection ??= Hip3SingleProtectionSpecBuilder();
  set protection(Hip3SingleProtectionSpecBuilder? protection) =>
      _$this._protection = protection;

  Hip3ProtectionStepOrderStatusEnum? _status;
  Hip3ProtectionStepOrderStatusEnum? get status => _$this._status;
  set status(Hip3ProtectionStepOrderStatusEnum? status) =>
      _$this._status = status;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  Hip3ProtectionStepOrderBuilder() {
    Hip3ProtectionStepOrder._defaults(this);
  }

  Hip3ProtectionStepOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _changeIndex = $v.changeIndex;
      _orderId = $v.orderId;
      _replacedOrderId = $v.replacedOrderId;
      _role = $v.role;
      _protection = $v.protection?.toBuilder();
      _status = $v.status;
      _failureReason = $v.failureReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionStepOrder other) {
    _$v = other as _$Hip3ProtectionStepOrder;
  }

  @override
  void update(void Function(Hip3ProtectionStepOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionStepOrder build() => _build();

  _$Hip3ProtectionStepOrder _build() {
    _$Hip3ProtectionStepOrder _$result;
    try {
      _$result = _$v ??
          _$Hip3ProtectionStepOrder._(
            changeIndex: BuiltValueNullFieldError.checkNotNull(
                changeIndex, r'Hip3ProtectionStepOrder', 'changeIndex'),
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'Hip3ProtectionStepOrder', 'orderId'),
            replacedOrderId: replacedOrderId,
            role: BuiltValueNullFieldError.checkNotNull(
                role, r'Hip3ProtectionStepOrder', 'role'),
            protection: _protection?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Hip3ProtectionStepOrder', 'status'),
            failureReason: failureReason,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protection';
        _protection?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ProtectionStepOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
