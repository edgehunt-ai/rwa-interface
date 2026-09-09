//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_mode.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_deposit_intent_request.g.dart';

/// CreateDepositIntentRequest
///
/// Properties:
/// * [chain]
/// * [token]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [mode]
@Deprecated('CreateDepositIntentRequest has been deprecated')
@BuiltValue()
abstract class CreateDepositIntentRequest
    implements
        Built<CreateDepositIntentRequest, CreateDepositIntentRequestBuilder> {
  @BuiltValueField(wireName: r'chain')
  CreateDepositIntentRequestChainEnum get chain;
  // enum chainEnum {  BSC,  Arbitrum,  };

  @BuiltValueField(wireName: r'token')
  CreateDepositIntentRequestTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @Deprecated('mode has been deprecated')
  @BuiltValueField(wireName: r'mode')
  DepositMode? get mode;
  // enum modeEnum {  wallet,  trade,  external_import,  };

  CreateDepositIntentRequest._();

  factory CreateDepositIntentRequest(
          [void updates(CreateDepositIntentRequestBuilder b)]) =
      _$CreateDepositIntentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDepositIntentRequestBuilder b) =>
      b..mode = DepositMode.wallet;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDepositIntentRequest> get serializer =>
      _$CreateDepositIntentRequestSerializer();
}

class _$CreateDepositIntentRequestSerializer
    implements PrimitiveSerializer<CreateDepositIntentRequest> {
  @override
  final Iterable<Type> types = const [
    CreateDepositIntentRequest,
    _$CreateDepositIntentRequest
  ];

  @override
  final String wireName = r'CreateDepositIntentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDepositIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(CreateDepositIntentRequestChainEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(CreateDepositIntentRequestTokenEnum),
    );
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.mode != null) {
      yield r'mode';
      yield serializers.serialize(
        object.mode,
        specifiedType: const FullType(DepositMode),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateDepositIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateDepositIntentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateDepositIntentRequestChainEnum),
          ) as CreateDepositIntentRequestChainEnum;
          result.chain = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateDepositIntentRequestTokenEnum),
          ) as CreateDepositIntentRequestTokenEnum;
          result.token = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DepositMode),
          ) as DepositMode?;
          if (valueDes == null) continue;
          result.mode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateDepositIntentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDepositIntentRequestBuilder();
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

@Deprecated('CreateDepositIntentRequestChainEnum has been deprecated')
class CreateDepositIntentRequestChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BSC')
  static const CreateDepositIntentRequestChainEnum BSC =
      _$createDepositIntentRequestChainEnum_BSC;
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const CreateDepositIntentRequestChainEnum arbitrum =
      _$createDepositIntentRequestChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateDepositIntentRequestChainEnum unknownDefaultOpenApi =
      _$createDepositIntentRequestChainEnum_unknownDefaultOpenApi;

  static Serializer<CreateDepositIntentRequestChainEnum> get serializer =>
      _$createDepositIntentRequestChainEnumSerializer;

  const CreateDepositIntentRequestChainEnum._(String name) : super(name);

  static BuiltSet<CreateDepositIntentRequestChainEnum> get values =>
      _$createDepositIntentRequestChainEnumValues;
  static CreateDepositIntentRequestChainEnum valueOf(String name) =>
      _$createDepositIntentRequestChainEnumValueOf(name);
}

@Deprecated('CreateDepositIntentRequestTokenEnum has been deprecated')
class CreateDepositIntentRequestTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const CreateDepositIntentRequestTokenEnum USDC =
      _$createDepositIntentRequestTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateDepositIntentRequestTokenEnum unknownDefaultOpenApi =
      _$createDepositIntentRequestTokenEnum_unknownDefaultOpenApi;

  static Serializer<CreateDepositIntentRequestTokenEnum> get serializer =>
      _$createDepositIntentRequestTokenEnumSerializer;

  const CreateDepositIntentRequestTokenEnum._(String name) : super(name);

  static BuiltSet<CreateDepositIntentRequestTokenEnum> get values =>
      _$createDepositIntentRequestTokenEnumValues;
  static CreateDepositIntentRequestTokenEnum valueOf(String name) =>
      _$createDepositIntentRequestTokenEnumValueOf(name);
}
