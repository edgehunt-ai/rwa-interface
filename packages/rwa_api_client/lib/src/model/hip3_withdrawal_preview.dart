//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_withdrawal_fee_detail.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_withdrawal_rail.dart';
import 'package:rwa_api_client/src/model/hip3_collateral_risk_preview.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_preview.g.dart';

/// Hip3WithdrawalPreview
///
/// Properties:
/// * [amount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [fee] - amount 与 minimum_received 的 USDC 差额；Relay exact-input 包含报价费用及滑点保留，是保守最大扣减，不表示实际已收费。不包含平台承担的ETH Gas，明细不能再重复扣费。
/// * [minimumReceived] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [rail] 
/// * [destinationAddress] 
/// * [chainId] - 冻结的到账链，Arbitrum主网42161 / 测试网421614；旧版BSC USDT relay为56。创建时必须回传此目标链，不能用Hyperliquid签名链代替。
/// * [payoutAsset] - 冻结的到账资产；Arbitrum为USDC（测试网Bridge2对应USDC2代币），BSC relay为USDT。旧版响应可省略；创建后仍须核对payout_chain_id和payout_asset。
/// * [maximumTransferable] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [blockers] 
/// * [estimatedArrivalSeconds] - 从成功提交算起的静态展示预估秒数；当前 float 暂定为 120、bridge2 为 300（官方 withdraw3 约 5 分钟）。不包含用户签名等待；不是实测延迟、截止时间或 SLA，拥堵和资金池异常可能延长到账时间。
/// * [feeDetails] - 按实际通道返回的费用解释。float 返回用户 USDC 提现费 0 和平台承担的 ETH 网络费（未知金额为 null）；bridge2 仅返回用户承担的官方桥提现费，不拆分、不重复增加网络费。仅 user/USDC 项计入 fee，不能跨币种求和。
/// * [riskPreview] 
@BuiltValue()
abstract class Hip3WithdrawalPreview implements Built<Hip3WithdrawalPreview, Hip3WithdrawalPreviewBuilder> {
  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// amount 与 minimum_received 的 USDC 差额；Relay exact-input 包含报价费用及滑点保留，是保守最大扣减，不表示实际已收费。不包含平台承担的ETH Gas，明细不能再重复扣费。
  @BuiltValueField(wireName: r'fee')
  String get fee;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  @BuiltValueField(wireName: r'rail')
  Hip3WithdrawalRail get rail;
  // enum railEnum {  bridge2,  float,  relay,  };

  @BuiltValueField(wireName: r'destination_address')
  String get destinationAddress;

  /// 冻结的到账链，Arbitrum主网42161 / 测试网421614；旧版BSC USDT relay为56。创建时必须回传此目标链，不能用Hyperliquid签名链代替。
  @BuiltValueField(wireName: r'chain_id')
  String get chainId;

  /// 冻结的到账资产；Arbitrum为USDC（测试网Bridge2对应USDC2代币），BSC relay为USDT。旧版响应可省略；创建后仍须核对payout_chain_id和payout_asset。
  @BuiltValueField(wireName: r'payout_asset')
  Hip3WithdrawalPreviewPayoutAssetEnum? get payoutAsset;
  // enum payoutAssetEnum {  USDC,  USDT,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'maximum_transferable')
  String get maximumTransferable;

  @BuiltValueField(wireName: r'blockers')
  BuiltList<Hip3WithdrawalPreviewBlockersEnum> get blockers;
  // enum blockersEnum {  insufficient_withdrawable_balance,  };

  /// 从成功提交算起的静态展示预估秒数；当前 float 暂定为 120、bridge2 为 300（官方 withdraw3 约 5 分钟）。不包含用户签名等待；不是实测延迟、截止时间或 SLA，拥堵和资金池异常可能延长到账时间。
  @BuiltValueField(wireName: r'estimated_arrival_seconds')
  int get estimatedArrivalSeconds;

  /// 按实际通道返回的费用解释。float 返回用户 USDC 提现费 0 和平台承担的 ETH 网络费（未知金额为 null）；bridge2 仅返回用户承担的官方桥提现费，不拆分、不重复增加网络费。仅 user/USDC 项计入 fee，不能跨币种求和。
  @BuiltValueField(wireName: r'fee_details')
  BuiltList<Hip3WithdrawalFeeDetail> get feeDetails;

  @BuiltValueField(wireName: r'risk_preview')
  Hip3CollateralRiskPreview get riskPreview;

  Hip3WithdrawalPreview._();

  factory Hip3WithdrawalPreview([void updates(Hip3WithdrawalPreviewBuilder b)]) = _$Hip3WithdrawalPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalPreview> get serializer => _$Hip3WithdrawalPreviewSerializer();
}

