//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/privy_authorization_params.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_authorization_body.g.dart';

/// PrivyAuthorizationBody
///
/// Properties:
/// * [method] 
/// * [caip2] 
/// * [chainType] 
/// * [sponsor] 
/// * [referenceId] - Stable server-generated execution correlation identifier. It is included in Privy transaction Webhooks and is never supplied or overridden by the client. 
/// * [params] 
@BuiltValue()
abstract class PrivyAuthorizationBody implements Built<PrivyAuthorizationBody, PrivyAuthorizationBodyBuilder> {
  @BuiltValueField(wireName: r'method')
  PrivyAuthorizationBodyMethodEnum get method;
  // enum methodEnum {  eth_sendTransaction,  };

  @BuiltValueField(wireName: r'caip2')
  PrivyAuthorizationBodyCaip2Enum get caip2;
  // enum caip2Enum {  eip155:1,  eip155:56,  eip155:97,  eip155:8453,  eip155:42161,  eip155:421614,  };

  @BuiltValueField(wireName: r'chain_type')
  PrivyAuthorizationBodyChainTypeEnum get chainType;
  // enum chainTypeEnum {  ethereum,  };

  @BuiltValueField(wireName: r'sponsor')
  bool get sponsor;

  /// Stable server-generated execution correlation identifier. It is included in Privy transaction Webhooks and is never supplied or overridden by the client. 
  @BuiltValueField(wireName: r'reference_id')
  String get referenceId;

  @BuiltValueField(wireName: r'params')
  PrivyAuthorizationParams get params;

  PrivyAuthorizationBody._();

  factory PrivyAuthorizationBody([void updates(PrivyAuthorizationBodyBuilder b)]) = _$PrivyAuthorizationBody;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyAuthorizationBodyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyAuthorizationBody> get serializer => _$PrivyAuthorizationBodySerializer();
}

class _$PrivyAuthorizationBodySerializer implements PrimitiveSerializer<PrivyAuthorizationBody> {
  @override
  final Iterable<Type> types = const [PrivyAuthorizationBody, _$PrivyAuthorizationBody];

  @override
  final String wireName = r'PrivyAuthorizationBody';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyAuthorizationBody object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(PrivyAuthorizationBodyMethodEnum),
    );
    yield r'caip2';
    yield serializers.serialize(
      object.caip2,
      specifiedType: const FullType(PrivyAuthorizationBodyCaip2Enum),
    );
    yield r'chain_type';
    yield serializers.serialize(
      object.chainType,
      specifiedType: const FullType(PrivyAuthorizationBodyChainTypeEnum),
    );
    yield r'sponsor';
    yield serializers.serialize(
      object.sponsor,
      specifiedType: const FullType(bool),
    );
    yield r'reference_id';
    yield serializers.serialize(
      object.referenceId,
      specifiedType: const FullType(String),
    );
    yield r'params';
    yield serializers.serialize(
      object.params,
      specifiedType: const FullType(PrivyAuthorizationParams),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyAuthorizationBody object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyAuthorizationBodyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationBodyMethodEnum),
          ) as PrivyAuthorizationBodyMethodEnum;
          result.method = valueDes;
          break;
        case r'caip2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationBodyCaip2Enum),
          ) as PrivyAuthorizationBodyCaip2Enum;
          result.caip2 = valueDes;
          break;
        case r'chain_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationBodyChainTypeEnum),
          ) as PrivyAuthorizationBodyChainTypeEnum;
          result.chainType = valueDes;
          break;
        case r'sponsor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.sponsor = valueDes;
          break;
        case r'reference_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.referenceId = valueDes;
          break;
        case r'params':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationParams),
          ) as PrivyAuthorizationParams;
          result.params.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyAuthorizationBody deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyAuthorizationBodyBuilder();
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

class PrivyAuthorizationBodyMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eth_sendTransaction')
  static const PrivyAuthorizationBodyMethodEnum ethSendTransaction = _$privyAuthorizationBodyMethodEnum_ethSendTransaction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyAuthorizationBodyMethodEnum unknownDefaultOpenApi = _$privyAuthorizationBodyMethodEnum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationBodyMethodEnum> get serializer => _$privyAuthorizationBodyMethodEnumSerializer;

  const PrivyAuthorizationBodyMethodEnum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationBodyMethodEnum> get values => _$privyAuthorizationBodyMethodEnumValues;
  static PrivyAuthorizationBodyMethodEnum valueOf(String name) => _$privyAuthorizationBodyMethodEnumValueOf(name);
}

class PrivyAuthorizationBodyCaip2Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:1')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon1 = _$privyAuthorizationBodyCaip2Enum_eip155Colon1;
  @BuiltValueEnumConst(wireName: r'eip155:56')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon56 = _$privyAuthorizationBodyCaip2Enum_eip155Colon56;
  @BuiltValueEnumConst(wireName: r'eip155:97')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon97 = _$privyAuthorizationBodyCaip2Enum_eip155Colon97;
  @BuiltValueEnumConst(wireName: r'eip155:8453')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon8453 = _$privyAuthorizationBodyCaip2Enum_eip155Colon8453;
  @BuiltValueEnumConst(wireName: r'eip155:42161')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon42161 = _$privyAuthorizationBodyCaip2Enum_eip155Colon42161;
  @BuiltValueEnumConst(wireName: r'eip155:421614')
  static const PrivyAuthorizationBodyCaip2Enum eip155Colon421614 = _$privyAuthorizationBodyCaip2Enum_eip155Colon421614;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyAuthorizationBodyCaip2Enum unknownDefaultOpenApi = _$privyAuthorizationBodyCaip2Enum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationBodyCaip2Enum> get serializer => _$privyAuthorizationBodyCaip2EnumSerializer;

  const PrivyAuthorizationBodyCaip2Enum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationBodyCaip2Enum> get values => _$privyAuthorizationBodyCaip2EnumValues;
  static PrivyAuthorizationBodyCaip2Enum valueOf(String name) => _$privyAuthorizationBodyCaip2EnumValueOf(name);
}

class PrivyAuthorizationBodyChainTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ethereum')
  static const PrivyAuthorizationBodyChainTypeEnum ethereum = _$privyAuthorizationBodyChainTypeEnum_ethereum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyAuthorizationBodyChainTypeEnum unknownDefaultOpenApi = _$privyAuthorizationBodyChainTypeEnum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationBodyChainTypeEnum> get serializer => _$privyAuthorizationBodyChainTypeEnumSerializer;

  const PrivyAuthorizationBodyChainTypeEnum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationBodyChainTypeEnum> get values => _$privyAuthorizationBodyChainTypeEnumValues;
  static PrivyAuthorizationBodyChainTypeEnum valueOf(String name) => _$privyAuthorizationBodyChainTypeEnumValueOf(name);
}

