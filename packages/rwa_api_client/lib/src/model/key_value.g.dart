// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KeyValueToneEnum _$keyValueToneEnum_default_ =
    const KeyValueToneEnum._('default_');
const KeyValueToneEnum _$keyValueToneEnum_positive =
    const KeyValueToneEnum._('positive');
const KeyValueToneEnum _$keyValueToneEnum_negative =
    const KeyValueToneEnum._('negative');
const KeyValueToneEnum _$keyValueToneEnum_muted =
    const KeyValueToneEnum._('muted');
const KeyValueToneEnum _$keyValueToneEnum_unknownDefaultOpenApi =
    const KeyValueToneEnum._('unknownDefaultOpenApi');

KeyValueToneEnum _$keyValueToneEnumValueOf(String name) {
  switch (name) {
    case 'default_':
      return _$keyValueToneEnum_default_;
    case 'positive':
      return _$keyValueToneEnum_positive;
    case 'negative':
      return _$keyValueToneEnum_negative;
    case 'muted':
      return _$keyValueToneEnum_muted;
    case 'unknownDefaultOpenApi':
      return _$keyValueToneEnum_unknownDefaultOpenApi;
    default:
      return _$keyValueToneEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<KeyValueToneEnum> _$keyValueToneEnumValues =
    BuiltSet<KeyValueToneEnum>(const <KeyValueToneEnum>[
  _$keyValueToneEnum_default_,
  _$keyValueToneEnum_positive,
  _$keyValueToneEnum_negative,
  _$keyValueToneEnum_muted,
  _$keyValueToneEnum_unknownDefaultOpenApi,
]);

Serializer<KeyValueToneEnum> _$keyValueToneEnumSerializer =
    _$KeyValueToneEnumSerializer();

class _$KeyValueToneEnumSerializer
    implements PrimitiveSerializer<KeyValueToneEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'default_': 'default',
    'positive': 'positive',
    'negative': 'negative',
    'muted': 'muted',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'default': 'default_',
    'positive': 'positive',
    'negative': 'negative',
    'muted': 'muted',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[KeyValueToneEnum];
  @override
  final String wireName = 'KeyValueToneEnum';

  @override
  Object serialize(Serializers serializers, KeyValueToneEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KeyValueToneEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KeyValueToneEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KeyValue extends KeyValue {
  @override
  final String label;
  @override
  final String value;
  @override
  final KeyValueToneEnum? tone;

  factory _$KeyValue([void Function(KeyValueBuilder)? updates]) =>
      (KeyValueBuilder()..update(updates))._build();

  _$KeyValue._({required this.label, required this.value, this.tone})
      : super._();
  @override
  KeyValue rebuild(void Function(KeyValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyValueBuilder toBuilder() => KeyValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyValue &&
        label == other.label &&
        value == other.value &&
        tone == other.tone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, tone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KeyValue')
          ..add('label', label)
          ..add('value', value)
          ..add('tone', tone))
        .toString();
  }
}

class KeyValueBuilder implements Builder<KeyValue, KeyValueBuilder> {
  _$KeyValue? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  KeyValueToneEnum? _tone;
  KeyValueToneEnum? get tone => _$this._tone;
  set tone(KeyValueToneEnum? tone) => _$this._tone = tone;

  KeyValueBuilder() {
    KeyValue._defaults(this);
  }

  KeyValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _value = $v.value;
      _tone = $v.tone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KeyValue other) {
    _$v = other as _$KeyValue;
  }

  @override
  void update(void Function(KeyValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KeyValue build() => _build();

  _$KeyValue _build() {
    final _$result = _$v ??
        _$KeyValue._(
          label: BuiltValueNullFieldError.checkNotNull(
              label, r'KeyValue', 'label'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'KeyValue', 'value'),
          tone: tone,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
