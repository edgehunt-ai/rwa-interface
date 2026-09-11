//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_funding_payment.g.dart';

/// 独立钱包资金费结算事实，不要求存在App订单或当前持仓。amount保留上游usdc字段的实际符号（收取为正、支付为负），不得累计快照反推。 settlement_asset/collateral_token成对来自该DEX的当前权威元数据；上游字段名usdc本身不是抵押币种证明。无法解析时两者null，仍保留原始金额，不做USD估值。 id在同一钱包/环境及事件身份下稳定；可用于不同请求窗口重叠事件去重。不是App订单ID。 
///
/// Properties:
/// * [id] 
/// * [productId] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [settlementAsset] 
/// * [collateralToken] 
/// * [signedPositionSize] - 十进制字符串，避免浮点误差
/// * [fundingRate] - 十进制字符串，避免浮点误差
/// * [transactionHash] 
/// * [occurredAt] 
@BuiltValue()
abstract class Hip3FundingPayment implements Built<Hip3FundingPayment, Hip3FundingPaymentBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'settlement_asset')
  String? get settlementAsset;

  @BuiltValueField(wireName: r'collateral_token')
  int? get collateralToken;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'signed_position_size')
  String get signedPositionSize;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'funding_rate')
  String get fundingRate;

  @BuiltValueField(wireName: r'transaction_hash')
  String get transactionHash;

  @BuiltValueField(wireName: r'occurred_at')
  DateTime get occurredAt;

  Hip3FundingPayment._();

  factory Hip3FundingPayment([void updates(Hip3FundingPaymentBuilder b)]) = _$Hip3FundingPayment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3FundingPaymentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3FundingPayment> get serializer => _$Hip3FundingPaymentSerializer();
}

class _$Hip3FundingPaymentSerializer implements PrimitiveSerializer<Hip3FundingPayment> {
  @override
  final Iterable<Type> types = const [Hip3FundingPayment, _$Hip3FundingPayment];

  @override
  final String wireName = r'Hip3FundingPayment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3FundingPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'settlement_asset';
    yield object.settlementAsset == null ? null : serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType.nullable(String),
    );
    yield r'collateral_token';
    yield object.collateralToken == null ? null : serializers.serialize(
      object.collateralToken,
      specifiedType: const FullType.nullable(int),
    );
    yield r'signed_position_size';
    yield serializers.serialize(
      object.signedPositionSize,
      specifiedType: const FullType(String),
    );
    yield r'funding_rate';
    yield serializers.serialize(
      object.fundingRate,
      specifiedType: const FullType(String),
    );
    yield r'transaction_hash';
    yield serializers.serialize(
      object.transactionHash,
      specifiedType: const FullType(String),
    );
    yield r'occurred_at';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3FundingPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3FundingPaymentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.settlementAsset = valueDes;
          break;
        case r'collateral_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.collateralToken = valueDes;
          break;
        case r'signed_position_size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signedPositionSize = valueDes;
          break;
        case r'funding_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fundingRate = valueDes;
          break;
        case r'transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionHash = valueDes;
          break;
        case r'occurred_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3FundingPayment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3FundingPaymentBuilder();
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

