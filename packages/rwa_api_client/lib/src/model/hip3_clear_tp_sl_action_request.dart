//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_clear_tp_sl_action_request.g.dart';

/// Hip3ClearTpSlActionRequest
///
/// Properties:
/// * [operation] 
/// * [positionId] 
/// * [positionVersion] 
/// * [scope] 
@BuiltValue()
abstract class Hip3ClearTpSlActionRequest implements Built<Hip3ClearTpSlActionRequest, Hip3ClearTpSlActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3ClearTpSlActionRequestOperationEnum get operation;
  // enum operationEnum {  clear_tpsl,  };

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'position_version')
  String get positionVersion;

  @BuiltValueField(wireName: r'scope')
  Hip3ClearTpSlActionRequestScopeEnum get scope;
  // enum scopeEnum {  take_profit,  stop_loss,  both,  };

  Hip3ClearTpSlActionRequest._();

  factory Hip3ClearTpSlActionRequest([void updates(Hip3ClearTpSlActionRequestBuilder b)]) = _$Hip3ClearTpSlActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ClearTpSlActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ClearTpSlActionRequest> get serializer => _$Hip3ClearTpSlActionRequestSerializer();
}

class _$Hip3ClearTpSlActionRequestSerializer implements PrimitiveSerializer<Hip3ClearTpSlActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3ClearTpSlActionRequest, _$Hip3ClearTpSlActionRequest];

  @override
  final String wireName = r'Hip3ClearTpSlActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ClearTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3ClearTpSlActionRequestOperationEnum),
    );
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'position_version';
    yield serializers.serialize(
      object.positionVersion,
      specifiedType: const FullType(String),
    );
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(Hip3ClearTpSlActionRequestScopeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ClearTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ClearTpSlActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ClearTpSlActionRequestOperationEnum),
          ) as Hip3ClearTpSlActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'position_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionVersion = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ClearTpSlActionRequestScopeEnum),
          ) as Hip3ClearTpSlActionRequestScopeEnum;
          result.scope = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ClearTpSlActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ClearTpSlActionRequestBuilder();
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

class Hip3ClearTpSlActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'clear_tpsl')
  static const Hip3ClearTpSlActionRequestOperationEnum clearTpsl = _$hip3ClearTpSlActionRequestOperationEnum_clearTpsl;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ClearTpSlActionRequestOperationEnum unknownDefaultOpenApi = _$hip3ClearTpSlActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ClearTpSlActionRequestOperationEnum> get serializer => _$hip3ClearTpSlActionRequestOperationEnumSerializer;

  const Hip3ClearTpSlActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ClearTpSlActionRequestOperationEnum> get values => _$hip3ClearTpSlActionRequestOperationEnumValues;
  static Hip3ClearTpSlActionRequestOperationEnum valueOf(String name) => _$hip3ClearTpSlActionRequestOperationEnumValueOf(name);
}

class Hip3ClearTpSlActionRequestScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3ClearTpSlActionRequestScopeEnum takeProfit = _$hip3ClearTpSlActionRequestScopeEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3ClearTpSlActionRequestScopeEnum stopLoss = _$hip3ClearTpSlActionRequestScopeEnum_stopLoss;
  @BuiltValueEnumConst(wireName: r'both')
  static const Hip3ClearTpSlActionRequestScopeEnum both = _$hip3ClearTpSlActionRequestScopeEnum_both;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ClearTpSlActionRequestScopeEnum unknownDefaultOpenApi = _$hip3ClearTpSlActionRequestScopeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ClearTpSlActionRequestScopeEnum> get serializer => _$hip3ClearTpSlActionRequestScopeEnumSerializer;

  const Hip3ClearTpSlActionRequestScopeEnum._(String name): super(name);

  static BuiltSet<Hip3ClearTpSlActionRequestScopeEnum> get values => _$hip3ClearTpSlActionRequestScopeEnumValues;
  static Hip3ClearTpSlActionRequestScopeEnum valueOf(String name) => _$hip3ClearTpSlActionRequestScopeEnumValueOf(name);
}

