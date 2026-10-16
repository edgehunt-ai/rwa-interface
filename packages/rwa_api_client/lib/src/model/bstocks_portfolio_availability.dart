//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_portfolio_availability.g.dart';

/// 平台账户钱包级可用数量投影；不是链上托管或真实锁币。GTC按未成交剩余量占用，待执行IOC按最大输入占用。 生成可执行动作即占用；approval和仅预览不占用。canonical订单替代动作占用，不重复计算。 部分成交减少占用，完全成交或撤单确认后释放；申请撤单或本地超时不提前释放。缺少钱包身份时数量为null。 
///
/// Properties:
/// * [rail] 
/// * [productId] 
/// * [withdrawalAssetId] - 可用于自托管提现asset_id的服务端链/token身份，不等同于顶层内部asset_id。
/// * [pendingWithdrawalQuantity] - 已创建尚未结算的提现占用，包括等待签名/提交、确认中及未决结果；身份或覆盖未知时为null。不是已确认支出。
/// * [availableQuantity] - 钱包余额减去平台订单、转账/补资及提现占用后的可用数量，下限为0；待签名可执行交易也占用。用于提现额度/Max及卖出数量校验，不是美元金额或执行保证；未知时为null，不得回退到总余额。
/// * [unavailableQuantity] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [reservationQuantity] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [availabilityStatus] 
/// * [unavailableReasons] 
@BuiltValue()
abstract class BstocksPortfolioAvailability implements Built<BstocksPortfolioAvailability, BstocksPortfolioAvailabilityBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstocksPortfolioAvailabilityRailEnum get rail;
  // enum railEnum {  bstocks,  };

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  /// 可用于自托管提现asset_id的服务端链/token身份，不等同于顶层内部asset_id。
  @BuiltValueField(wireName: r'withdrawal_asset_id')
  String? get withdrawalAssetId;

  /// 已创建尚未结算的提现占用，包括等待签名/提交、确认中及未决结果；身份或覆盖未知时为null。不是已确认支出。
  @BuiltValueField(wireName: r'pending_withdrawal_quantity')
  String? get pendingWithdrawalQuantity;

  /// 钱包余额减去平台订单、转账/补资及提现占用后的可用数量，下限为0；待签名可执行交易也占用。用于提现额度/Max及卖出数量校验，不是美元金额或执行保证；未知时为null，不得回退到总余额。
  @BuiltValueField(wireName: r'available_quantity')
  String? get availableQuantity;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'unavailable_quantity')
  String? get unavailableQuantity;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'reservation_quantity')
  String? get reservationQuantity;

  @BuiltValueField(wireName: r'availability_status')
  BstocksPortfolioAvailabilityAvailabilityStatusEnum get availabilityStatus;
  // enum availabilityStatusEnum {  complete,  partial,  unavailable,  };

  @BuiltValueField(wireName: r'unavailable_reasons')
  BuiltList<BstocksPortfolioAvailabilityUnavailableReasonsEnum> get unavailableReasons;
  // enum unavailableReasonsEnum {  wallet_identity_unavailable,  confirmed_gtc_sell,  submitted_gtc_sell,  reservation_exceeds_balance,  platform_order,  pending_transfer,  pending_withdrawal,  };

  BstocksPortfolioAvailability._();

  factory BstocksPortfolioAvailability([void updates(BstocksPortfolioAvailabilityBuilder b)]) = _$BstocksPortfolioAvailability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPortfolioAvailabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPortfolioAvailability> get serializer => _$BstocksPortfolioAvailabilitySerializer();
}

class _$BstocksPortfolioAvailabilitySerializer implements PrimitiveSerializer<BstocksPortfolioAvailability> {
  @override
  final Iterable<Type> types = const [BstocksPortfolioAvailability, _$BstocksPortfolioAvailability];

