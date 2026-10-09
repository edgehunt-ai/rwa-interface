// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_signature_continuation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksSignatureContinuationActionEnum
    _$bstocksSignatureContinuationActionEnum_submitBstocksAction =
    const BstocksSignatureContinuationActionEnum._('submitBstocksAction');

BstocksSignatureContinuationActionEnum
    _$bstocksSignatureContinuationActionEnumValueOf(String name) {
  switch (name) {
    case 'submitBstocksAction':
      return _$bstocksSignatureContinuationActionEnum_submitBstocksAction;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksSignatureContinuationActionEnum>
    _$bstocksSignatureContinuationActionEnumValues = BuiltSet<
        BstocksSignatureContinuationActionEnum>(const <BstocksSignatureContinuationActionEnum>[
  _$bstocksSignatureContinuationActionEnum_submitBstocksAction,
]);

const BstocksSignatureContinuationStepEnum
    _$bstocksSignatureContinuationStepEnum_walletSignature =
    const BstocksSignatureContinuationStepEnum._('walletSignature');

BstocksSignatureContinuationStepEnum
    _$bstocksSignatureContinuationStepEnumValueOf(String name) {
  switch (name) {
    case 'walletSignature':
      return _$bstocksSignatureContinuationStepEnum_walletSignature;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksSignatureContinuationStepEnum>
    _$bstocksSignatureContinuationStepEnumValues = BuiltSet<
        BstocksSignatureContinuationStepEnum>(const <BstocksSignatureContinuationStepEnum>[
  _$bstocksSignatureContinuationStepEnum_walletSignature,
]);

Serializer<BstocksSignatureContinuationActionEnum>
    _$bstocksSignatureContinuationActionEnumSerializer =
    _$BstocksSignatureContinuationActionEnumSerializer();
Serializer<BstocksSignatureContinuationStepEnum>
    _$bstocksSignatureContinuationStepEnumSerializer =
    _$BstocksSignatureContinuationStepEnumSerializer();

class _$BstocksSignatureContinuationActionEnumSerializer
    implements PrimitiveSerializer<BstocksSignatureContinuationActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'submitBstocksAction': 'submit_bstocks_action',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'submit_bstocks_action': 'submitBstocksAction',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksSignatureContinuationActionEnum
  ];
  @override
  final String wireName = 'BstocksSignatureContinuationActionEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksSignatureContinuationActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksSignatureContinuationActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksSignatureContinuationActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksSignatureContinuationStepEnumSerializer
    implements PrimitiveSerializer<BstocksSignatureContinuationStepEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'walletSignature': 'wallet_signature',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet_signature': 'walletSignature',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksSignatureContinuationStepEnum
  ];
  @override
  final String wireName = 'BstocksSignatureContinuationStepEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksSignatureContinuationStepEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksSignatureContinuationStepEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksSignatureContinuationStepEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksSignatureContinuation extends BstocksSignatureContinuation {
  @override
  final BstocksSignatureContinuationActionEnum action;
  @override
  final String orderId;
  @override
  final String actionId;
  @override
  final BstocksSignatureContinuationStepEnum step;
  @override
  final bool requiresNewBusinessObject;

  factory _$BstocksSignatureContinuation(
          [void Function(BstocksSignatureContinuationBuilder)? updates]) =>
      (BstocksSignatureContinuationBuilder()..update(updates))._build();

  _$BstocksSignatureContinuation._(
      {required this.action,
      required this.orderId,
      required this.actionId,
      required this.step,
      required this.requiresNewBusinessObject})
      : super._();
  @override
  BstocksSignatureContinuation rebuild(
          void Function(BstocksSignatureContinuationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksSignatureContinuationBuilder toBuilder() =>
      BstocksSignatureContinuationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksSignatureContinuation &&
        action == other.action &&
        orderId == other.orderId &&
        actionId == other.actionId &&
        step == other.step &&
        requiresNewBusinessObject == other.requiresNewBusinessObject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, step.hashCode);
    _$hash = $jc(_$hash, requiresNewBusinessObject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksSignatureContinuation')
          ..add('action', action)
          ..add('orderId', orderId)
          ..add('actionId', actionId)
          ..add('step', step)
          ..add('requiresNewBusinessObject', requiresNewBusinessObject))
        .toString();
  }
}

class BstocksSignatureContinuationBuilder
    implements
        Builder<BstocksSignatureContinuation,
            BstocksSignatureContinuationBuilder> {
  _$BstocksSignatureContinuation? _$v;

  BstocksSignatureContinuationActionEnum? _action;
  BstocksSignatureContinuationActionEnum? get action => _$this._action;
  set action(BstocksSignatureContinuationActionEnum? action) =>
      _$this._action = action;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  BstocksSignatureContinuationStepEnum? _step;
  BstocksSignatureContinuationStepEnum? get step => _$this._step;
  set step(BstocksSignatureContinuationStepEnum? step) => _$this._step = step;

  bool? _requiresNewBusinessObject;
  bool? get requiresNewBusinessObject => _$this._requiresNewBusinessObject;
  set requiresNewBusinessObject(bool? requiresNewBusinessObject) =>
      _$this._requiresNewBusinessObject = requiresNewBusinessObject;

  BstocksSignatureContinuationBuilder() {
    BstocksSignatureContinuation._defaults(this);
  }

  BstocksSignatureContinuationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _orderId = $v.orderId;
      _actionId = $v.actionId;
      _step = $v.step;
      _requiresNewBusinessObject = $v.requiresNewBusinessObject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksSignatureContinuation other) {
    _$v = other as _$BstocksSignatureContinuation;
  }

  @override
  void update(void Function(BstocksSignatureContinuationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksSignatureContinuation build() => _build();

  _$BstocksSignatureContinuation _build() {
    final _$result = _$v ??
        _$BstocksSignatureContinuation._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'BstocksSignatureContinuation', 'action'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'BstocksSignatureContinuation', 'orderId'),
          actionId: BuiltValueNullFieldError.checkNotNull(
              actionId, r'BstocksSignatureContinuation', 'actionId'),
          step: BuiltValueNullFieldError.checkNotNull(
              step, r'BstocksSignatureContinuation', 'step'),
          requiresNewBusinessObject: BuiltValueNullFieldError.checkNotNull(
              requiresNewBusinessObject,
              r'BstocksSignatureContinuation',
              'requiresNewBusinessObject'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
