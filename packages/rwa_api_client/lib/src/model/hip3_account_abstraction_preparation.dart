//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_mode.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_execution_method.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction_preparation.g.dart';

/// Hip3AccountAbstractionPreparation
///
/// Properties:
/// * [ownerAddress] 
/// * [currentMode] 
/// * [targetMode] 
/// * [executionMethod] 
/// * [nonce] 
/// * [payloadHash] 
/// * [typedDataJson] - user execution method only; exact EIP-712 JSON. Agent execution method returns null.
/// * [expiresAt] 
@BuiltValue()
abstract class Hip3AccountAbstractionPreparation implements Built<Hip3AccountAbstractionPreparation, Hip3AccountAbstractionPreparationBuilder> {
  @BuiltValueField(wireName: r'owner_address')
  String get ownerAddress;

  @BuiltValueField(wireName: r'current_mode')
  Hip3AccountAbstractionMode get currentMode;
  // enum currentModeEnum {  default,  unifiedAccount,  portfolioMargin,  };

  @BuiltValueField(wireName: r'target_mode')
  Hip3AccountAbstractionPreparationTargetModeEnum get targetMode;
  // enum targetModeEnum {  unifiedAccount,  };

  @BuiltValueField(wireName: r'execution_method')
  Hip3AccountAbstractionExecutionMethod get executionMethod;
  // enum executionMethodEnum {  agent,  user,  };

  @BuiltValueField(wireName: r'nonce')
  int get nonce;

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  /// user execution method only; exact EIP-712 JSON. Agent execution method returns null.
  @BuiltValueField(wireName: r'typed_data_json')
  String? get typedDataJson;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  Hip3AccountAbstractionPreparation._();

  factory Hip3AccountAbstractionPreparation([void updates(Hip3AccountAbstractionPreparationBuilder b)]) = _$Hip3AccountAbstractionPreparation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3AccountAbstractionPreparationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3AccountAbstractionPreparation> get serializer => _$Hip3AccountAbstractionPreparationSerializer();
}

class _$Hip3AccountAbstractionPreparationSerializer implements PrimitiveSerializer<Hip3AccountAbstractionPreparation> {
  @override
  final Iterable<Type> types = const [Hip3AccountAbstractionPreparation, _$Hip3AccountAbstractionPreparation];

  @override
  final String wireName = r'Hip3AccountAbstractionPreparation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3AccountAbstractionPreparation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'owner_address';
    yield serializers.serialize(
      object.ownerAddress,
      specifiedType: const FullType(String),
    );
    yield r'current_mode';
    yield serializers.serialize(
      object.currentMode,
      specifiedType: const FullType(Hip3AccountAbstractionMode),
    );
    yield r'target_mode';
    yield serializers.serialize(
      object.targetMode,
      specifiedType: const FullType(Hip3AccountAbstractionPreparationTargetModeEnum),
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
    yield r'typed_data_json';
    yield object.typedDataJson == null ? null : serializers.serialize(
      object.typedDataJson,
      specifiedType: const FullType.nullable(String),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3AccountAbstractionPreparation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3AccountAbstractionPreparationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'owner_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerAddress = valueDes;
          break;
        case r'current_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionMode),
          ) as Hip3AccountAbstractionMode;
          result.currentMode = valueDes;
          break;
        case r'target_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionPreparationTargetModeEnum),
          ) as Hip3AccountAbstractionPreparationTargetModeEnum;
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
        case r'typed_data_json':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.typedDataJson = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3AccountAbstractionPreparation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3AccountAbstractionPreparationBuilder();
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

class Hip3AccountAbstractionPreparationTargetModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unifiedAccount')
  static const Hip3AccountAbstractionPreparationTargetModeEnum unifiedAccount = _$hip3AccountAbstractionPreparationTargetModeEnum_unifiedAccount;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionPreparationTargetModeEnum unknownDefaultOpenApi = _$hip3AccountAbstractionPreparationTargetModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionPreparationTargetModeEnum> get serializer => _$hip3AccountAbstractionPreparationTargetModeEnumSerializer;

  const Hip3AccountAbstractionPreparationTargetModeEnum._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionPreparationTargetModeEnum> get values => _$hip3AccountAbstractionPreparationTargetModeEnumValues;
  static Hip3AccountAbstractionPreparationTargetModeEnum valueOf(String name) => _$hip3AccountAbstractionPreparationTargetModeEnumValueOf(name);
}