class _$Hip3WithdrawalPreviewSerializer implements PrimitiveSerializer<Hip3WithdrawalPreview> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalPreview, _$Hip3WithdrawalPreview];

  @override
  final String wireName = r'Hip3WithdrawalPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(String),
    );
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(Hip3WithdrawalRail),
    );
    yield r'destination_address';
    yield serializers.serialize(
      object.destinationAddress,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(String),
    );
    if (object.payoutAsset != null) {
      yield r'payout_asset';
      yield serializers.serialize(
        object.payoutAsset,
        specifiedType: const FullType(Hip3WithdrawalPreviewPayoutAssetEnum),
      );
    }
    yield r'maximum_transferable';
    yield serializers.serialize(
      object.maximumTransferable,
      specifiedType: const FullType(String),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalPreviewBlockersEnum)]),
    );
    yield r'estimated_arrival_seconds';
    yield serializers.serialize(
      object.estimatedArrivalSeconds,
      specifiedType: const FullType(int),
    );
    yield r'fee_details';
    yield serializers.serialize(
      object.feeDetails,
      specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalFeeDetail)]),
    );
    yield r'risk_preview';
    yield serializers.serialize(
      object.riskPreview,
      specifiedType: const FullType(Hip3CollateralRiskPreview),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fee = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3WithdrawalRail),
          ) as Hip3WithdrawalRail;
          result.rail = valueDes;
          break;
        case r'destination_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAddress = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chainId = valueDes;
          break;
        case r'payout_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3WithdrawalPreviewPayoutAssetEnum),
          ) as Hip3WithdrawalPreviewPayoutAssetEnum?;
          if (valueDes == null) continue;
          result.payoutAsset = valueDes;
          break;
        case r'maximum_transferable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maximumTransferable = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalPreviewBlockersEnum)]),
          ) as BuiltList<Hip3WithdrawalPreviewBlockersEnum>;
          result.blockers.replace(valueDes);
          break;
        case r'estimated_arrival_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimatedArrivalSeconds = valueDes;
          break;
        case r'fee_details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3WithdrawalFeeDetail)]),
          ) as BuiltList<Hip3WithdrawalFeeDetail>;
          result.feeDetails.replace(valueDes);
          break;
        case r'risk_preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CollateralRiskPreview),
          ) as Hip3CollateralRiskPreview;
          result.riskPreview.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalPreviewBuilder();
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

class Hip3WithdrawalPreviewPayoutAssetEnum extends EnumClass {

  /// 冻结的到账资产；Arbitrum为USDC（测试网Bridge2对应USDC2代币），BSC relay为USDT。旧版响应可省略；创建后仍须核对payout_chain_id和payout_asset。
  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3WithdrawalPreviewPayoutAssetEnum USDC = _$hip3WithdrawalPreviewPayoutAssetEnum_USDC;
  /// 冻结的到账资产；Arbitrum为USDC（测试网Bridge2对应USDC2代币），BSC relay为USDT。旧版响应可省略；创建后仍须核对payout_chain_id和payout_asset。
  @BuiltValueEnumConst(wireName: r'USDT')
  static const Hip3WithdrawalPreviewPayoutAssetEnum USDT = _$hip3WithdrawalPreviewPayoutAssetEnum_USDT;

  static Serializer<Hip3WithdrawalPreviewPayoutAssetEnum> get serializer => _$hip3WithdrawalPreviewPayoutAssetEnumSerializer;

  const Hip3WithdrawalPreviewPayoutAssetEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalPreviewPayoutAssetEnum> get values => _$hip3WithdrawalPreviewPayoutAssetEnumValues;
  static Hip3WithdrawalPreviewPayoutAssetEnum valueOf(String name) => _$hip3WithdrawalPreviewPayoutAssetEnumValueOf(name);
}

class Hip3WithdrawalPreviewBlockersEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'insufficient_withdrawable_balance')
  static const Hip3WithdrawalPreviewBlockersEnum insufficientWithdrawableBalance = _$hip3WithdrawalPreviewBlockersEnum_insufficientWithdrawableBalance;

  static Serializer<Hip3WithdrawalPreviewBlockersEnum> get serializer => _$hip3WithdrawalPreviewBlockersEnumSerializer;

  const Hip3WithdrawalPreviewBlockersEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalPreviewBlockersEnum> get values => _$hip3WithdrawalPreviewBlockersEnumValues;
  static Hip3WithdrawalPreviewBlockersEnum valueOf(String name) => _$hip3WithdrawalPreviewBlockersEnumValueOf(name);
}

