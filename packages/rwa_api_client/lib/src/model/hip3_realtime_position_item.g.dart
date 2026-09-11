// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_position_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimePositionItemEventEnum
    _$hip3RealtimePositionItemEventEnum_hip3Position =
    const Hip3RealtimePositionItemEventEnum._('hip3Position');
const Hip3RealtimePositionItemEventEnum
    _$hip3RealtimePositionItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimePositionItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimePositionItemEventEnum _$hip3RealtimePositionItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Position':
      return _$hip3RealtimePositionItemEventEnum_hip3Position;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePositionItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePositionItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePositionItemEventEnum>
    _$hip3RealtimePositionItemEventEnumValues = BuiltSet<
        Hip3RealtimePositionItemEventEnum>(const <Hip3RealtimePositionItemEventEnum>[
  _$hip3RealtimePositionItemEventEnum_hip3Position,
  _$hip3RealtimePositionItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimePositionItemEventEnum>
    _$hip3RealtimePositionItemEventEnumSerializer =
    _$Hip3RealtimePositionItemEventEnumSerializer();

class _$Hip3RealtimePositionItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePositionItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Position': 'hip3_position',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_position': 'hip3Position',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimePositionItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimePositionItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePositionItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePositionItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePositionItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePositionItem extends Hip3RealtimePositionItem {
  @override
  final Hip3RealtimePositionItemEventEnum event;
  @override
  final Position data;

  factory _$Hip3RealtimePositionItem(
          [void Function(Hip3RealtimePositionItemBuilder)? updates]) =>
      (Hip3RealtimePositionItemBuilder()..update(updates))._build();

  _$Hip3RealtimePositionItem._({required this.event, required this.data})
      : super._();
  @override
  Hip3RealtimePositionItem rebuild(
          void Function(Hip3RealtimePositionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimePositionItemBuilder toBuilder() =>
      Hip3RealtimePositionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimePositionItem &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimePositionItem')
          ..add('event', event)
          ..add('data', data))
        .toString();
  }
}

class Hip3RealtimePositionItemBuilder
    implements
        Builder<Hip3RealtimePositionItem, Hip3RealtimePositionItemBuilder> {
  _$Hip3RealtimePositionItem? _$v;

  Hip3RealtimePositionItemEventEnum? _event;
  Hip3RealtimePositionItemEventEnum? get event => _$this._event;
  set event(Hip3RealtimePositionItemEventEnum? event) => _$this._event = event;

  PositionBuilder? _data;
  PositionBuilder get data => _$this._data ??= PositionBuilder();
  set data(PositionBuilder? data) => _$this._data = data;

  Hip3RealtimePositionItemBuilder() {
    Hip3RealtimePositionItem._defaults(this);
  }

  Hip3RealtimePositionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _event = $v.event;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimePositionItem other) {
    _$v = other as _$Hip3RealtimePositionItem;
  }

  @override
  void update(void Function(Hip3RealtimePositionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimePositionItem build() => _build();

  _$Hip3RealtimePositionItem _build() {
    _$Hip3RealtimePositionItem _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimePositionItem._(
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimePositionItem', 'event'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimePositionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
