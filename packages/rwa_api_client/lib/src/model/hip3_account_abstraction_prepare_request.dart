//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction_prepare_request.g.dart';

/// Hip3AccountAbstractionPrepareRequest
///
/// Properties:
/// * [targetMode] 
@BuiltValue()
abstract class Hip3AccountAbstractionPrepareRequest implements Built<Hip3AccountAbstractionPrepareRequest, Hip3AccountAbstractionPrepareRequestBuilder> {
  @BuiltValueField(wireName: r'target_mode')
  Hip3AccountAbstractionPrepareRequestTargetModeEnum get targetMode;
  // enum targetModeEnum {  unifiedAccount,  };

  Hip3AccountAbstractionPrepareRequest._();

  factory Hip3AccountAbstractionPrepareRequest([void updates(Hip3AccountAbstractionPrepareRequestBuilder b)]) = _$Hip3AccountAbstractionPrepareRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3AccountAbstractionPrepareRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3AccountAbstractionPrepareRequest> get serializer => _$Hip3AccountAbstractionPrepareRequestSerializer();
}

class _$Hip3AccountAbstractionPrepareRequestSerializer implements PrimitiveSerializer<Hip3AccountAbstractionPrepareRequest> {
  @override
  final Iterable<Type> types = const [Hip3AccountAbstractionPrepareRequest, _$Hip3AccountAbstractionPrepareRequest];

  @override
  final String wireName = r'Hip3AccountAbstractionPrepareRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3AccountAbstractionPrepareRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'target_mode';
    yield serializers.serialize(
      object.targetMode,
      specifiedType: const FullType(Hip3AccountAbstractionPrepareRequestTargetModeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3AccountAbstractionPrepareRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3AccountAbstractionPrepareRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'target_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AccountAbstractionPrepareRequestTargetModeEnum),
          ) as Hip3AccountAbstractionPrepareRequestTargetModeEnum;
          result.targetMode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3AccountAbstractionPrepareRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3AccountAbstractionPrepareRequestBuilder();
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

class Hip3AccountAbstractionPrepareRequestTargetModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unifiedAccount')
  static const Hip3AccountAbstractionPrepareRequestTargetModeEnum unifiedAccount = _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unifiedAccount;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionPrepareRequestTargetModeEnum unknownDefaultOpenApi = _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionPrepareRequestTargetModeEnum> get serializer => _$hip3AccountAbstractionPrepareRequestTargetModeEnumSerializer;

  const Hip3AccountAbstractionPrepareRequestTargetModeEnum._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionPrepareRequestTargetModeEnum> get values => _$hip3AccountAbstractionPrepareRequestTargetModeEnumValues;
  static Hip3AccountAbstractionPrepareRequestTargetModeEnum valueOf(String name) => _$hip3AccountAbstractionPrepareRequestTargetModeEnumValueOf(name);
}

