//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_execution_method.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction_execute_request.g.dart';

/// Hip3AccountAbstractionExecuteRequest
///
/// Properties:
/// * [targetMode] 
/// * [executionMethod] 
/// * [nonce] 
/// * [payloadHash] 
/// * [signature] - user execution method only; the exact owner EIP-712 signature.
@BuiltValue()
abstract class Hip3AccountAbstractionExecuteRequest implements Built<Hip3AccountAbstractionExecuteRequest, Hip3AccountAbstractionExecuteRequestBuilder> {
  @BuiltValueField(wireName: r'target_mode')
  Hip3AccountAbstractionExecuteRequestTargetModeEnum get targetMode;
  // enum targetModeEnum {  unifiedAccount,  };

  @BuiltValueField(wireName: r'execution_method')
  Hip3AccountAbstractionExecutionMethod get executionMethod;
  // enum executionMethodEnum {  agent,  user,  };

  @BuiltValueField(wireName: r'nonce')
  int get nonce;

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  /// user execution method only; the exact owner EIP-712 signature.
  @BuiltValueField(wireName: r'signature')
  String? get signature;

  Hip3AccountAbstractionExecuteRequest._();

  factory Hip3AccountAbstractionExecuteRequest([void updates(Hip3AccountAbstractionExecuteRequestBuilder b)]) = _$Hip3AccountAbstractionExecuteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3AccountAbstractionExecuteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3AccountAbstractionExecuteRequest> get serializer => _$Hip3AccountAbstractionExecuteRequestSerializer();
}

class _$Hip3AccountAbstractionExecuteRequestSerializer implements PrimitiveSerializer<Hip3AccountAbstractionExecuteRequest> {
  @override
  final Iterable<Type> types = const [Hip3AccountAbstractionExecuteRequest, _$Hip3AccountAbstractionExecuteRequest];

  @override
  final String wireName = r'Hip3AccountAbstractionExecuteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3AccountAbstractionExecuteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'target_mode';
    yield serializers.serialize(
      object.targetMode,
      specifiedType: const FullType(Hip3AccountAbstractionExecuteRequestTargetModeEnum),
    );
    yield r'execution_method';
    yield serializers.serialize(
      object.executionMethod,
      specifiedType: const FullType(Hip3AccountAbstractionExecutionMethod),
    );
    yield r'nonce';
    yield serializers.serialize(
      object.nonce,
      specifiedType: const FullType(int),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    if (object.signature != null) {
      yield r'signature';
      yield serializers.serialize(
        object.signature,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3AccountAbstractionExecuteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3AccountAbstractionExecuteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'target_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionExecuteRequestTargetModeEnum),
          ) as Hip3AccountAbstractionExecuteRequestTargetModeEnum;
          result.targetMode = valueDes;
          break;
        case r'execution_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionExecutionMethod),
          ) as Hip3AccountAbstractionExecutionMethod;
          result.executionMethod = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.nonce = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.signature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3AccountAbstractionExecuteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3AccountAbstractionExecuteRequestBuilder();
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

class Hip3AccountAbstractionExecuteRequestTargetModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unifiedAccount')
  static const Hip3AccountAbstractionExecuteRequestTargetModeEnum unifiedAccount = _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unifiedAccount;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionExecuteRequestTargetModeEnum unknownDefaultOpenApi = _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionExecuteRequestTargetModeEnum> get serializer => _$hip3AccountAbstractionExecuteRequestTargetModeEnumSerializer;

  const Hip3AccountAbstractionExecuteRequestTargetModeEnum._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionExecuteRequestTargetModeEnum> get values => _$hip3AccountAbstractionExecuteRequestTargetModeEnumValues;
  static Hip3AccountAbstractionExecuteRequestTargetModeEnum valueOf(String name) => _$hip3AccountAbstractionExecuteRequestTargetModeEnumValueOf(name);
}

