// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_order_wallet_action_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpOrderWalletActionStateKindEnum
    _$perpOrderWalletActionStateKindEnum_perp =
    const PerpOrderWalletActionStateKindEnum._('perp');

PerpOrderWalletActionStateKindEnum _$perpOrderWalletActionStateKindEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$perpOrderWalletActionStateKindEnum_perp;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PerpOrderWalletActionStateKindEnum>
    _$perpOrderWalletActionStateKindEnumValues = BuiltSet<
        PerpOrderWalletActionStateKindEnum>(const <PerpOrderWalletActionStateKindEnum>[
  _$perpOrderWalletActionStateKindEnum_perp,
]);

const PerpOrderWalletActionStateWalletActionBlockerEnum
    _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable =
    const PerpOrderWalletActionStateWalletActionBlockerEnum._('notApplicable');

PerpOrderWalletActionStateWalletActionBlockerEnum
    _$perpOrderWalletActionStateWalletActionBlockerEnumValueOf(String name) {
  switch (name) {
    case 'notApplicable':
      return _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PerpOrderWalletActionStateWalletActionBlockerEnum>
    _$perpOrderWalletActionStateWalletActionBlockerEnumValues = BuiltSet<
        PerpOrderWalletActionStateWalletActionBlockerEnum>(const <PerpOrderWalletActionStateWalletActionBlockerEnum>[
  _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable,
]);

Serializer<PerpOrderWalletActionStateKindEnum>
    _$perpOrderWalletActionStateKindEnumSerializer =
    _$PerpOrderWalletActionStateKindEnumSerializer();
Serializer<PerpOrderWalletActionStateWalletActionBlockerEnum>
    _$perpOrderWalletActionStateWalletActionBlockerEnumSerializer =
    _$PerpOrderWalletActionStateWalletActionBlockerEnumSerializer();

class _$PerpOrderWalletActionStateKindEnumSerializer
    implements PrimitiveSerializer<PerpOrderWalletActionStateKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderWalletActionStateKindEnum];
  @override
  final String wireName = 'PerpOrderWalletActionStateKindEnum';

  @override
  Object serialize(
          Serializers serializers, PerpOrderWalletActionStateKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderWalletActionStateKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderWalletActionStateKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderWalletActionStateWalletActionBlockerEnumSerializer
    implements
        PrimitiveSerializer<PerpOrderWalletActionStateWalletActionBlockerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notApplicable': 'not_applicable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_applicable': 'notApplicable',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PerpOrderWalletActionStateWalletActionBlockerEnum
  ];
  @override
  final String wireName = 'PerpOrderWalletActionStateWalletActionBlockerEnum';

  @override
  Object serialize(Serializers serializers,
          PerpOrderWalletActionStateWalletActionBlockerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderWalletActionStateWalletActionBlockerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderWalletActionStateWalletActionBlockerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class PerpOrderWalletActionStateBuilder {
  void replace(PerpOrderWalletActionState other);
  void update(void Function(PerpOrderWalletActionStateBuilder) updates);
  String? get orderId;
  set orderId(String? orderId);

  Hip3TimeInForce? get timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce);

  OrderStatus? get status;
  set status(OrderStatus? status);

  String? get quantity;
  set quantity(String? quantity);

  PerpOrderWalletActionStateKindEnum? get kind;
  set kind(PerpOrderWalletActionStateKindEnum? kind);

  JsonObject? get nextAction;
  set nextAction(JsonObject? nextAction);

  PerpOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker;
  set walletActionBlocker(
      PerpOrderWalletActionStateWalletActionBlockerEnum? walletActionBlocker);
}

class _$$PerpOrderWalletActionState extends $PerpOrderWalletActionState {
  @override
  final String orderId;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final OrderStatus status;
  @override
  final String? quantity;
  @override
  final PerpOrderWalletActionStateKindEnum kind;
  @override
  final JsonObject? nextAction;
  @override
  final PerpOrderWalletActionStateWalletActionBlockerEnum walletActionBlocker;

  factory _$$PerpOrderWalletActionState(
          [void Function($PerpOrderWalletActionStateBuilder)? updates]) =>
      ($PerpOrderWalletActionStateBuilder()..update(updates))._build();

  _$$PerpOrderWalletActionState._(
      {required this.orderId,
      this.timeInForce,
      required this.status,
      this.quantity,
      required this.kind,
      this.nextAction,
      required this.walletActionBlocker})
      : super._();
  @override
  $PerpOrderWalletActionState rebuild(
          void Function($PerpOrderWalletActionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $PerpOrderWalletActionStateBuilder toBuilder() =>
      $PerpOrderWalletActionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $PerpOrderWalletActionState &&
        orderId == other.orderId &&
        timeInForce == other.timeInForce &&
        status == other.status &&
        quantity == other.quantity &&
        kind == other.kind &&
        nextAction == other.nextAction &&
        walletActionBlocker == other.walletActionBlocker;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, walletActionBlocker.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$PerpOrderWalletActionState')
          ..add('orderId', orderId)
          ..add('timeInForce', timeInForce)
          ..add('status', status)
          ..add('quantity', quantity)
          ..add('kind', kind)
          ..add('nextAction', nextAction)
          ..add('walletActionBlocker', walletActionBlocker))
        .toString();
  }
}

class $PerpOrderWalletActionStateBuilder
    implements
        Builder<$PerpOrderWalletActionState,
            $PerpOrderWalletActionStateBuilder>,
        PerpOrderWalletActionStateBuilder {
  _$$PerpOrderWalletActionState? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(covariant String? orderId) => _$this._orderId = orderId;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(covariant Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(covariant OrderStatus? status) => _$this._status = status;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(covariant String? quantity) => _$this._quantity = quantity;

  PerpOrderWalletActionStateKindEnum? _kind;
  PerpOrderWalletActionStateKindEnum? get kind => _$this._kind;
  set kind(covariant PerpOrderWalletActionStateKindEnum? kind) =>
      _$this._kind = kind;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(covariant JsonObject? nextAction) =>
      _$this._nextAction = nextAction;

  PerpOrderWalletActionStateWalletActionBlockerEnum? _walletActionBlocker;
  PerpOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker =>
      _$this._walletActionBlocker;
  set walletActionBlocker(
          covariant PerpOrderWalletActionStateWalletActionBlockerEnum?
              walletActionBlocker) =>
      _$this._walletActionBlocker = walletActionBlocker;

  $PerpOrderWalletActionStateBuilder() {
    $PerpOrderWalletActionState._defaults(this);
  }

  $PerpOrderWalletActionStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _timeInForce = $v.timeInForce;
      _status = $v.status;
      _quantity = $v.quantity;
      _kind = $v.kind;
      _nextAction = $v.nextAction;
      _walletActionBlocker = $v.walletActionBlocker;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $PerpOrderWalletActionState other) {
    _$v = other as _$$PerpOrderWalletActionState;
  }

  @override
  void update(void Function($PerpOrderWalletActionStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $PerpOrderWalletActionState build() => _build();

  _$$PerpOrderWalletActionState _build() {
    final _$result = _$v ??
        _$$PerpOrderWalletActionState._(
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'$PerpOrderWalletActionState', 'orderId'),
          timeInForce: timeInForce,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'$PerpOrderWalletActionState', 'status'),
          quantity: quantity,
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'$PerpOrderWalletActionState', 'kind'),
          nextAction: nextAction,
          walletActionBlocker: BuiltValueNullFieldError.checkNotNull(
              walletActionBlocker,
              r'$PerpOrderWalletActionState',
              'walletActionBlocker'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
