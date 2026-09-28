// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_language.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserLanguage _$zhCN = const UserLanguage._('zhCN');
const UserLanguage _$en = const UserLanguage._('en');
const UserLanguage _$ja = const UserLanguage._('ja');
const UserLanguage _$ko = const UserLanguage._('ko');

UserLanguage _$valueOf(String name) {
  switch (name) {
    case 'zhCN':
      return _$zhCN;
    case 'en':
      return _$en;
    case 'ja':
      return _$ja;
    case 'ko':
      return _$ko;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserLanguage> _$values =
    BuiltSet<UserLanguage>(const <UserLanguage>[
  _$zhCN,
  _$en,
  _$ja,
  _$ko,
]);

class _$UserLanguageMeta {
  const _$UserLanguageMeta();
  UserLanguage get zhCN => _$zhCN;
  UserLanguage get en => _$en;
  UserLanguage get ja => _$ja;
  UserLanguage get ko => _$ko;
  UserLanguage valueOf(String name) => _$valueOf(name);
  BuiltSet<UserLanguage> get values => _$values;
}

abstract class _$UserLanguageMixin {
  // ignore: non_constant_identifier_names
  _$UserLanguageMeta get UserLanguage => const _$UserLanguageMeta();
}

Serializer<UserLanguage> _$userLanguageSerializer = _$UserLanguageSerializer();

class _$UserLanguageSerializer implements PrimitiveSerializer<UserLanguage> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'zhCN': 'zh-CN',
    'en': 'en',
    'ja': 'ja',
    'ko': 'ko',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'zh-CN': 'zhCN',
    'en': 'en',
    'ja': 'ja',
    'ko': 'ko',
  };

  @override
  final Iterable<Type> types = const <Type>[UserLanguage];
  @override
  final String wireName = 'UserLanguage';

  @override
  Object serialize(Serializers serializers, UserLanguage object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserLanguage deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserLanguage.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
