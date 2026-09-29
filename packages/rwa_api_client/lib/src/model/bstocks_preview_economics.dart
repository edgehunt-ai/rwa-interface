//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_preview_fees.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_confirmation_binding.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_economics_quote_validity.dart';
import 'package:rwa_api_client/src/model/bstocks_fee_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_economics.g.dart';

/// trading fee 以输入 token 计价且已包含在 total_input；不是 BNB gas。 当前 network 为 not_estimated、amount/rate/included 为 null；限价路由的完整交易费为 unavailable，不能伪造0。 confirmation_binding 是服务端确认边界，不会预留余额、锁定未来路由或替代正式 RFQ。 
///
/// Properties:
/// * [blockers] - 当前交易执行的阻塞原因，不是预览计算错误。当前包括 insufficient_balance、 approval_required、price_condition_not_met（仅限 IOC 限价单）；无已识别阻塞时为 []。 客户端应容忍未知原因；旧服务可能省略此字段。余额为零或授权不足时仍返回 HTTP 200 和可靠报价。 买入检查报价资产，卖出检查股票 token；金额以含手续费的 total_input 为准，限价单使用最大所需资金。 GTC 的 price_condition_met=false 表示等待触发，不列为阻塞。 授权完成或充值后应使用新的 Idempotency-Key 刷新预览；同一 key 重放原结果，不刷新余额。 创建订单仍会重新检查余额、授权和执行条件，可能先返回授权动作。 空数组不代表已经确认 gas 足够、完成代付或保证成交；无法取得可靠报价/账户 RPC 数据时仍返回错误。 
/// * [inputAsset] 
/// * [nominalInput] - 十进制字符串，避免浮点误差
/// * [totalInput] - 十进制字符串，避免浮点误差
/// * [inputSemantics] 
/// * [fees] 
/// * [quoteValidity] 
/// * [indicative] 
/// * [requiresNewQuote] 
/// * [confirmationBinding] 
@BuiltValue()
abstract class BstocksPreviewEconomics implements Built<BstocksPreviewEconomics, BstocksPreviewEconomicsBuilder> {
  /// 当前交易执行的阻塞原因，不是预览计算错误。当前包括 insufficient_balance、 approval_required、price_condition_not_met（仅限 IOC 限价单）；无已识别阻塞时为 []。 客户端应容忍未知原因；旧服务可能省略此字段。余额为零或授权不足时仍返回 HTTP 200 和可靠报价。 买入检查报价资产，卖出检查股票 token；金额以含手续费的 total_input 为准，限价单使用最大所需资金。 GTC 的 price_condition_met=false 表示等待触发，不列为阻塞。 授权完成或充值后应使用新的 Idempotency-Key 刷新预览；同一 key 重放原结果，不刷新余额。 创建订单仍会重新检查余额、授权和执行条件，可能先返回授权动作。 空数组不代表已经确认 gas 足够、完成代付或保证成交；无法取得可靠报价/账户 RPC 数据时仍返回错误。 
  @BuiltValueField(wireName: r'blockers')
  BuiltSet<String>? get blockers;

  @BuiltValueField(wireName: r'input_asset')
  BstocksFeeAsset get inputAsset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'nominal_input')
  String? get nominalInput;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_input')
  String get totalInput;

  @BuiltValueField(wireName: r'input_semantics')
  BstocksPreviewEconomicsInputSemanticsEnum get inputSemantics;
  // enum inputSemanticsEnum {  quoted_gross_input,  maximum_funding,  };

  @BuiltValueField(wireName: r'fees')
  BstocksPreviewFees get fees;

  @BuiltValueField(wireName: r'quote_validity')
  BstocksPreviewEconomicsQuoteValidity get quoteValidity;

  @BuiltValueField(wireName: r'indicative')
  bool get indicative;

  @BuiltValueField(wireName: r'requires_new_quote')
  bool get requiresNewQuote;

  @BuiltValueField(wireName: r'confirmation_binding')
  BstocksConfirmationBinding? get confirmationBinding;

  BstocksPreviewEconomics._();

  factory BstocksPreviewEconomics([void updates(BstocksPreviewEconomicsBuilder b)]) = _$BstocksPreviewEconomics;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewEconomicsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewEconomics> get serializer => _$BstocksPreviewEconomicsSerializer();
}

