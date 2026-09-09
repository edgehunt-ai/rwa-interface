//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_set_leverage_action_request.g.dart';

/// context_id 绑定当前账户、环境及产品，必须仍有效；支持开仓前设置，不要求已有仓位。 leverage 必须是正整数且符合实时产品规则。margin_mode 必须被产品及当前账户状态允许。 若模式切换不被 Provider 支持，明确拒绝，不得改成另一模式或假报成功。 
///
/// Properties:
/// * [operation] 
/// * [contextId] 
/// * [leverage] - 十进制字符串，避免浮点误差
/// * [marginMode] 
@BuiltValue()
abstract class Hip3SetLeverageActionRequest implements Built<Hip3SetLeverageActionRequest, Hip3SetLeverageActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3SetLeverageActionRequestOperationEnum get operation;
  // enum operationEnum {  set_leverage,  };

  @BuiltValueField(wireName: r'context_id')
  String get contextId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'leverage')
  String get leverage;

  @BuiltValueField(wireName: r'margin_mode')
  MarginMode get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  Hip3SetLeverageActionRequest._();

  factory Hip3SetLeverageActionRequest([void updates(Hip3SetLeverageActionRequestBuilder b)]) = _$Hip3SetLeverageActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3SetLeverageActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3SetLeverageActionRequest> get serializer => _$Hip3SetLeverageActionRequestSerializer();
}

class _$Hip3SetLeverageActionRequestSerializer implements PrimitiveSerializer<Hip3SetLeverageActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3SetLeverageActionRequest, _$Hip3SetLeverageActionRequest];

  @override
  final String wireName = r'Hip3SetLeverageActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3SetLeverageActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3SetLeverageActionRequestOperationEnum),
    );
    yield r'context_id';
    yield serializers.serialize(
      object.contextId,
      specifiedType: const FullType(String),
    );
    yield r'leverage';
    yield serializers.serialize(
      object.leverage,
      specifiedType: const FullType(String),
    );
    yield r'margin_mode';
    yield serializers.serialize(
      object.marginMode,
      specifiedType: const FullType(MarginMode),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3SetLeverageActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3SetLeverageActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3SetLeverageActionRequestOperationEnum),
          ) as Hip3SetLeverageActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'context_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contextId = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MarginMode),
          ) as MarginMode;
          result.marginMode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3SetLeverageActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3SetLeverageActionRequestBuilder();
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

class Hip3SetLeverageActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'set_leverage')
  static const Hip3SetLeverageActionRequestOperationEnum setLeverage = _$hip3SetLeverageActionRequestOperationEnum_setLeverage;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3SetLeverageActionRequestOperationEnum unknownDefaultOpenApi = _$hip3SetLeverageActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3SetLeverageActionRequestOperationEnum> get serializer => _$hip3SetLeverageActionRequestOperationEnumSerializer;

  const Hip3SetLeverageActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3SetLeverageActionRequestOperationEnum> get values => _$hip3SetLeverageActionRequestOperationEnumValues;
  static Hip3SetLeverageActionRequestOperationEnum valueOf(String name) => _$hip3SetLeverageActionRequestOperationEnumValueOf(name);
}

