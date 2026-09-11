//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/bstock_order_preview_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_order_preview_request.dart';
import 'package:rwa_api_client/src/model/hip3_order_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'order_preview_request.g.dart';

/// 根据 `kind` 分派为 bStocks 现货或 HIP-3 永续订单。
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [timeInForce] 
/// * [amount] - 市价单的 USDC 名义价值
/// * [quantity] - 限价单的基础资产数量
/// * [limitPrice] - 限价单的 USDC 价格
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
/// * [contextId] - 可选的 HIP3 trading context；存在时精确绑定账户/产品/环境，过期返回 409。新客户端在请求前读取 context。
/// * [protection] 
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] 
/// * [reduceOnly] 
@BuiltValue()
abstract class OrderPreviewRequest implements Built<OrderPreviewRequest, OrderPreviewRequestBuilder> {
  /// One Of [BstockOrderPreviewRequest], [PerpOrderPreviewRequest]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'kind';

  static const Map<String, Type> discriminatorMapping = {
    r'bstock': BstockOrderPreviewRequest,
    r'perp': PerpOrderPreviewRequest,
  };

  OrderPreviewRequest._();

  factory OrderPreviewRequest([void updates(OrderPreviewRequestBuilder b)]) = _$OrderPreviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderPreviewRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderPreviewRequest> get serializer => _$OrderPreviewRequestSerializer();
}

extension OrderPreviewRequestDiscriminatorExt on OrderPreviewRequest {
    String? get discriminatorValue {
        if (this is BstockOrderPreviewRequest) {
            return r'bstock';
        }
        if (this is PerpOrderPreviewRequest) {
            return r'perp';
        }
        return null;
    }
}
extension OrderPreviewRequestBuilderDiscriminatorExt on OrderPreviewRequestBuilder {
    String? get discriminatorValue {
        if (this is BstockOrderPreviewRequestBuilder) {
            return r'bstock';
        }
        if (this is PerpOrderPreviewRequestBuilder) {
            return r'perp';
        }
        return null;
    }
}

class _$OrderPreviewRequestSerializer implements PrimitiveSerializer<OrderPreviewRequest> {
  @override
  final Iterable<Type> types = const [OrderPreviewRequest, _$OrderPreviewRequest];

  @override
  final String wireName = r'OrderPreviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderPreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderPreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  OrderPreviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderPreviewRequestBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(OrderPreviewRequest.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [BstockOrderPreviewRequest, PerpOrderPreviewRequest, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'bstock':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstockOrderPreviewRequest),
        ) as BstockOrderPreviewRequest;
        oneOfType = BstockOrderPreviewRequest;
        break;
      case r'perp':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(PerpOrderPreviewRequest),
        ) as PerpOrderPreviewRequest;
        oneOfType = PerpOrderPreviewRequest;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class OrderPreviewRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const OrderPreviewRequestKindEnum perp = _$orderPreviewRequestKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewRequestKindEnum unknownDefaultOpenApi = _$orderPreviewRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewRequestKindEnum> get serializer => _$orderPreviewRequestKindEnumSerializer;

  const OrderPreviewRequestKindEnum._(String name): super(name);

  static BuiltSet<OrderPreviewRequestKindEnum> get values => _$orderPreviewRequestKindEnumValues;
  static OrderPreviewRequestKindEnum valueOf(String name) => _$orderPreviewRequestKindEnumValueOf(name);
}

class OrderPreviewRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const OrderPreviewRequestSideEnum long = _$orderPreviewRequestSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const OrderPreviewRequestSideEnum short = _$orderPreviewRequestSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewRequestSideEnum unknownDefaultOpenApi = _$orderPreviewRequestSideEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewRequestSideEnum> get serializer => _$orderPreviewRequestSideEnumSerializer;

  const OrderPreviewRequestSideEnum._(String name): super(name);

  static BuiltSet<OrderPreviewRequestSideEnum> get values => _$orderPreviewRequestSideEnumValues;
  static OrderPreviewRequestSideEnum valueOf(String name) => _$orderPreviewRequestSideEnumValueOf(name);
}

