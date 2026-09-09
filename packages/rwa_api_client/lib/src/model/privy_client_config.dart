//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/privy_client_config_embedded_wallet.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_client_config.g.dart';

/// PrivyClientConfig
///
/// Properties:
/// * [privyAppId] 
/// * [privyClientId] - Privy 移动端 client ID（iOS / Android 分别配置时使用）
/// * [loginMethods] 
/// * [embeddedWallet] 
/// * [termsUrl] 
/// * [privacyUrl] 
@BuiltValue()
abstract class PrivyClientConfig implements Built<PrivyClientConfig, PrivyClientConfigBuilder> {
  @BuiltValueField(wireName: r'privy_app_id')
  String get privyAppId;

  /// Privy 移动端 client ID（iOS / Android 分别配置时使用）
  @BuiltValueField(wireName: r'privy_client_id')
  String? get privyClientId;

  @BuiltValueField(wireName: r'login_methods')
  BuiltList<PrivyClientConfigLoginMethodsEnum> get loginMethods;
  // enum loginMethodsEnum {  email,  apple,  google,  };

  @BuiltValueField(wireName: r'embedded_wallet')
  PrivyClientConfigEmbeddedWallet? get embeddedWallet;

  @BuiltValueField(wireName: r'terms_url')
  String? get termsUrl;

  @BuiltValueField(wireName: r'privacy_url')
  String? get privacyUrl;

  PrivyClientConfig._();

  factory PrivyClientConfig([void updates(PrivyClientConfigBuilder b)]) = _$PrivyClientConfig;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyClientConfigBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyClientConfig> get serializer => _$PrivyClientConfigSerializer();
}

class _$PrivyClientConfigSerializer implements PrimitiveSerializer<PrivyClientConfig> {
  @override
  final Iterable<Type> types = const [PrivyClientConfig, _$PrivyClientConfig];

  @override
  final String wireName = r'PrivyClientConfig';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyClientConfig object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'privy_app_id';
    yield serializers.serialize(
      object.privyAppId,
      specifiedType: const FullType(String),
    );
    if (object.privyClientId != null) {
      yield r'privy_client_id';
      yield serializers.serialize(
        object.privyClientId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'login_methods';
    yield serializers.serialize(
      object.loginMethods,
      specifiedType: const FullType(BuiltList, [FullType(PrivyClientConfigLoginMethodsEnum)]),
    );
    if (object.embeddedWallet != null) {
      yield r'embedded_wallet';
      yield serializers.serialize(
        object.embeddedWallet,
        specifiedType: const FullType(PrivyClientConfigEmbeddedWallet),
      );
    }
    if (object.termsUrl != null) {
      yield r'terms_url';
      yield serializers.serialize(
        object.termsUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.privacyUrl != null) {
      yield r'privacy_url';
      yield serializers.serialize(
        object.privacyUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyClientConfig object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyClientConfigBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'privy_app_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privyAppId = valueDes;
          break;
        case r'privy_client_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privyClientId = valueDes;
          break;
        case r'login_methods':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PrivyClientConfigLoginMethodsEnum)]),
          ) as BuiltList<PrivyClientConfigLoginMethodsEnum>;
          result.loginMethods.replace(valueDes);
          break;
        case r'embedded_wallet':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PrivyClientConfigEmbeddedWallet),
          ) as PrivyClientConfigEmbeddedWallet?;
          if (valueDes == null) continue;
          result.embeddedWallet.replace(valueDes);
          break;
        case r'terms_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.termsUrl = valueDes;
          break;
        case r'privacy_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privacyUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyClientConfig deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyClientConfigBuilder();
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

class PrivyClientConfigLoginMethodsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'email')
  static const PrivyClientConfigLoginMethodsEnum email = _$privyClientConfigLoginMethodsEnum_email;
  @BuiltValueEnumConst(wireName: r'apple')
  static const PrivyClientConfigLoginMethodsEnum apple = _$privyClientConfigLoginMethodsEnum_apple;
  @BuiltValueEnumConst(wireName: r'google')
  static const PrivyClientConfigLoginMethodsEnum google = _$privyClientConfigLoginMethodsEnum_google;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyClientConfigLoginMethodsEnum unknownDefaultOpenApi = _$privyClientConfigLoginMethodsEnum_unknownDefaultOpenApi;

  static Serializer<PrivyClientConfigLoginMethodsEnum> get serializer => _$privyClientConfigLoginMethodsEnumSerializer;

  const PrivyClientConfigLoginMethodsEnum._(String name): super(name);

  static BuiltSet<PrivyClientConfigLoginMethodsEnum> get values => _$privyClientConfigLoginMethodsEnumValues;
  static PrivyClientConfigLoginMethodsEnum valueOf(String name) => _$privyClientConfigLoginMethodsEnumValueOf(name);
}

