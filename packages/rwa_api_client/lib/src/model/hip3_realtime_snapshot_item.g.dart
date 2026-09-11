// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_snapshot_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeSnapshotItemEventEnum
    _$hip3RealtimeSnapshotItemEventEnum_hip3Candle =
    const Hip3RealtimeSnapshotItemEventEnum._('hip3Candle');
const Hip3RealtimeSnapshotItemEventEnum
    _$hip3RealtimeSnapshotItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeSnapshotItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeSnapshotItemEventEnum _$hip3RealtimeSnapshotItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Candle':
      return _$hip3RealtimeSnapshotItemEventEnum_hip3Candle;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeSnapshotItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeSnapshotItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeSnapshotItemEventEnum>
    _$hip3RealtimeSnapshotItemEventEnumValues = BuiltSet<
        Hip3RealtimeSnapshotItemEventEnum>(const <Hip3RealtimeSnapshotItemEventEnum>[
  _$hip3RealtimeSnapshotItemEventEnum_hip3Candle,
  _$hip3RealtimeSnapshotItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeSnapshotItemEventEnum>
    _$hip3RealtimeSnapshotItemEventEnumSerializer =
    _$Hip3RealtimeSnapshotItemEventEnumSerializer();

class _$Hip3RealtimeSnapshotItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeSnapshotItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Candle': 'hip3_candle',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_candle': 'hip3Candle',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeSnapshotItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimeSnapshotItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeSnapshotItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeSnapshotItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeSnapshotItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeSnapshotItem extends Hip3RealtimeSnapshotItem {
  @override
  final OneOf oneOf;

  factory _$Hip3RealtimeSnapshotItem(
          [void Function(Hip3RealtimeSnapshotItemBuilder)? updates]) =>
      (Hip3RealtimeSnapshotItemBuilder()..update(updates))._build();

  _$Hip3RealtimeSnapshotItem._({required this.oneOf}) : super._();
  @override
  Hip3RealtimeSnapshotItem rebuild(
          void Function(Hip3RealtimeSnapshotItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeSnapshotItemBuilder toBuilder() =>
      Hip3RealtimeSnapshotItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeSnapshotItem && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeSnapshotItem')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class Hip3RealtimeSnapshotItemBuilder
    implements
        Builder<Hip3RealtimeSnapshotItem, Hip3RealtimeSnapshotItemBuilder> {
  _$Hip3RealtimeSnapshotItem? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  Hip3RealtimeSnapshotItemBuilder() {
    Hip3RealtimeSnapshotItem._defaults(this);
  }

  Hip3RealtimeSnapshotItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeSnapshotItem other) {
    _$v = other as _$Hip3RealtimeSnapshotItem;
  }

  @override
  void update(void Function(Hip3RealtimeSnapshotItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeSnapshotItem build() => _build();

  _$Hip3RealtimeSnapshotItem _build() {
    final _$result = _$v ??
        _$Hip3RealtimeSnapshotItem._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'Hip3RealtimeSnapshotItem', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
