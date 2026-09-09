// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_authorization_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrivyAuthorizationPayloadVersionEnum
    _$privyAuthorizationPayloadVersionEnum_number1 =
    const PrivyAuthorizationPayloadVersionEnum._('number1');
const PrivyAuthorizationPayloadVersionEnum
    _$privyAuthorizationPayloadVersionEnum_unknownDefaultOpenApi =
    const PrivyAuthorizationPayloadVersionEnum._('unknownDefaultOpenApi');

PrivyAuthorizationPayloadVersionEnum
    _$privyAuthorizationPayloadVersionEnumValueOf(String name) {
  switch (name) {
    case 'number1':
      return _$privyAuthorizationPayloadVersionEnum_number1;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationPayloadVersionEnum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationPayloadVersionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationPayloadVersionEnum>
    _$privyAuthorizationPayloadVersionEnumValues = BuiltSet<
        PrivyAuthorizationPayloadVersionEnum>(const <PrivyAuthorizationPayloadVersionEnum>[
  _$privyAuthorizationPayloadVersionEnum_number1,
  _$privyAuthorizationPayloadVersionEnum_unknownDefaultOpenApi,
]);

const PrivyAuthorizationPayloadMethodEnum
    _$privyAuthorizationPayloadMethodEnum_POST =
    const PrivyAuthorizationPayloadMethodEnum._('POST');
const PrivyAuthorizationPayloadMethodEnum
    _$privyAuthorizationPayloadMethodEnum_unknownDefaultOpenApi =
    const PrivyAuthorizationPayloadMethodEnum._('unknownDefaultOpenApi');

PrivyAuthorizationPayloadMethodEnum
    _$privyAuthorizationPayloadMethodEnumValueOf(String name) {
  switch (name) {
    case 'POST':
      return _$privyAuthorizationPayloadMethodEnum_POST;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationPayloadMethodEnum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationPayloadMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationPayloadMethodEnum>
    _$privyAuthorizationPayloadMethodEnumValues = BuiltSet<
        PrivyAuthorizationPayloadMethodEnum>(const <PrivyAuthorizationPayloadMethodEnum>[
  _$privyAuthorizationPayloadMethodEnum_POST,
  _$privyAuthorizationPayloadMethodEnum_unknownDefaultOpenApi,
]);

Serializer<PrivyAuthorizationPayloadVersionEnum>
    _$privyAuthorizationPayloadVersionEnumSerializer =
    _$PrivyAuthorizationPayloadVersionEnumSerializer();
Serializer<PrivyAuthorizationPayloadMethodEnum>
    _$privyAuthorizationPayloadMethodEnumSerializer =
    _$PrivyAuthorizationPayloadMethodEnumSerializer();

class _$PrivyAuthorizationPayloadVersionEnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationPayloadVersionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PrivyAuthorizationPayloadVersionEnum
  ];
  @override
  final String wireName = 'PrivyAuthorizationPayloadVersionEnum';

  @override
  Object serialize(
          Serializers serializers, PrivyAuthorizationPayloadVersionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationPayloadVersionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationPayloadVersionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationPayloadMethodEnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationPayloadMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'POST': 'POST',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'POST': 'POST',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PrivyAuthorizationPayloadMethodEnum
  ];
  @override
  final String wireName = 'PrivyAuthorizationPayloadMethodEnum';

  @override
  Object serialize(
          Serializers serializers, PrivyAuthorizationPayloadMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationPayloadMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationPayloadMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationPayload extends PrivyAuthorizationPayload {
  @override
  final PrivyAuthorizationPayloadVersionEnum version;
  @override
  final PrivyAuthorizationPayloadMethodEnum method;
  @override
  final String url;
  @override
  final PrivyAuthorizationHeaders headers;
  @override
  final PrivyAuthorizationBody body;

  factory _$PrivyAuthorizationPayload(
          [void Function(PrivyAuthorizationPayloadBuilder)? updates]) =>
      (PrivyAuthorizationPayloadBuilder()..update(updates))._build();

  _$PrivyAuthorizationPayload._(
      {required this.version,
      required this.method,
      required this.url,
      required this.headers,
      required this.body})
      : super._();
  @override
  PrivyAuthorizationPayload rebuild(
          void Function(PrivyAuthorizationPayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyAuthorizationPayloadBuilder toBuilder() =>
      PrivyAuthorizationPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyAuthorizationPayload &&
        version == other.version &&
        method == other.method &&
        url == other.url &&
        headers == other.headers &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, headers.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyAuthorizationPayload')
          ..add('version', version)
          ..add('method', method)
          ..add('url', url)
          ..add('headers', headers)
          ..add('body', body))
        .toString();
  }
}

class PrivyAuthorizationPayloadBuilder
    implements
        Builder<PrivyAuthorizationPayload, PrivyAuthorizationPayloadBuilder> {
  _$PrivyAuthorizationPayload? _$v;

  PrivyAuthorizationPayloadVersionEnum? _version;
  PrivyAuthorizationPayloadVersionEnum? get version => _$this._version;
  set version(PrivyAuthorizationPayloadVersionEnum? version) =>
      _$this._version = version;

  PrivyAuthorizationPayloadMethodEnum? _method;
  PrivyAuthorizationPayloadMethodEnum? get method => _$this._method;
  set method(PrivyAuthorizationPayloadMethodEnum? method) =>
      _$this._method = method;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  PrivyAuthorizationHeadersBuilder? _headers;
  PrivyAuthorizationHeadersBuilder get headers =>
      _$this._headers ??= PrivyAuthorizationHeadersBuilder();
  set headers(PrivyAuthorizationHeadersBuilder? headers) =>
      _$this._headers = headers;

  PrivyAuthorizationBodyBuilder? _body;
  PrivyAuthorizationBodyBuilder get body =>
      _$this._body ??= PrivyAuthorizationBodyBuilder();
  set body(PrivyAuthorizationBodyBuilder? body) => _$this._body = body;

  PrivyAuthorizationPayloadBuilder() {
    PrivyAuthorizationPayload._defaults(this);
  }

  PrivyAuthorizationPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _method = $v.method;
      _url = $v.url;
      _headers = $v.headers.toBuilder();
      _body = $v.body.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyAuthorizationPayload other) {
    _$v = other as _$PrivyAuthorizationPayload;
  }

  @override
  void update(void Function(PrivyAuthorizationPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyAuthorizationPayload build() => _build();

  _$PrivyAuthorizationPayload _build() {
    _$PrivyAuthorizationPayload _$result;
    try {
      _$result = _$v ??
          _$PrivyAuthorizationPayload._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'PrivyAuthorizationPayload', 'version'),
            method: BuiltValueNullFieldError.checkNotNull(
                method, r'PrivyAuthorizationPayload', 'method'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, r'PrivyAuthorizationPayload', 'url'),
            headers: headers.build(),
            body: body.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'headers';
        headers.build();
        _$failedField = 'body';
        body.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivyAuthorizationPayload', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
