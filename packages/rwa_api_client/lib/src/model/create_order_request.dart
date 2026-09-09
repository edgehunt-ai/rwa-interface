//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/perp_create_order_request.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_spec.dart';
import 'package:rwa_api_client/src/model/bstock_create_order_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'create_order_request.g.dart';

/// 根据 `kind` 分派为 bStocks 现货或 HIP-3 永续订单，并可携带预览锁价 id。
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [amount] - 市价单的 USDC 名义价值
/// * [quantity] - 限价单的基础资产数量
/// * [limitPrice] - 限价单的 USDC 价格
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
/// * [previewId] - 传入预览返回的报价 id 可锁定价格；过期后需重新预览
/// * [contextId] - 必须与所引用 preview 的 context 相同；账户/环境不由客户端决定。
/// * [timeInForce] 
/// * [protection] 
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] 
/// * [reduceOnly] 
@BuiltValue()
abstract class CreateOrderRequest implements Built<CreateOrderRequest, CreateOrderRequestBuilder> {
  /// One Of [BstockCreateOrderRequest], [PerpCreateOrderRequest]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'kind';

  static const Map<String, Type> discriminatorMapping = {
    r'bstock': BstockCreateOrderRequest,
    r'perp': PerpCreateOrderRequest,
  };

  CreateOrderRequest._();

  factory CreateOrderRequest([void updates(CreateOrderRequestBuilder b)]) = _$CreateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateOrderRequest> get serializer => _$CreateOrderRequestSerializer();
}

extension CreateOrderRequestDiscriminatorExt on CreateOrderRequest {
    String? get discriminatorValue {
        if (this is BstockCreateOrderRequest) {
            return r'bstock';
        }
        if (this is PerpCreateOrderRequest) {
            return r'perp';
        }
        return null;
    }
}
extension CreateOrderRequestBuilderDiscriminatorExt on CreateOrderRequestBuilder {
    String? get discriminatorValue {
        if (this is BstockCreateOrderRequestBuilder) {
            return r'bstock';
        }
        if (this is PerpCreateOrderRequestBuilder) {
            return r'perp';
        }
        return null;
    }
}

class _$CreateOrderRequestSerializer implements PrimitiveSerializer<CreateOrderRequest> {
  @override
  final Iterable<Type> types = const [CreateOrderRequest, _$CreateOrderRequest];

  @override
  final String wireName = r'CreateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  CreateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateOrderRequestBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(CreateOrderRequest.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [BstockCreateOrderRequest, PerpCreateOrderRequest, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'bstock':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstockCreateOrderRequest),
        ) as BstockCreateOrderRequest;
        oneOfType = BstockCreateOrderRequest;
        break;
      case r'perp':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(PerpCreateOrderRequest),
        ) as PerpCreateOrderRequest;
        oneOfType = PerpCreateOrderRequest;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class CreateOrderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const CreateOrderRequestKindEnum perp = _$createOrderRequestKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateOrderRequestKindEnum unknownDefaultOpenApi = _$createOrderRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<CreateOrderRequestKindEnum> get serializer => _$createOrderRequestKindEnumSerializer;

  const CreateOrderRequestKindEnum._(String name): super(name);

  static BuiltSet<CreateOrderRequestKindEnum> get values => _$createOrderRequestKindEnumValues;
  static CreateOrderRequestKindEnum valueOf(String name) => _$createOrderRequestKindEnumValueOf(name);
}

class CreateOrderRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const CreateOrderRequestSideEnum long = _$createOrderRequestSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const CreateOrderRequestSideEnum short = _$createOrderRequestSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateOrderRequestSideEnum unknownDefaultOpenApi = _$createOrderRequestSideEnum_unknownDefaultOpenApi;

  static Serializer<CreateOrderRequestSideEnum> get serializer => _$createOrderRequestSideEnumSerializer;

  const CreateOrderRequestSideEnum._(String name): super(name);

  static BuiltSet<CreateOrderRequestSideEnum> get values => _$createOrderRequestSideEnumValues;
  static CreateOrderRequestSideEnum valueOf(String name) => _$createOrderRequestSideEnumValueOf(name);
}

