// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_challenge_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ChallengeRequestPurposeEnum
    _$hip3ChallengeRequestPurposeEnum_register =
    const Hip3ChallengeRequestPurposeEnum._('register');
const Hip3ChallengeRequestPurposeEnum _$hip3ChallengeRequestPurposeEnum_rotate =
    const Hip3ChallengeRequestPurposeEnum._('rotate');
const Hip3ChallengeRequestPurposeEnum
    _$hip3ChallengeRequestPurposeEnum_unknownDefaultOpenApi =
    const Hip3ChallengeRequestPurposeEnum._('unknownDefaultOpenApi');

Hip3ChallengeRequestPurposeEnum _$hip3ChallengeRequestPurposeEnumValueOf(
    String name) {
  switch (name) {
    case 'register':
      return _$hip3ChallengeRequestPurposeEnum_register;
    case 'rotate':
      return _$hip3ChallengeRequestPurposeEnum_rotate;
    case 'unknownDefaultOpenApi':
      return _$hip3ChallengeRequestPurposeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ChallengeRequestPurposeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ChallengeRequestPurposeEnum>
    _$hip3ChallengeRequestPurposeEnumValues = BuiltSet<
        Hip3ChallengeRequestPurposeEnum>(const <Hip3ChallengeRequestPurposeEnum>[
  _$hip3ChallengeRequestPurposeEnum_register,
  _$hip3ChallengeRequestPurposeEnum_rotate,
  _$hip3ChallengeRequestPurposeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ChallengeRequestPurposeEnum>
    _$hip3ChallengeRequestPurposeEnumSerializer =
    _$Hip3ChallengeRequestPurposeEnumSerializer();

class _$Hip3ChallengeRequestPurposeEnumSerializer
    implements PrimitiveSerializer<Hip3ChallengeRequestPurposeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'register': 'register',
    'rotate': 'rotate',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'register': 'register',
    'rotate': 'rotate',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ChallengeRequestPurposeEnum];
  @override
  final String wireName = 'Hip3ChallengeRequestPurposeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ChallengeRequestPurposeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ChallengeRequestPurposeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ChallengeRequestPurposeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ChallengeRequest extends Hip3ChallengeRequest {
  @override
  final Hip3ChallengeRequestPurposeEnum? purpose;
  @override
  final String? label;

  factory _$Hip3ChallengeRequest(
          [void Function(Hip3ChallengeRequestBuilder)? updates]) =>
      (Hip3ChallengeRequestBuilder()..update(updates))._build();

  _$Hip3ChallengeRequest._({this.purpose, this.label}) : super._();
  @override
  Hip3ChallengeRequest rebuild(
          void Function(Hip3ChallengeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ChallengeRequestBuilder toBuilder() =>
      Hip3ChallengeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ChallengeRequest &&
        purpose == other.purpose &&
        label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ChallengeRequest')
          ..add('purpose', purpose)
          ..add('label', label))
        .toString();
  }
}

class Hip3ChallengeRequestBuilder
    implements Builder<Hip3ChallengeRequest, Hip3ChallengeRequestBuilder> {
  _$Hip3ChallengeRequest? _$v;

  Hip3ChallengeRequestPurposeEnum? _purpose;
  Hip3ChallengeRequestPurposeEnum? get purpose => _$this._purpose;
  set purpose(Hip3ChallengeRequestPurposeEnum? purpose) =>
      _$this._purpose = purpose;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  Hip3ChallengeRequestBuilder() {
    Hip3ChallengeRequest._defaults(this);
  }

  Hip3ChallengeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purpose = $v.purpose;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ChallengeRequest other) {
    _$v = other as _$Hip3ChallengeRequest;
  }

  @override
  void update(void Function(Hip3ChallengeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ChallengeRequest build() => _build();

  _$Hip3ChallengeRequest _build() {
    final _$result = _$v ??
        _$Hip3ChallengeRequest._(
          purpose: purpose,
          label: label,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