class _$BstocksPreviewEconomicsSerializer implements PrimitiveSerializer<BstocksPreviewEconomics> {
  @override
  final Iterable<Type> types = const [BstocksPreviewEconomics, _$BstocksPreviewEconomics];

  @override
  final String wireName = r'BstocksPreviewEconomics';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewEconomics object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.blockers != null) {
      yield r'blockers';
      yield serializers.serialize(
        object.blockers,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
    yield r'input_asset';
    yield serializers.serialize(
      object.inputAsset,
      specifiedType: const FullType(BstocksFeeAsset),
    );
    yield r'nominal_input';
    yield object.nominalInput == null ? null : serializers.serialize(
      object.nominalInput,
      specifiedType: const FullType.nullable(String),
    );
    yield r'total_input';
    yield serializers.serialize(
      object.totalInput,
      specifiedType: const FullType(String),
    );
    yield r'input_semantics';
    yield serializers.serialize(
      object.inputSemantics,
      specifiedType: const FullType(BstocksPreviewEconomicsInputSemanticsEnum),
    );
    yield r'fees';
    yield serializers.serialize(
      object.fees,
      specifiedType: const FullType(BstocksPreviewFees),
    );
    yield r'quote_validity';
    yield serializers.serialize(
      object.quoteValidity,
      specifiedType: const FullType(BstocksPreviewEconomicsQuoteValidity),
    );
    yield r'indicative';
    yield serializers.serialize(
      object.indicative,
      specifiedType: const FullType(bool),
    );
    yield r'requires_new_quote';
    yield serializers.serialize(
      object.requiresNewQuote,
      specifiedType: const FullType(bool),
    );
    if (object.confirmationBinding != null) {
      yield r'confirmation_binding';
      yield serializers.serialize(
        object.confirmationBinding,
        specifiedType: const FullType(BstocksConfirmationBinding),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewEconomics object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewEconomicsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>?;
          if (valueDes == null) continue;
          result.blockers.replace(valueDes);
          break;
        case r'input_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksFeeAsset),
          ) as BstocksFeeAsset;
          result.inputAsset.replace(valueDes);
          break;
        case r'nominal_input':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nominalInput = valueDes;
          break;
        case r'total_input':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalInput = valueDes;
          break;
        case r'input_semantics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewEconomicsInputSemanticsEnum),
          ) as BstocksPreviewEconomicsInputSemanticsEnum;
          result.inputSemantics = valueDes;
          break;
        case r'fees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewFees),
          ) as BstocksPreviewFees;
          result.fees.replace(valueDes);
          break;
        case r'quote_validity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewEconomicsQuoteValidity),
          ) as BstocksPreviewEconomicsQuoteValidity;
          result.quoteValidity.replace(valueDes);
          break;
        case r'indicative':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.indicative = valueDes;
          break;
        case r'requires_new_quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresNewQuote = valueDes;
          break;
        case r'confirmation_binding':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksConfirmationBinding),
          ) as BstocksConfirmationBinding?;
          if (valueDes == null) continue;
          result.confirmationBinding.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPreviewEconomics deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewEconomicsBuilder();
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

class BstocksPreviewEconomicsInputSemanticsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quoted_gross_input')
  static const BstocksPreviewEconomicsInputSemanticsEnum quotedGrossInput = _$bstocksPreviewEconomicsInputSemanticsEnum_quotedGrossInput;
  @BuiltValueEnumConst(wireName: r'maximum_funding')
  static const BstocksPreviewEconomicsInputSemanticsEnum maximumFunding = _$bstocksPreviewEconomicsInputSemanticsEnum_maximumFunding;

  static Serializer<BstocksPreviewEconomicsInputSemanticsEnum> get serializer => _$bstocksPreviewEconomicsInputSemanticsEnumSerializer;

  const BstocksPreviewEconomicsInputSemanticsEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewEconomicsInputSemanticsEnum> get values => _$bstocksPreviewEconomicsInputSemanticsEnumValues;
  static BstocksPreviewEconomicsInputSemanticsEnum valueOf(String name) => _$bstocksPreviewEconomicsInputSemanticsEnumValueOf(name);
}

