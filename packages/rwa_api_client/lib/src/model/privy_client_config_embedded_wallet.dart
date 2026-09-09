//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_client_config_embedded_wallet.g.dart';

/// Embedded Wallet 创建策略
///
/// Properties:
/// * [createOnLogin] 
/// * [chains] 
@BuiltValue()
abstract class PrivyClientConfigEmbeddedWallet implements Built<PrivyClientConfigEmbeddedWallet, PrivyClientConfigEmbeddedWalletBuilder> {
  @BuiltValueField(wireName: r'create_on_login')
  PrivyClientConfigEmbeddedWalletCreateOnLoginEnum? get createOnLogin;
  // enum createOnLoginEnum {  users-without-wallets,  all-users,  false,  };

  @BuiltValueField(wireName: r'chains')
  BuiltList<Chain>? get chains;

  PrivyClientConfigEmbeddedWallet._();

  factory PrivyClientConfigEmbeddedWallet([void updates(PrivyClientConfigEmbeddedWalletBuilder b)]) = _$PrivyClientConfigEmbeddedWallet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyClientConfigEmbeddedWalletBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyClientConfigEmbeddedWallet> get serializer => _$PrivyClientConfigEmbeddedWalletSerializer();
}

class _$PrivyClientConfigEmbeddedWalletSerializer implements PrimitiveSerializer<PrivyClientConfigEmbeddedWallet> {
  @override
  final Iterable<Type> types = const [PrivyClientConfigEmbeddedWallet, _$PrivyClientConfigEmbeddedWallet];

  @override
  final String wireName = r'PrivyClientConfigEmbeddedWallet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyClientConfigEmbeddedWallet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.createOnLogin != null) {
      yield r'create_on_login';
      yield serializers.serialize(
        object.createOnLogin,
        specifiedType: const FullType(PrivyClientConfigEmbeddedWalletCreateOnLoginEnum),
      );
    }
    if (object.chains != null) {
      yield r'chains';
      yield serializers.serialize(
        object.chains,
        specifiedType: const FullType(BuiltList, [FullType(Chain)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyClientConfigEmbeddedWallet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyClientConfigEmbeddedWalletBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'create_on_login':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PrivyClientConfigEmbeddedWalletCreateOnLoginEnum),
          ) as PrivyClientConfigEmbeddedWalletCreateOnLoginEnum?;
          if (valueDes == null) continue;
          result.createOnLogin = valueDes;
          break;
        case r'chains':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Chain)]),
          ) as BuiltList<Chain>?;
          if (valueDes == null) continue;
          result.chains.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyClientConfigEmbeddedWallet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyClientConfigEmbeddedWalletBuilder();
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

class PrivyClientConfigEmbeddedWalletCreateOnLoginEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'users-without-wallets')
  static const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum usersWithoutWallets = _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_usersWithoutWallets;
  @BuiltValueEnumConst(wireName: r'all-users')
  static const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum allUsers = _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_allUsers;
  @BuiltValueEnumConst(wireName: r'false')
  static const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum false_ = _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_false_;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum unknownDefaultOpenApi = _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_unknownDefaultOpenApi;

  static Serializer<PrivyClientConfigEmbeddedWalletCreateOnLoginEnum> get serializer => _$privyClientConfigEmbeddedWalletCreateOnLoginEnumSerializer;

  const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum._(String name): super(name);

  static BuiltSet<PrivyClientConfigEmbeddedWalletCreateOnLoginEnum> get values => _$privyClientConfigEmbeddedWalletCreateOnLoginEnumValues;
  static PrivyClientConfigEmbeddedWalletCreateOnLoginEnum valueOf(String name) => _$privyClientConfigEmbeddedWalletCreateOnLoginEnumValueOf(name);
}

