// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_balance_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeBalanceItemEventEnum
    _$hip3RealtimeBalanceItemEventEnum_hip3Balance =
    const Hip3RealtimeBalanceItemEventEnum._('hip3Balance');
const Hip3RealtimeBalanceItemEventEnum
    _$hip3RealtimeBalanceItemEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeBalanceItemEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeBalanceItemEventEnum _$hip3RealtimeBalanceItemEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Balance':
      return _$hip3RealtimeBalanceItemEventEnum_hip3Balance;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeBalanceItemEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeBalanceItemEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeBalanceItemEventEnum>
    _$hip3RealtimeBalanceItemEventEnumValues = BuiltSet<
        Hip3RealtimeBalanceItemEventEnum>(const <Hip3RealtimeBalanceItemEventEnum>[
  _$hip3RealtimeBalanceItemEventEnum_hip3Balance,
  _$hip3RealtimeBalanceItemEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeBalanceItemEventEnum>
    _$hip3RealtimeBalanceItemEventEnumSerializer =
    _$Hip3RealtimeBalanceItemEventEnumSerializer();

class _$Hip3RealtimeBalanceItemEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeBalanceItemEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Balance': 'hip3_balance',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_balance': 'hip3Balance',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeBalanceItemEventEnum];
  @override
  final String wireName = 'Hip3RealtimeBalanceItemEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeBalanceItemEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeBalanceItemEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeBalanceItemEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeBalanceItem extends Hip3RealtimeBalanceItem {
  @override
  final Hip3RealtimeBalanceItemEventEnum event;
  @override
  final Hip3RealtimeBalance data;

  factory _$Hip3RealtimeBalanceItem(
          [void Function(Hip3RealtimeBalanceItemBuilder)? updates]) =>
      (Hip3RealtimeBalanceItemBuilder()..update(updates))._build();

  _$Hip3RealtimeBalanceItem._({required this.event, required this.data})
      : super._();
  @override
  Hip3RealtimeBalanceItem rebuild(
          void Function(Hip3RealtimeBalanceItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeBalanceItemBuilder toBuilder() =>
      Hip3RealtimeBalanceItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeBalanceItem &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeBalanceItem')
          ..add('event', event)
          ..add('data', data))
        .toString();
  }
}

class Hip3RealtimeBalanceItemBuilder
    implements
        Builder<Hip3RealtimeBalanceItem, Hip3RealtimeBalanceItemBuilder> {
  _$Hip3RealtimeBalanceItem? _$v;

  Hip3RealtimeBalanceItemEventEnum? _event;
  Hip3RealtimeBalanceItemEventEnum? get event => _$this._event;
  set event(Hip3RealtimeBalanceItemEventEnum? event) => _$this._event = event;

  Hip3RealtimeBalanceBuilder? _data;
  Hip3RealtimeBalanceBuilder get data =>
      _$this._data ??= Hip3RealtimeBalanceBuilder();
  set data(Hip3RealtimeBalanceBuilder? data) => _$this._data = data;

  Hip3RealtimeBalanceItemBuilder() {
    Hip3RealtimeBalanceItem._defaults(this);
  }

  Hip3RealtimeBalanceItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _event = $v.event;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeBalanceItem other) {
    _$v = other as _$Hip3RealtimeBalanceItem;
  }

  @override
  void update(void Function(Hip3RealtimeBalanceItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeBalanceItem build() => _build();

  _$Hip3RealtimeBalanceItem _build() {
    _$Hip3RealtimeBalanceItem _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeBalanceItem._(
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeBalanceItem', 'event'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeBalanceItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
