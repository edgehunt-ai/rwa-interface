//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_eip712_typed_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_step_signing_payload.g.dart';

/// 必须对原始 typed data 签名，不使用 personal_sign。domain.chainId=1337 是签名域， 不代表 Mainnet/Testnet；source 与父动作 environment 必须一致。valid_until 不晚于 expires_after 及业务有效期，服务器仍需校验签名人与当前业务绑定。 
///
/// Properties:
/// * [expectedSigner] 
/// * [signingMethod] 
/// * [signatureFormat] 
/// * [signingTypedData] 
/// * [signingDigest] 
/// * [nonce] 
/// * [expiresAfter] 
/// * [validUntil] 
@BuiltValue()
abstract class Hip3StepSigningPayload implements Built<Hip3StepSigningPayload, Hip3StepSigningPayloadBuilder> {
  @BuiltValueField(wireName: r'expected_signer')
  String get expectedSigner;

  @BuiltValueField(wireName: r'signing_method')
  Hip3StepSigningPayloadSigningMethodEnum get signingMethod;
  // enum signingMethodEnum {  eth_signTypedData_v4,  };

  @BuiltValueField(wireName: r'signature_format')
  Hip3StepSigningPayloadSignatureFormatEnum get signatureFormat;
  // enum signatureFormatEnum {  r_s_v,  };

  @BuiltValueField(wireName: r'signing_typed_data')
  Hip3Eip712TypedData get signingTypedData;

  @BuiltValueField(wireName: r'signing_digest')
  String get signingDigest;

  @BuiltValueField(wireName: r'nonce')
  int get nonce;

  @BuiltValueField(wireName: r'expires_after')
  int get expiresAfter;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  Hip3StepSigningPayload._();

  factory Hip3StepSigningPayload([void updates(Hip3StepSigningPayloadBuilder b)]) = _$Hip3StepSigningPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3StepSigningPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3StepSigningPayload> get serializer => _$Hip3StepSigningPayloadSerializer();
}

class _$Hip3StepSigningPayloadSerializer implements PrimitiveSerializer<Hip3StepSigningPayload> {
  @override
  final Iterable<Type> types = const [Hip3StepSigningPayload, _$Hip3StepSigningPayload];

  @override
  final String wireName = r'Hip3StepSigningPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3StepSigningPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'expected_signer';
    yield serializers.serialize(
      object.expectedSigner,
      specifiedType: const FullType(String),
    );
    yield r'signing_method';
    yield serializers.serialize(
      object.signingMethod,
      specifiedType: const FullType(Hip3StepSigningPayloadSigningMethodEnum),
    );
    yield r'signature_format';
    yield serializers.serialize(
      object.signatureFormat,
      specifiedType: const FullType(Hip3StepSigningPayloadSignatureFormatEnum),
    );
    yield r'signing_typed_data';
    yield serializers.serialize(
      object.signingTypedData,
      specifiedType: const FullType(Hip3Eip712TypedData),
    );
    yield r'signing_digest';
    yield serializers.serialize(
      object.signingDigest,
      specifiedType: const FullType(String),
    );
    yield r'nonce';
    yield serializers.serialize(
      object.nonce,
      specifiedType: const FullType(int),
    );
    yield r'expires_after';
    yield serializers.serialize(
      object.expiresAfter,
      specifiedType: const FullType(int),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3StepSigningPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3StepSigningPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'expected_signer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expectedSigner = valueDes;
          break;
        case r'signing_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3StepSigningPayloadSigningMethodEnum),
          ) as Hip3StepSigningPayloadSigningMethodEnum;
          result.signingMethod = valueDes;
          break;
        case r'signature_format':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3StepSigningPayloadSignatureFormatEnum),
          ) as Hip3StepSigningPayloadSignatureFormatEnum;
          result.signatureFormat = valueDes;
          break;
        case r'signing_typed_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712TypedData),
          ) as Hip3Eip712TypedData;
          result.signingTypedData.replace(valueDes);
          break;
        case r'signing_digest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signingDigest = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.nonce = valueDes;
          break;
        case r'expires_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresAfter = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3StepSigningPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3StepSigningPayloadBuilder();
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

class Hip3StepSigningPayloadSigningMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eth_signTypedData_v4')
  static const Hip3StepSigningPayloadSigningMethodEnum ethSignTypedDataV4 = _$hip3StepSigningPayloadSigningMethodEnum_ethSignTypedDataV4;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3StepSigningPayloadSigningMethodEnum unknownDefaultOpenApi = _$hip3StepSigningPayloadSigningMethodEnum_unknownDefaultOpenApi;

  static Serializer<Hip3StepSigningPayloadSigningMethodEnum> get serializer => _$hip3StepSigningPayloadSigningMethodEnumSerializer;

  const Hip3StepSigningPayloadSigningMethodEnum._(String name): super(name);

  static BuiltSet<Hip3StepSigningPayloadSigningMethodEnum> get values => _$hip3StepSigningPayloadSigningMethodEnumValues;
  static Hip3StepSigningPayloadSigningMethodEnum valueOf(String name) => _$hip3StepSigningPayloadSigningMethodEnumValueOf(name);
}

class Hip3StepSigningPayloadSignatureFormatEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'r_s_v')
  static const Hip3StepSigningPayloadSignatureFormatEnum rSV = _$hip3StepSigningPayloadSignatureFormatEnum_rSV;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3StepSigningPayloadSignatureFormatEnum unknownDefaultOpenApi = _$hip3StepSigningPayloadSignatureFormatEnum_unknownDefaultOpenApi;

  static Serializer<Hip3StepSigningPayloadSignatureFormatEnum> get serializer => _$hip3StepSigningPayloadSignatureFormatEnumSerializer;

  const Hip3StepSigningPayloadSignatureFormatEnum._(String name): super(name);

  static BuiltSet<Hip3StepSigningPayloadSignatureFormatEnum> get values => _$hip3StepSigningPayloadSignatureFormatEnumValues;
  static Hip3StepSigningPayloadSignatureFormatEnum valueOf(String name) => _$hip3StepSigningPayloadSignatureFormatEnumValueOf(name);
}

