// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_activity_continuation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksActivityContinuationActionEnum
    _$bstocksActivityContinuationActionEnum_submitBstocksAction =
    const BstocksActivityContinuationActionEnum._('submitBstocksAction');
const BstocksActivityContinuationActionEnum
    _$bstocksActivityContinuationActionEnum_unknownDefaultOpenApi =
    const BstocksActivityContinuationActionEnum._('unknownDefaultOpenApi');

BstocksActivityContinuationActionEnum
    _$bstocksActivityContinuationActionEnumValueOf(String name) {
  switch (name) {
    case 'submitBstocksAction':
      return _$bstocksActivityContinuationActionEnum_submitBstocksAction;
    case 'unknownDefaultOpenApi':
      return _$bstocksActivityContinuationActionEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksActivityContinuationActionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksActivityContinuationActionEnum>
    _$bstocksActivityContinuationActionEnumValues = BuiltSet<
        BstocksActivityContinuationActionEnum>(const <BstocksActivityContinuationActionEnum>[
  _$bstocksActivityContinuationActionEnum_submitBstocksAction,
  _$bstocksActivityContinuationActionEnum_unknownDefaultOpenApi,
]);

const BstocksActivityContinuationStepEnum
    _$bstocksActivityContinuationStepEnum_walletSignature =
    const BstocksActivityContinuationStepEnum._('walletSignature');
const BstocksActivityContinuationStepEnum
    _$bstocksActivityContinuationStepEnum_unknownDefaultOpenApi =
    const BstocksActivityContinuationStepEnum._('unknownDefaultOpenApi');

BstocksActivityContinuationStepEnum
    _$bstocksActivityContinuationStepEnumValueOf(String name) {
  switch (name) {
    case 'walletSignature':
      return _$bstocksActivityContinuationStepEnum_walletSignature;
    case 'unknownDefaultOpenApi':
      return _$bstocksActivityContinuationStepEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksActivityContinuationStepEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksActivityContinuationStepEnum>
    _$bstocksActivityContinuationStepEnumValues = BuiltSet<
        BstocksActivityContinuationStepEnum>(const <BstocksActivityContinuationStepEnum>[
  _$bstocksActivityContinuationStepEnum_walletSignature,
  _$bstocksActivityContinuationStepEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksActivityContinuationActionEnum>
    _$bstocksActivityContinuationActionEnumSerializer =
    _$BstocksActivityContinuationActionEnumSerializer();
Serializer<BstocksActivityContinuationStepEnum>
    _$bstocksActivityContinuationStepEnumSerializer =
    _$BstocksActivityContinuationStepEnumSerializer();

class _$BstocksActivityContinuationActionEnumSerializer
    implements PrimitiveSerializer<BstocksActivityContinuationActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'submitBstocksAction': 'submit_bstocks_action',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'submit_bstocks_action': 'submitBstocksAction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksActivityContinuationActionEnum
  ];
  @override
  final String wireName = 'BstocksActivityContinuationActionEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksActivityContinuationActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksActivityContinuationActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksActivityContinuationActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksActivityContinuationStepEnumSerializer
    implements PrimitiveSerializer<BstocksActivityContinuationStepEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'walletSignature': 'wallet_signature',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet_signature': 'walletSignature',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksActivityContinuationStepEnum
  ];
  @override
  final String wireName = 'BstocksActivityContinuationStepEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksActivityContinuationStepEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksActivityContinuationStepEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksActivityContinuationStepEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksActivityContinuation extends BstocksActivityContinuation {
  @override
  final BstocksActivityContinuationActionEnum action;
  @override
  final String actionId;
  @override
  final BstocksActivityContinuationStepEnum step;
  @override
  final bool requiresNewBusinessObject;

  factory _$BstocksActivityContinuation(
          [void Function(BstocksActivityContinuationBuilder)? updates]) =>
      (BstocksActivityContinuationBuilder()..update(updates))._build();

  _$BstocksActivityContinuation._(
      {required this.action,
      required this.actionId,
      required this.step,
      required this.requiresNewBusinessObject})
      : super._();
  @override
  BstocksActivityContinuation rebuild(
          void Function(BstocksActivityContinuationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksActivityContinuationBuilder toBuilder() =>
      BstocksActivityContinuationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksActivityContinuation &&
        action == other.action &&
        actionId == other.actionId &&
        step == other.step &&
        requiresNewBusinessObject == other.requiresNewBusinessObject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, step.hashCode);
    _$hash = $jc(_$hash, requiresNewBusinessObject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksActivityContinuation')
          ..add('action', action)
          ..add('actionId', actionId)
          ..add('step', step)
          ..add('requiresNewBusinessObject', requiresNewBusinessObject))
        .toString();
  }
}

class BstocksActivityContinuationBuilder
    implements
        Builder<BstocksActivityContinuation,
            BstocksActivityContinuationBuilder> {
  _$BstocksActivityContinuation? _$v;

  BstocksActivityContinuationActionEnum? _action;
  BstocksActivityContinuationActionEnum? get action => _$this._action;
  set action(BstocksActivityContinuationActionEnum? action) =>
      _$this._action = action;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  BstocksActivityContinuationStepEnum? _step;
  BstocksActivityContinuationStepEnum? get step => _$this._step;
  set step(BstocksActivityContinuationStepEnum? step) => _$this._step = step;

  bool? _requiresNewBusinessObject;
  bool? get requiresNewBusinessObject => _$this._requiresNewBusinessObject;
  set requiresNewBusinessObject(bool? requiresNewBusinessObject) =>
      _$this._requiresNewBusinessObject = requiresNewBusinessObject;

  BstocksActivityContinuationBuilder() {
    BstocksActivityContinuation._defaults(this);
  }

  BstocksActivityContinuationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _actionId = $v.actionId;
      _step = $v.step;
      _requiresNewBusinessObject = $v.requiresNewBusinessObject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksActivityContinuation other) {
    _$v = other as _$BstocksActivityContinuation;
  }

  @override
  void update(void Function(BstocksActivityContinuationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksActivityContinuation build() => _build();

  _$BstocksActivityContinuation _build() {
    final _$result = _$v ??
        _$BstocksActivityContinuation._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'BstocksActivityContinuation', 'action'),
          actionId: BuiltValueNullFieldError.checkNotNull(
              actionId, r'BstocksActivityContinuation', 'actionId'),
          step: BuiltValueNullFieldError.checkNotNull(
              step, r'BstocksActivityContinuation', 'step'),
          requiresNewBusinessObject: BuiltValueNullFieldError.checkNotNull(
              requiresNewBusinessObject,
              r'BstocksActivityContinuation',
              'requiresNewBusinessObject'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
