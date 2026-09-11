// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_price_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimePriceItemEventEnum
    _$hip3RealtimePriceItemEventEnum_hip3Price =
    const Hip3RealtimePriceItemEventEnum._('hip3Price');
const Hip3RealtimePriceItemEventEnum
    _$hip3RealtimePriceItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimePriceItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimePriceItemEventEnum _$hip3RealtimePriceItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Price':
      return _$hip3RealtimePriceItemEventEnum_hip3Price;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePriceItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePriceItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePriceItemEventEnum>
    _$hip3RealtimePriceItemEventEnumValues = BuiltSet<
        Hip3RealtimePriceItemEventEnum>(const <Hip3RealtimePriceItemEventEnum>[
  _$hip3RealtimePriceItemEventEnum_hip3Price,
  _$hip3RealtimePriceItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimePriceItemEventEnum>
    _$hip3RealtimePriceItemEventEnumSerializer =
    _$Hip3RealtimePriceItemEventEnumSerializer();

class _$Hip3RealtimePriceItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePriceItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Price': 'hip3_price',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_price': 'hip3Price',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimePriceItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimePriceItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePriceItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePriceItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePriceItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePriceItem extends Hip3RealtimePriceItem {
  @override
  final Hip3RealtimePriceItemEventEnum event;
  @override
  final Hip3RealtimePrice data;

  factory _$Hip3RealtimePriceItem(
          [void Function(Hip3RealtimePriceItemBuilder)? updates]) =>
      (Hip3RealtimePriceItemBuilder()..update(updates))._build();

  _$Hip3RealtimePriceItem._({required this.event, required this.data})
      : super._();
  @override
  Hip3RealtimePriceItem rebuild(
          void Function(Hip3RealtimePriceItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimePriceItemBuilder toBuilder() =>
      Hip3RealtimePriceItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimePriceItem &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimePriceItem')
          ..add('event', event)
          ..add('data', data))
        .toString();
  }
}

class Hip3RealtimePriceItemBuilder
    implements Builder<Hip3RealtimePriceItem, Hip3RealtimePriceItemBuilder> {
  _$Hip3RealtimePriceItem? _$v;

  Hip3RealtimePriceItemEventEnum? _event;
  Hip3RealtimePriceItemEventEnum? get event => _$this._event;
  set event(Hip3RealtimePriceItemEventEnum? event) => _$this._event = event;

  Hip3RealtimePriceBuilder? _data;
  Hip3RealtimePriceBuilder get data =>
      _$this._data ??= Hip3RealtimePriceBuilder();
  set data(Hip3RealtimePriceBuilder? data) => _$this._data = data;

  Hip3RealtimePriceItemBuilder() {
    Hip3RealtimePriceItem._defaults(this);
  }

  Hip3RealtimePriceItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _event = $v.event;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimePriceItem other) {
    _$v = other as _$Hip3RealtimePriceItem;
  }

  @override
  void update(void Function(Hip3RealtimePriceItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimePriceItem build() => _build();

  _$Hip3RealtimePriceItem _build() {
    _$Hip3RealtimePriceItem _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimePriceItem._(
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimePriceItem', 'event'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimePriceItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