  @override
  final String wireName = r'BstocksPortfolioAvailability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPortfolioAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstocksPortfolioAvailabilityRailEnum),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    if (object.withdrawalAssetId != null) {
      yield r'withdrawal_asset_id';
      yield serializers.serialize(
        object.withdrawalAssetId,
        specifiedType: const FullType(String),
      );
    }
    if (object.pendingWithdrawalQuantity != null) {
      yield r'pending_withdrawal_quantity';
      yield serializers.serialize(
        object.pendingWithdrawalQuantity,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'available_quantity';
    yield object.availableQuantity == null ? null : serializers.serialize(
      object.availableQuantity,
      specifiedType: const FullType.nullable(String),
    );
    yield r'unavailable_quantity';
    yield object.unavailableQuantity == null ? null : serializers.serialize(
      object.unavailableQuantity,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reservation_quantity';
    yield object.reservationQuantity == null ? null : serializers.serialize(
      object.reservationQuantity,
      specifiedType: const FullType.nullable(String),
    );
    yield r'availability_status';
    yield serializers.serialize(
      object.availabilityStatus,
      specifiedType: const FullType(BstocksPortfolioAvailabilityAvailabilityStatusEnum),
    );
    yield r'unavailable_reasons';
    yield serializers.serialize(
      object.unavailableReasons,
      specifiedType: const FullType(BuiltList, [FullType(BstocksPortfolioAvailabilityUnavailableReasonsEnum)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPortfolioAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPortfolioAvailabilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPortfolioAvailabilityRailEnum),
          ) as BstocksPortfolioAvailabilityRailEnum;
          result.rail = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'withdrawal_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.withdrawalAssetId = valueDes;
          break;
        case r'pending_withdrawal_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pendingWithdrawalQuantity = valueDes;
          break;
        case r'available_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.availableQuantity = valueDes;
          break;
        case r'unavailable_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unavailableQuantity = valueDes;
          break;
        case r'reservation_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reservationQuantity = valueDes;
          break;
        case r'availability_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPortfolioAvailabilityAvailabilityStatusEnum),
          ) as BstocksPortfolioAvailabilityAvailabilityStatusEnum;
          result.availabilityStatus = valueDes;
          break;
        case r'unavailable_reasons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BstocksPortfolioAvailabilityUnavailableReasonsEnum)]),
          ) as BuiltList<BstocksPortfolioAvailabilityUnavailableReasonsEnum>;
          result.unavailableReasons.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPortfolioAvailability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPortfolioAvailabilityBuilder();
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

class BstocksPortfolioAvailabilityRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstocks')
  static const BstocksPortfolioAvailabilityRailEnum bstocks = _$bstocksPortfolioAvailabilityRailEnum_bstocks;

  static Serializer<BstocksPortfolioAvailabilityRailEnum> get serializer => _$bstocksPortfolioAvailabilityRailEnumSerializer;

  const BstocksPortfolioAvailabilityRailEnum._(String name): super(name);

  static BuiltSet<BstocksPortfolioAvailabilityRailEnum> get values => _$bstocksPortfolioAvailabilityRailEnumValues;
  static BstocksPortfolioAvailabilityRailEnum valueOf(String name) => _$bstocksPortfolioAvailabilityRailEnumValueOf(name);
}

class BstocksPortfolioAvailabilityAvailabilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'complete')
  static const BstocksPortfolioAvailabilityAvailabilityStatusEnum complete = _$bstocksPortfolioAvailabilityAvailabilityStatusEnum_complete;
  @BuiltValueEnumConst(wireName: r'partial')
  static const BstocksPortfolioAvailabilityAvailabilityStatusEnum partial = _$bstocksPortfolioAvailabilityAvailabilityStatusEnum_partial;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const BstocksPortfolioAvailabilityAvailabilityStatusEnum unavailable = _$bstocksPortfolioAvailabilityAvailabilityStatusEnum_unavailable;

  static Serializer<BstocksPortfolioAvailabilityAvailabilityStatusEnum> get serializer => _$bstocksPortfolioAvailabilityAvailabilityStatusEnumSerializer;

  const BstocksPortfolioAvailabilityAvailabilityStatusEnum._(String name): super(name);

  static BuiltSet<BstocksPortfolioAvailabilityAvailabilityStatusEnum> get values => _$bstocksPortfolioAvailabilityAvailabilityStatusEnumValues;
  static BstocksPortfolioAvailabilityAvailabilityStatusEnum valueOf(String name) => _$bstocksPortfolioAvailabilityAvailabilityStatusEnumValueOf(name);
}

class BstocksPortfolioAvailabilityUnavailableReasonsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'wallet_identity_unavailable')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum walletIdentityUnavailable = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_walletIdentityUnavailable;
  @BuiltValueEnumConst(wireName: r'confirmed_gtc_sell')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum confirmedGtcSell = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_confirmedGtcSell;
  @BuiltValueEnumConst(wireName: r'submitted_gtc_sell')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum submittedGtcSell = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_submittedGtcSell;
  @BuiltValueEnumConst(wireName: r'reservation_exceeds_balance')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum reservationExceedsBalance = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_reservationExceedsBalance;
  @BuiltValueEnumConst(wireName: r'platform_order')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum platformOrder = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_platformOrder;
  @BuiltValueEnumConst(wireName: r'pending_transfer')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum pendingTransfer = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_pendingTransfer;
  @BuiltValueEnumConst(wireName: r'pending_withdrawal')
  static const BstocksPortfolioAvailabilityUnavailableReasonsEnum pendingWithdrawal = _$bstocksPortfolioAvailabilityUnavailableReasonsEnum_pendingWithdrawal;

  static Serializer<BstocksPortfolioAvailabilityUnavailableReasonsEnum> get serializer => _$bstocksPortfolioAvailabilityUnavailableReasonsEnumSerializer;

  const BstocksPortfolioAvailabilityUnavailableReasonsEnum._(String name): super(name);

  static BuiltSet<BstocksPortfolioAvailabilityUnavailableReasonsEnum> get values => _$bstocksPortfolioAvailabilityUnavailableReasonsEnumValues;
  static BstocksPortfolioAvailabilityUnavailableReasonsEnum valueOf(String name) => _$bstocksPortfolioAvailabilityUnavailableReasonsEnumValueOf(name);
}

