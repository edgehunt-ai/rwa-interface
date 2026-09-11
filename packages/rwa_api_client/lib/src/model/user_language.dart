//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_language.g.dart';

class UserLanguage extends EnumClass {

  /// 服务端持久化并可由所有消费者完整表示的账户语言。它同时决定推送通知的语言： 推送由后端发起，拿不到请求头里的 `Accept-Language`，因此这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'zh-CN')
  static const UserLanguage zhCN = _$zhCN;
  /// 服务端持久化并可由所有消费者完整表示的账户语言。它同时决定推送通知的语言： 推送由后端发起，拿不到请求头里的 `Accept-Language`，因此这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'en')
  static const UserLanguage en = _$en;
  /// 服务端持久化并可由所有消费者完整表示的账户语言。它同时决定推送通知的语言： 推送由后端发起，拿不到请求头里的 `Accept-Language`，因此这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'ja')
  static const UserLanguage ja = _$ja;
  /// 服务端持久化并可由所有消费者完整表示的账户语言。它同时决定推送通知的语言： 推送由后端发起，拿不到请求头里的 `Accept-Language`，因此这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'ko')
  static const UserLanguage ko = _$ko;
  /// 服务端持久化并可由所有消费者完整表示的账户语言。它同时决定推送通知的语言： 推送由后端发起，拿不到请求头里的 `Accept-Language`，因此这个偏好必须存在服务端。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserLanguage unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<UserLanguage> get serializer => _$userLanguageSerializer;

  const UserLanguage._(String name): super(name);

  static BuiltSet<UserLanguage> get values => _$values;
  static UserLanguage valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UserLanguageMixin = Object with _$UserLanguageMixin;

