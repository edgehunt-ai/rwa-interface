// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_order_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeOrderItemEventEnum
    _$hip3RealtimeOrderItemEventEnum_hip3Order =
    const Hip3RealtimeOrderItemEventEnum._('hip3Order');
const Hip3RealtimeOrderItemEventEnum
    _$hip3RealtimeOrderItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeOrderItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeOrderItemEventEnum _$hip3RealtimeOrderItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Order':
      return _$hip3RealtimeOrderItemEventEnum_hip3Order;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeOrderItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeOrderItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeOrderItemEventEnum>
    _$hip3RealtimeOrderItemEventEnumValues = BuiltSet<
        Hip3RealtimeOrderItemEventEnum>(const <Hip3RealtimeOrderItemEventEnum>[
  _$hip3RealtimeOrderItemEventEnum_hip3Order,
  _$hip3RealtimeOrderItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeOrderItemEventEnum>
    _$hip3RealtimeOrderItemEventEnumSerializer =
    _$Hip3RealtimeOrderItemEventEnumSerializer();

class _$Hip3RealtimeOrderItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeOrderItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Order': 'hip3_order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_order': 'hip3Order',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeOrderItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimeOrderItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeOrderItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeOrderItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeOrderItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeOrderItem extends Hip3RealtimeOrderItem {
  @override
  final Hip3RealtimeOrderItemEventEnum event;
  @override
  final Order data;

  factory _$Hip3RealtimeOrderItem(
          [void Function(Hip3RealtimeOrderItemBuilder)? updates]) =>
      (Hip3RealtimeOrderItemBuilder()..update(updates))._build();

  _$Hip3RealtimeOrderItem._({required this.event, required this.data})
      : super._();
  @override
  Hip3RealtimeOrderItem rebuild(
          void Function(Hip3RealtimeOrderItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeOrderItemBuilder toBuilder() =>
      Hip3RealtimeOrderItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeOrderItem &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeOrderItem')
          ..add('event', event)
          ..add('data', data))
        .toString();
  }
}

class Hip3RealtimeOrderItemBuilder
    implements Builder<Hip3RealtimeOrderItem, Hip3RealtimeOrderItemBuilder> {
  _$Hip3RealtimeOrderItem? _$v;

  Hip3RealtimeOrderItemEventEnum? _event;
  Hip3RealtimeOrderItemEventEnum? get event => _$this._event;
  set event(Hip3RealtimeOrderItemEventEnum? event) => _$this._event = event;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(OrderBuilder? data) => _$this._data = data;

  Hip3RealtimeOrderItemBuilder() {
    Hip3RealtimeOrderItem._defaults(this);
  }

  Hip3RealtimeOrderItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _event = $v.event;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeOrderItem other) {
    _$v = other as _$Hip3RealtimeOrderItem;
  }

  @override
  void update(void Function(Hip3RealtimeOrderItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeOrderItem build() => _build();

  _$Hip3RealtimeOrderItem _build() {
    _$Hip3RealtimeOrderItem _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeOrderItem._(
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeOrderItem', 'event'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeOrderItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
