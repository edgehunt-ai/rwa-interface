//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_trade_create_request.g.dart';

/// Order-draft funding session creation. The draft is stored as the session snapshot. bStocks 买单支持 market、limit GTC/IOC。限价必须提供正数 Decimal 字符串 quantity 和 limit_price， 不接受非空 amount；省略 time_in_force 默认 gtc，slippage_percent 范围为 0 <= slippage_percent < 100。 基础所需余额 = ceil(quantity × limit_price × 10^settlement_decimals) / 10^settlement_decimals； settlement_decimals 来自服务端选定的主网 USDT / 测试网 TUSDT 资金轨道，不由客户端指定。 GTC 滑点是后续 Keeper 的逐次成交策略，不放宽 limit_price，也不在该基础余额上叠加滑点。 例如 quantity=0.00011951、limit_price=328.26、slippage_percent=0.12 时，基础余额为0.0392303526。 实际最低补资额还取决于目标已有余额；会话建议安全缓冲独立计算，不能将基础余额直接视为跨链发送金额。 bStocks 卖单返回422 funding_not_required；无效限价参数继续按 bStocks 限价校验拒绝。 会话不创建可执行预览、订单或授权动作；补资后仍须重新预览并确认。 
///
/// Properties:
/// * [trade] 
@BuiltValue()
abstract class FundingSessionTradeCreateRequest implements Built<FundingSessionTradeCreateRequest, FundingSessionTradeCreateRequestBuilder> {
  @BuiltValueField(wireName: r'trade')
  OrderPreviewRequest get trade;

  FundingSessionTradeCreateRequest._();

  factory FundingSessionTradeCreateRequest([void updates(FundingSessionTradeCreateRequestBuilder b)]) = _$FundingSessionTradeCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTradeCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTradeCreateRequest> get serializer => _$FundingSessionTradeCreateRequestSerializer();
}

class _$FundingSessionTradeCreateRequestSerializer implements PrimitiveSerializer<FundingSessionTradeCreateRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionTradeCreateRequest, _$FundingSessionTradeCreateRequest];

  @override
  final String wireName = r'FundingSessionTradeCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTradeCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'trade';
    yield serializers.serialize(
      object.trade,
      specifiedType: const FullType(OrderPreviewRequest),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTradeCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTradeCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderPreviewRequest),
          ) as OrderPreviewRequest;
          result.trade.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionTradeCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTradeCreateRequestBuilder();
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

