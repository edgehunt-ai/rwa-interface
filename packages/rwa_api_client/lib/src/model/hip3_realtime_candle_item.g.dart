// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_candle_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeCandleItemEventEnum
    _$hip3RealtimeCandleItemEventEnum_hip3Candle =
    const Hip3RealtimeCandleItemEventEnum._('hip3Candle');
const Hip3RealtimeCandleItemEventEnum
    _$hip3RealtimeCandleItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeCandleItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeCandleItemEventEnum _$hip3RealtimeCandleItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Candle':
      return _$hip3RealtimeCandleItemEventEnum_hip3Candle;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeCandleItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeCandleItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeCandleItemEventEnum>
    _$hip3RealtimeCandleItemEventEnumValues = BuiltSet<
        Hip3RealtimeCandleItemEventEnum>(const <Hip3RealtimeCandleItemEventEnum>[
  _$hip3RealtimeCandleItemEventEnum_hip3Candle,
  _$hip3RealtimeCandleItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeCandleItemEventEnum>
    _$hip3RealtimeCandleItemEventEnumSerializer =
    _$Hip3RealtimeCandleItemEventEnumSerializer();

class _$Hip3RealtimeCandleItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeCandleItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Candle': 'hip3_candle',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_candle': 'hip3Candle',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeCandleItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimeCandleItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeCandleItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeCandleItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeCandleItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeCandleItem extends Hip3RealtimeCandleItem {
  @override
  final Hip3RealtimeCandleItemEventEnum event;
  @override
  final Hip3RealtimeCandle data;

  factory _$Hip3RealtimeCandleItem(
          [void Function(Hip3RealtimeCandleItemBuilder)? updates]) =>
      (Hip3RealtimeCandleItemBuilder()..update(updates))._build();

  _$Hip3RealtimeCandleItem._({required this.event, required this.data})
      : super._();
  @override
  Hip3RealtimeCandleItem rebuild(
          void Function(Hip3RealtimeCandleItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeCandleItemBuilder toBuilder() =>
      Hip3RealtimeCandleItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeCandleItem &&
        event == other.event &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, event.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3RealtimeCandleItem')
          ..add('event', event)
          ..add('data', data))
        .toString();
  }
}

class Hip3RealtimeCandleItemBuilder
    implements Builder<Hip3RealtimeCandleItem, Hip3RealtimeCandleItemBuilder> {
  _$Hip3RealtimeCandleItem? _$v;

  Hip3RealtimeCandleItemEventEnum? _event;
  Hip3RealtimeCandleItemEventEnum? get event => _$this._event;
  set event(Hip3RealtimeCandleItemEventEnum? event) => _$this._event = event;

  Hip3RealtimeCandleBuilder? _data;
  Hip3RealtimeCandleBuilder get data =>
      _$this._data ??= Hip3RealtimeCandleBuilder();
  set data(Hip3RealtimeCandleBuilder? data) => _$this._data = data;

  Hip3RealtimeCandleItemBuilder() {
    Hip3RealtimeCandleItem._defaults(this);
  }

  Hip3RealtimeCandleItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _event = $v.event;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeCandleItem other) {
    _$v = other as _$Hip3RealtimeCandleItem;
  }

  @override
  void update(void Function(Hip3RealtimeCandleItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeCandleItem build() => _build();

  _$Hip3RealtimeCandleItem _build() {
    _$Hip3RealtimeCandleItem _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeCandleItem._(
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeCandleItem', 'event'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeCandleItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
