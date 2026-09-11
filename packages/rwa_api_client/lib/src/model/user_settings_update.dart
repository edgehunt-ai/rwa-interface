//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/user_language.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_settings_update.g.dart';

/// `PATCH /v1/me/settings` 的请求体。**所有字段可选，传什么改什么**； 未出现的字段保持原值，不会被重置。 
///
/// Properties:
/// * [language] 
/// * [pushEnabled] 
/// * [notifyOrderFilled] 
/// * [notifyOrderFailed] 
/// * [notifyLiquidationWarning] 
@BuiltValue()
abstract class UserSettingsUpdate implements Built<UserSettingsUpdate, UserSettingsUpdateBuilder> {
  @BuiltValueField(wireName: r'language')
  UserLanguage? get language;
  // enum languageEnum {  zh-CN,  en,  ja,  ko,  };

  @BuiltValueField(wireName: r'push_enabled')
  bool? get pushEnabled;

  @BuiltValueField(wireName: r'notify_order_filled')
  bool? get notifyOrderFilled;

  @BuiltValueField(wireName: r'notify_order_failed')
  bool? get notifyOrderFailed;

  @BuiltValueField(wireName: r'notify_liquidation_warning')
  bool? get notifyLiquidationWarning;

  UserSettingsUpdate._();

  factory UserSettingsUpdate([void updates(UserSettingsUpdateBuilder b)]) = _$UserSettingsUpdate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserSettingsUpdateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSettingsUpdate> get serializer => _$UserSettingsUpdateSerializer();
}

class _$UserSettingsUpdateSerializer implements PrimitiveSerializer<UserSettingsUpdate> {
  @override
  final Iterable<Type> types = const [UserSettingsUpdate, _$UserSettingsUpdate];

  @override
  final String wireName = r'UserSettingsUpdate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSettingsUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType(UserLanguage),
      );
    }
    if (object.pushEnabled != null) {
      yield r'push_enabled';
      yield serializers.serialize(
        object.pushEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.notifyOrderFilled != null) {
      yield r'notify_order_filled';
      yield serializers.serialize(
        object.notifyOrderFilled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.notifyOrderFailed != null) {
      yield r'notify_order_failed';
      yield serializers.serialize(
        object.notifyOrderFailed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.notifyLiquidationWarning != null) {
      yield r'notify_liquidation_warning';
      yield serializers.serialize(
        object.notifyLiquidationWarning,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSettingsUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSettingsUpdateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UserLanguage),
          ) as UserLanguage?;
          if (valueDes == null) continue;
          result.language = valueDes;
          break;
        case r'push_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.pushEnabled = valueDes;
          break;
        case r'notify_order_filled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.notifyOrderFilled = valueDes;
          break;
        case r'notify_order_failed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.notifyOrderFailed = valueDes;
          break;
        case r'notify_liquidation_warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.notifyLiquidationWarning = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserSettingsUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserSettingsUpdateBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

