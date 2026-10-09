// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_preview_continuation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksPreviewContinuationActionEnum
    _$bstocksPreviewContinuationActionEnum_previewBstocksOrder =
    const BstocksPreviewContinuationActionEnum._('previewBstocksOrder');

BstocksPreviewContinuationActionEnum
    _$bstocksPreviewContinuationActionEnumValueOf(String name) {
  switch (name) {
    case 'previewBstocksOrder':
      return _$bstocksPreviewContinuationActionEnum_previewBstocksOrder;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksPreviewContinuationActionEnum>
    _$bstocksPreviewContinuationActionEnumValues = BuiltSet<
        BstocksPreviewContinuationActionEnum>(const <BstocksPreviewContinuationActionEnum>[
  _$bstocksPreviewContinuationActionEnum_previewBstocksOrder,
]);

const BstocksPreviewContinuationStepEnum
    _$bstocksPreviewContinuationStepEnum_orderPreview =
    const BstocksPreviewContinuationStepEnum._('orderPreview');

BstocksPreviewContinuationStepEnum _$bstocksPreviewContinuationStepEnumValueOf(
    String name) {
  switch (name) {
    case 'orderPreview':
      return _$bstocksPreviewContinuationStepEnum_orderPreview;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksPreviewContinuationStepEnum>
    _$bstocksPreviewContinuationStepEnumValues = BuiltSet<
        BstocksPreviewContinuationStepEnum>(const <BstocksPreviewContinuationStepEnum>[
  _$bstocksPreviewContinuationStepEnum_orderPreview,
]);

Serializer<BstocksPreviewContinuationActionEnum>
    _$bstocksPreviewContinuationActionEnumSerializer =
    _$BstocksPreviewContinuationActionEnumSerializer();
Serializer<BstocksPreviewContinuationStepEnum>
    _$bstocksPreviewContinuationStepEnumSerializer =
    _$BstocksPreviewContinuationStepEnumSerializer();

class _$BstocksPreviewContinuationActionEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewContinuationActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'previewBstocksOrder': 'preview_bstocks_order',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'preview_bstocks_order': 'previewBstocksOrder',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksPreviewContinuationActionEnum
  ];
  @override
  final String wireName = 'BstocksPreviewContinuationActionEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksPreviewContinuationActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewContinuationActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewContinuationActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewContinuationStepEnumSerializer
    implements PrimitiveSerializer<BstocksPreviewContinuationStepEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'orderPreview': 'order_preview',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order_preview': 'orderPreview',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksPreviewContinuationStepEnum];
  @override
  final String wireName = 'BstocksPreviewContinuationStepEnum';

  @override
  Object serialize(
          Serializers serializers, BstocksPreviewContinuationStepEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksPreviewContinuationStepEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksPreviewContinuationStepEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksPreviewContinuation extends BstocksPreviewContinuation {
  @override
  final BstocksPreviewContinuationActionEnum action;
  @override
  final String orderId;
  @override
  final BstocksPreviewContinuationStepEnum step;
  @override
  final bool requiresNewBusinessObject;

  factory _$BstocksPreviewContinuation(
          [void Function(BstocksPreviewContinuationBuilder)? updates]) =>
      (BstocksPreviewContinuationBuilder()..update(updates))._build();

  _$BstocksPreviewContinuation._(
      {required this.action,
      required this.orderId,
      required this.step,
      required this.requiresNewBusinessObject})
      : super._();
  @override
  BstocksPreviewContinuation rebuild(
          void Function(BstocksPreviewContinuationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksPreviewContinuationBuilder toBuilder() =>
      BstocksPreviewContinuationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksPreviewContinuation &&
        action == other.action &&
        orderId == other.orderId &&
        step == other.step &&
        requiresNewBusinessObject == other.requiresNewBusinessObject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, step.hashCode);
    _$hash = $jc(_$hash, requiresNewBusinessObject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksPreviewContinuation')
          ..add('action', action)
          ..add('orderId', orderId)
          ..add('step', step)
          ..add('requiresNewBusinessObject', requiresNewBusinessObject))
        .toString();
  }
}

class BstocksPreviewContinuationBuilder
    implements
        Builder<BstocksPreviewContinuation, BstocksPreviewContinuationBuilder> {
  _$BstocksPreviewContinuation? _$v;

  BstocksPreviewContinuationActionEnum? _action;
  BstocksPreviewContinuationActionEnum? get action => _$this._action;
  set action(BstocksPreviewContinuationActionEnum? action) =>
      _$this._action = action;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  BstocksPreviewContinuationStepEnum? _step;
  BstocksPreviewContinuationStepEnum? get step => _$this._step;
  set step(BstocksPreviewContinuationStepEnum? step) => _$this._step = step;

  bool? _requiresNewBusinessObject;
  bool? get requiresNewBusinessObject => _$this._requiresNewBusinessObject;
  set requiresNewBusinessObject(bool? requiresNewBusinessObject) =>
      _$this._requiresNewBusinessObject = requiresNewBusinessObject;

  BstocksPreviewContinuationBuilder() {
    BstocksPreviewContinuation._defaults(this);
  }

  BstocksPreviewContinuationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _orderId = $v.orderId;
      _step = $v.step;
      _requiresNewBusinessObject = $v.requiresNewBusinessObject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksPreviewContinuation other) {
    _$v = other as _$BstocksPreviewContinuation;
  }

  @override
  void update(void Function(BstocksPreviewContinuationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksPreviewContinuation build() => _build();

  _$BstocksPreviewContinuation _build() {
    final _$result = _$v ??
        _$BstocksPreviewContinuation._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'BstocksPreviewContinuation', 'action'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'BstocksPreviewContinuation', 'orderId'),
          step: BuiltValueNullFieldError.checkNotNull(
              step, r'BstocksPreviewContinuation', 'step'),
          requiresNewBusinessObject: BuiltValueNullFieldError.checkNotNull(
              requiresNewBusinessObject,
              r'BstocksPreviewContinuation',
              'requiresNewBusinessObject'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
