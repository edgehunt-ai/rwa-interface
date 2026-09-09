//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/privy_authorization_headers.dart';
import 'package:rwa_api_client/src/model/privy_authorization_body.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_authorization_payload.g.dart';

/// Exact structured input for Flutter/React Privy `generateAuthorizationSignature`. The client passes this structure to the Privy SDK; RFC 8785 canonicalization is SDK-owned and this API never accepts an arbitrary JSON blob. The URL is restricted to Privy's HTTPS wallet RPC.  `body.caip2` MUST equal `eip155:{WalletActionExecution.chain_id}`; `body.reference_id` MUST equal the execution id; and `body.params.transaction.from/to/data/value` MUST byte-for-byte equal `WalletActionExecution.frozen_transaction`. Any mismatch is a server fault and the client must not sign it. 
///
/// Properties:
/// * [version] 
/// * [method] 
/// * [url] 
/// * [headers] 
/// * [body] 
@BuiltValue()
abstract class PrivyAuthorizationPayload implements Built<PrivyAuthorizationPayload, PrivyAuthorizationPayloadBuilder> {
  @BuiltValueField(wireName: r'version')
  PrivyAuthorizationPayloadVersionEnum get version;
  // enum versionEnum {  1,  };

  @BuiltValueField(wireName: r'method')
  PrivyAuthorizationPayloadMethodEnum get method;
  // enum methodEnum {  POST,  };

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'headers')
  PrivyAuthorizationHeaders get headers;

  @BuiltValueField(wireName: r'body')
  PrivyAuthorizationBody get body;

  PrivyAuthorizationPayload._();

  factory PrivyAuthorizationPayload([void updates(PrivyAuthorizationPayloadBuilder b)]) = _$PrivyAuthorizationPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyAuthorizationPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyAuthorizationPayload> get serializer => _$PrivyAuthorizationPayloadSerializer();
}

class _$PrivyAuthorizationPayloadSerializer implements PrimitiveSerializer<PrivyAuthorizationPayload> {
  @override
  final Iterable<Type> types = const [PrivyAuthorizationPayload, _$PrivyAuthorizationPayload];

  @override
  final String wireName = r'PrivyAuthorizationPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyAuthorizationPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(PrivyAuthorizationPayloadVersionEnum),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(PrivyAuthorizationPayloadMethodEnum),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'headers';
    yield serializers.serialize(
      object.headers,
      specifiedType: const FullType(PrivyAuthorizationHeaders),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(PrivyAuthorizationBody),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyAuthorizationPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivyAuthorizationPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationPayloadVersionEnum),
          ) as PrivyAuthorizationPayloadVersionEnum;
          result.version = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationPayloadMethodEnum),
          ) as PrivyAuthorizationPayloadMethodEnum;
          result.method = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'headers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationHeaders),
          ) as PrivyAuthorizationHeaders;
          result.headers.replace(valueDes);
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivyAuthorizationBody),
          ) as PrivyAuthorizationBody;
          result.body.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyAuthorizationPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyAuthorizationPayloadBuilder();
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

class PrivyAuthorizationPayloadVersionEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const PrivyAuthorizationPayloadVersionEnum number1 = _$privyAuthorizationPayloadVersionEnum_number1;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PrivyAuthorizationPayloadVersionEnum unknownDefaultOpenApi = _$privyAuthorizationPayloadVersionEnum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationPayloadVersionEnum> get serializer => _$privyAuthorizationPayloadVersionEnumSerializer;

  const PrivyAuthorizationPayloadVersionEnum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationPayloadVersionEnum> get values => _$privyAuthorizationPayloadVersionEnumValues;
  static PrivyAuthorizationPayloadVersionEnum valueOf(String name) => _$privyAuthorizationPayloadVersionEnumValueOf(name);
}

class PrivyAuthorizationPayloadMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'POST')
  static const PrivyAuthorizationPayloadMethodEnum POST = _$privyAuthorizationPayloadMethodEnum_POST;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PrivyAuthorizationPayloadMethodEnum unknownDefaultOpenApi = _$privyAuthorizationPayloadMethodEnum_unknownDefaultOpenApi;

  static Serializer<PrivyAuthorizationPayloadMethodEnum> get serializer => _$privyAuthorizationPayloadMethodEnumSerializer;

  const PrivyAuthorizationPayloadMethodEnum._(String name): super(name);

  static BuiltSet<PrivyAuthorizationPayloadMethodEnum> get values => _$privyAuthorizationPayloadMethodEnumValues;
  static PrivyAuthorizationPayloadMethodEnum valueOf(String name) => _$privyAuthorizationPayloadMethodEnumValueOf(name);
}

