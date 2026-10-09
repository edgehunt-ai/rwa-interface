// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_activity_continuation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksActivityContinuationActionEnum
    _$bstocksActivityContinuationActionEnum_previewBstocksOrder =
    const BstocksActivityContinuationActionEnum._('previewBstocksOrder');

BstocksActivityContinuationActionEnum
    _$bstocksActivityContinuationActionEnumValueOf(String name) {
  switch (name) {
    case 'previewBstocksOrder':
      return _$bstocksActivityContinuationActionEnum_previewBstocksOrder;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksActivityContinuationActionEnum>
    _$bstocksActivityContinuationActionEnumValues = BuiltSet<
        BstocksActivityContinuationActionEnum>(const <BstocksActivityContinuationActionEnum>[
  _$bstocksActivityContinuationActionEnum_previewBstocksOrder,
]);

const BstocksActivityContinuationStepEnum
    _$bstocksActivityContinuationStepEnum_orderPreview =
    const BstocksActivityContinuationStepEnum._('orderPreview');

BstocksActivityContinuationStepEnum
    _$bstocksActivityContinuationStepEnumValueOf(String name) {
  switch (name) {
    case 'orderPreview':
      return _$bstocksActivityContinuationStepEnum_orderPreview;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksActivityContinuationStepEnum>
    _$bstocksActivityContinuationStepEnumValues = BuiltSet<
        BstocksActivityContinuationStepEnum>(const <BstocksActivityContinuationStepEnum>[
  _$bstocksActivityContinuationStepEnum_orderPreview,
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
    'previewBstocksOrder': 'preview_bstocks_order',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'preview_bstocks_order': 'previewBstocksOrder',
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
    'orderPreview': 'order_preview',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order_preview': 'orderPreview',
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
  final OneOf oneOf;

  factory _$BstocksActivityContinuation(
          [void Function(BstocksActivityContinuationBuilder)? updates]) =>
      (BstocksActivityContinuationBuilder()..update(updates))._build();

  _$BstocksActivityContinuation._({required this.oneOf}) : super._();
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
    return other is BstocksActivityContinuation && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'BstocksActivityContinuation')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class BstocksActivityContinuationBuilder
    implements
        Builder<BstocksActivityContinuation,
            BstocksActivityContinuationBuilder> {
  _$BstocksActivityContinuation? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  BstocksActivityContinuationBuilder() {
    BstocksActivityContinuation._defaults(this);
  }

  BstocksActivityContinuationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
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
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'BstocksActivityContinuation', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
