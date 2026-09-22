// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_order_wallet_action_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpOrderWalletActionStateKindEnum
    _$perpOrderWalletActionStateKindEnum_perp =
    const PerpOrderWalletActionStateKindEnum._('perp');
const PerpOrderWalletActionStateKindEnum
    _$perpOrderWalletActionStateKindEnum_unknownDefaultOpenApi =
    const PerpOrderWalletActionStateKindEnum._('unknownDefaultOpenApi');

PerpOrderWalletActionStateKindEnum _$perpOrderWalletActionStateKindEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$perpOrderWalletActionStateKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpOrderWalletActionStateKindEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderWalletActionStateKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderWalletActionStateKindEnum>
    _$perpOrderWalletActionStateKindEnumValues = BuiltSet<
        PerpOrderWalletActionStateKindEnum>(const <PerpOrderWalletActionStateKindEnum>[
  _$perpOrderWalletActionStateKindEnum_perp,
  _$perpOrderWalletActionStateKindEnum_unknownDefaultOpenApi,
]);

const PerpOrderWalletActionStateWalletActionBlockerEnum
    _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable =
    const PerpOrderWalletActionStateWalletActionBlockerEnum._('notApplicable');
const PerpOrderWalletActionStateWalletActionBlockerEnum
    _$perpOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi =
    const PerpOrderWalletActionStateWalletActionBlockerEnum._(
        'unknownDefaultOpenApi');

PerpOrderWalletActionStateWalletActionBlockerEnum
    _$perpOrderWalletActionStateWalletActionBlockerEnumValueOf(String name) {
  switch (name) {
    case 'notApplicable':
      return _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable;
    case 'unknownDefaultOpenApi':
      return _$perpOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderWalletActionStateWalletActionBlockerEnum>
    _$perpOrderWalletActionStateWalletActionBlockerEnumValues = BuiltSet<
        PerpOrderWalletActionStateWalletActionBlockerEnum>(const <PerpOrderWalletActionStateWalletActionBlockerEnum>[
  _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable,
  _$perpOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi,
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
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
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
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_applicable': 'notApplicable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
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

class _$PerpOrderWalletActionState extends PerpOrderWalletActionState {
  @override
  final String? quantity;
  @override
  final PerpOrderWalletActionStateKindEnum kind;
  @override
  final JsonObject? nextAction;
  @override
  final PerpOrderWalletActionStateWalletActionBlockerEnum walletActionBlocker;

  factory _$PerpOrderWalletActionState(
          [void Function(PerpOrderWalletActionStateBuilder)? updates]) =>
      (PerpOrderWalletActionStateBuilder()..update(updates))._build();

  _$PerpOrderWalletActionState._(
      {this.quantity,
      required this.kind,
      this.nextAction,
      required this.walletActionBlocker})
      : super._();
  @override
  PerpOrderWalletActionState rebuild(
          void Function(PerpOrderWalletActionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpOrderWalletActionStateBuilder toBuilder() =>
      PerpOrderWalletActionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpOrderWalletActionState &&
        quantity == other.quantity &&
        kind == other.kind &&
        nextAction == other.nextAction &&
        walletActionBlocker == other.walletActionBlocker;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, walletActionBlocker.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerpOrderWalletActionState')
          ..add('quantity', quantity)
          ..add('kind', kind)
          ..add('nextAction', nextAction)
          ..add('walletActionBlocker', walletActionBlocker))
        .toString();
  }
}

class PerpOrderWalletActionStateBuilder
    implements
        Builder<PerpOrderWalletActionState, PerpOrderWalletActionStateBuilder> {
  _$PerpOrderWalletActionState? _$v;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  PerpOrderWalletActionStateKindEnum? _kind;
  PerpOrderWalletActionStateKindEnum? get kind => _$this._kind;
  set kind(PerpOrderWalletActionStateKindEnum? kind) => _$this._kind = kind;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(JsonObject? nextAction) => _$this._nextAction = nextAction;

  PerpOrderWalletActionStateWalletActionBlockerEnum? _walletActionBlocker;
  PerpOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker =>
      _$this._walletActionBlocker;
  set walletActionBlocker(
          PerpOrderWalletActionStateWalletActionBlockerEnum?
              walletActionBlocker) =>
      _$this._walletActionBlocker = walletActionBlocker;

  PerpOrderWalletActionStateBuilder() {
    PerpOrderWalletActionState._defaults(this);
  }

  PerpOrderWalletActionStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quantity = $v.quantity;
      _kind = $v.kind;
      _nextAction = $v.nextAction;
      _walletActionBlocker = $v.walletActionBlocker;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PerpOrderWalletActionState other) {
    _$v = other as _$PerpOrderWalletActionState;
  }

  @override
  void update(void Function(PerpOrderWalletActionStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpOrderWalletActionState build() => _build();

  _$PerpOrderWalletActionState _build() {
    final _$result = _$v ??
        _$PerpOrderWalletActionState._(
          quantity: quantity,
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'PerpOrderWalletActionState', 'kind'),
          nextAction: nextAction,
          walletActionBlocker: BuiltValueNullFieldError.checkNotNull(
              walletActionBlocker,
              r'PerpOrderWalletActionState',
              'walletActionBlocker'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
