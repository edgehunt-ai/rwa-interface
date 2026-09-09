//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_set_leverage_action_request.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/hip3_clear_tp_sl_action_request.dart';
import 'package:rwa_api_client/src/model/hip3_place_order_action_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_spec.dart';
import 'package:rwa_api_client/src/model/hip3_close_action_request.dart';
import 'package:rwa_api_client/src/model/hip3_cancel_order_action_request.dart';
import 'package:rwa_api_client/src/model/hip3_set_tp_sl_action_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'hip3_action_create_request.g.dart';

/// Hip3ActionCreateRequest
///
/// Properties:
/// * [operation] 
/// * [orderId] 
/// * [previewId] 
/// * [positionId] 
/// * [positionVersion] 
/// * [protection] 
/// * [scope] 
/// * [contextId] 
/// * [leverage] - 十进制字符串，避免浮点误差
/// * [marginMode] 
@BuiltValue()
abstract class Hip3ActionCreateRequest implements Built<Hip3ActionCreateRequest, Hip3ActionCreateRequestBuilder> {
  /// One Of [Hip3CancelOrderActionRequest], [Hip3ClearTpSlActionRequest], [Hip3CloseActionRequest], [Hip3PlaceOrderActionRequest], [Hip3SetLeverageActionRequest], [Hip3SetTpSlActionRequest]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'operation';

  static const Map<String, Type> discriminatorMapping = {
    r'cancel_order': Hip3CancelOrderActionRequest,
    r'clear_tpsl': Hip3ClearTpSlActionRequest,
    r'close_position': Hip3CloseActionRequest,
    r'place_order': Hip3PlaceOrderActionRequest,
    r'set_leverage': Hip3SetLeverageActionRequest,
    r'set_tpsl': Hip3SetTpSlActionRequest,
  };

  Hip3ActionCreateRequest._();

  factory Hip3ActionCreateRequest([void updates(Hip3ActionCreateRequestBuilder b)]) = _$Hip3ActionCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ActionCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ActionCreateRequest> get serializer => _$Hip3ActionCreateRequestSerializer();
}

extension Hip3ActionCreateRequestDiscriminatorExt on Hip3ActionCreateRequest {
    String? get discriminatorValue {
        if (this is Hip3CancelOrderActionRequest) {
            return r'cancel_order';
        }
        if (this is Hip3ClearTpSlActionRequest) {
            return r'clear_tpsl';
        }
        if (this is Hip3CloseActionRequest) {
            return r'close_position';
        }
        if (this is Hip3PlaceOrderActionRequest) {
            return r'place_order';
        }
        if (this is Hip3SetLeverageActionRequest) {
            return r'set_leverage';
        }
        if (this is Hip3SetTpSlActionRequest) {
            return r'set_tpsl';
        }
        return null;
    }
}
extension Hip3ActionCreateRequestBuilderDiscriminatorExt on Hip3ActionCreateRequestBuilder {
    String? get discriminatorValue {
        if (this is Hip3CancelOrderActionRequestBuilder) {
            return r'cancel_order';
        }
        if (this is Hip3ClearTpSlActionRequestBuilder) {
            return r'clear_tpsl';
        }
        if (this is Hip3CloseActionRequestBuilder) {
            return r'close_position';
        }
        if (this is Hip3PlaceOrderActionRequestBuilder) {
            return r'place_order';
        }
        if (this is Hip3SetLeverageActionRequestBuilder) {
            return r'set_leverage';
        }
        if (this is Hip3SetTpSlActionRequestBuilder) {
            return r'set_tpsl';
        }
        return null;
    }
}

class _$Hip3ActionCreateRequestSerializer implements PrimitiveSerializer<Hip3ActionCreateRequest> {
  @override
  final Iterable<Type> types = const [Hip3ActionCreateRequest, _$Hip3ActionCreateRequest];

  @override
  final String wireName = r'Hip3ActionCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ActionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ActionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Hip3ActionCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ActionCreateRequestBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(Hip3ActionCreateRequest.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [Hip3CancelOrderActionRequest, Hip3ClearTpSlActionRequest, Hip3CloseActionRequest, Hip3PlaceOrderActionRequest, Hip3SetLeverageActionRequest, Hip3SetTpSlActionRequest, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'cancel_order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3CancelOrderActionRequest),
        ) as Hip3CancelOrderActionRequest;
        oneOfType = Hip3CancelOrderActionRequest;
        break;
      case r'clear_tpsl':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3ClearTpSlActionRequest),
        ) as Hip3ClearTpSlActionRequest;
        oneOfType = Hip3ClearTpSlActionRequest;
        break;
      case r'close_position':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3CloseActionRequest),
        ) as Hip3CloseActionRequest;
        oneOfType = Hip3CloseActionRequest;
        break;
      case r'place_order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3PlaceOrderActionRequest),
        ) as Hip3PlaceOrderActionRequest;
        oneOfType = Hip3PlaceOrderActionRequest;
        break;
      case r'set_leverage':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3SetLeverageActionRequest),
        ) as Hip3SetLeverageActionRequest;
        oneOfType = Hip3SetLeverageActionRequest;
        break;
      case r'set_tpsl':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(Hip3SetTpSlActionRequest),
        ) as Hip3SetTpSlActionRequest;
        oneOfType = Hip3SetTpSlActionRequest;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class Hip3ActionCreateRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'set_leverage')
  static const Hip3ActionCreateRequestOperationEnum setLeverage = _$hip3ActionCreateRequestOperationEnum_setLeverage;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ActionCreateRequestOperationEnum unknownDefaultOpenApi = _$hip3ActionCreateRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ActionCreateRequestOperationEnum> get serializer => _$hip3ActionCreateRequestOperationEnumSerializer;

  const Hip3ActionCreateRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ActionCreateRequestOperationEnum> get values => _$hip3ActionCreateRequestOperationEnumValues;
  static Hip3ActionCreateRequestOperationEnum valueOf(String name) => _$hip3ActionCreateRequestOperationEnumValueOf(name);
}

class Hip3ActionCreateRequestScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3ActionCreateRequestScopeEnum takeProfit = _$hip3ActionCreateRequestScopeEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3ActionCreateRequestScopeEnum stopLoss = _$hip3ActionCreateRequestScopeEnum_stopLoss;
  @BuiltValueEnumConst(wireName: r'both')
  static const Hip3ActionCreateRequestScopeEnum both = _$hip3ActionCreateRequestScopeEnum_both;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ActionCreateRequestScopeEnum unknownDefaultOpenApi = _$hip3ActionCreateRequestScopeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ActionCreateRequestScopeEnum> get serializer => _$hip3ActionCreateRequestScopeEnumSerializer;

  const Hip3ActionCreateRequestScopeEnum._(String name): super(name);

  static BuiltSet<Hip3ActionCreateRequestScopeEnum> get values => _$hip3ActionCreateRequestScopeEnumValues;
  static Hip3ActionCreateRequestScopeEnum valueOf(String name) => _$hip3ActionCreateRequestScopeEnumValueOf(name);
}

