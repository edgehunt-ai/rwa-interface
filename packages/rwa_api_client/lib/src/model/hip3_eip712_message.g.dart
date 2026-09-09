// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_eip712_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Eip712MessageSource_Enum _$hip3Eip712MessageSourceEnum_a =
    const Hip3Eip712MessageSource_Enum._('a');
const Hip3Eip712MessageSource_Enum _$hip3Eip712MessageSourceEnum_b =
    const Hip3Eip712MessageSource_Enum._('b');
const Hip3Eip712MessageSource_Enum
    _$hip3Eip712MessageSourceEnum_unknownDefaultOpenApi =
    const Hip3Eip712MessageSource_Enum._('unknownDefaultOpenApi');

Hip3Eip712MessageSource_Enum _$hip3Eip712MessageSourceEnumValueOf(String name) {
  switch (name) {
    case 'a':
      return _$hip3Eip712MessageSourceEnum_a;
    case 'b':
      return _$hip3Eip712MessageSourceEnum_b;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712MessageSourceEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712MessageSourceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712MessageSource_Enum>
    _$hip3Eip712MessageSourceEnumValues =
    BuiltSet<Hip3Eip712MessageSource_Enum>(const <Hip3Eip712MessageSource_Enum>[
  _$hip3Eip712MessageSourceEnum_a,
  _$hip3Eip712MessageSourceEnum_b,
  _$hip3Eip712MessageSourceEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3Eip712MessageSource_Enum>
    _$hip3Eip712MessageSourceEnumSerializer =
    _$Hip3Eip712MessageSource_EnumSerializer();

class _$Hip3Eip712MessageSource_EnumSerializer
    implements PrimitiveSerializer<Hip3Eip712MessageSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'a': 'a',
    'b': 'b',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'a': 'a',
    'b': 'b',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712MessageSource_Enum];
  @override
  final String wireName = 'Hip3Eip712MessageSource_Enum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712MessageSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712MessageSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712MessageSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712Message extends Hip3Eip712Message {
  @override
  final Hip3Eip712MessageSource_Enum source_;
  @override
  final String connectionId;

  factory _$Hip3Eip712Message(
          [void Function(Hip3Eip712MessageBuilder)? updates]) =>
      (Hip3Eip712MessageBuilder()..update(updates))._build();

  _$Hip3Eip712Message._({required this.source_, required this.connectionId})
      : super._();
  @override
  Hip3Eip712Message rebuild(void Function(Hip3Eip712MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3Eip712MessageBuilder toBuilder() =>
      Hip3Eip712MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Eip712Message &&
        source_ == other.source_ &&
        connectionId == other.connectionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, connectionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Eip712Message')
          ..add('source_', source_)
          ..add('connectionId', connectionId))
        .toString();
  }
}

class Hip3Eip712MessageBuilder
    implements Builder<Hip3Eip712Message, Hip3Eip712MessageBuilder> {
  _$Hip3Eip712Message? _$v;

  Hip3Eip712MessageSource_Enum? _source_;
  Hip3Eip712MessageSource_Enum? get source_ => _$this._source_;
  set source_(Hip3Eip712MessageSource_Enum? source_) =>
      _$this._source_ = source_;

  String? _connectionId;
  String? get connectionId => _$this._connectionId;
  set connectionId(String? connectionId) => _$this._connectionId = connectionId;

  Hip3Eip712MessageBuilder() {
    Hip3Eip712Message._defaults(this);
  }

  Hip3Eip712MessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_;
      _connectionId = $v.connectionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Eip712Message other) {
    _$v = other as _$Hip3Eip712Message;
  }

  @override
  void update(void Function(Hip3Eip712MessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Eip712Message build() => _build();

  _$Hip3Eip712Message _build() {
    final _$result = _$v ??
        _$Hip3Eip712Message._(
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'Hip3Eip712Message', 'source_'),
          connectionId: BuiltValueNullFieldError.checkNotNull(
              connectionId, r'Hip3Eip712Message', 'connectionId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
