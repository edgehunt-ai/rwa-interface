//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/self_custodial_withdrawal_chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_create_request.g.dart';

/// 创建审计 intent 所需的精确用户选择。`wallet_id` 必须属于当前账户的已验证 Privy wallet；bStocks专用路径要求manifest/support catalog共同准入。其他路径仅接受所选钱包 portfolio中观测到、位于当前环境允许链上的非原生ERC-20，精度和符号由服务端恢复；不是任意合约调用。 请求只包含产品意图， 不接受 `chain_id/from/to/data/value/payload_hash/valid_until`、签名或 raw transaction； 服务端不会根据本请求 approve、sign 或 broadcast。 
///
/// Properties:
/// * [walletId] - 当前账户已有的服务端不透明 Privy wallet ID。
/// * [assetId] - 当前环境允许的 canonical ERC-20 asset identity；bStocks使用准入身份，其他资产须由所选钱包的portfolio观察提供元数据。
/// * [chain] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [destinationAddress] 
@BuiltValue()
abstract class SelfCustodialWithdrawalCreateRequest implements Built<SelfCustodialWithdrawalCreateRequest, SelfCustodialWithdrawalCreateRequestBuilder> {
  /// 当前账户已有的服务端不透明 Privy wallet ID。
  @BuiltValueField(wireName: r'wallet_id')
  String get walletId;

  /// 当前环境允许的 canonical ERC-20 asset identity；bStocks使用准入身份，其他资产须由所选钱包的portfolio观察提供元数据。
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'chain')
  SelfCustodialWithdrawalChain get chain;
  // enum chainEnum {  Ethereum,  Arbitrum,  Base,  BSC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'destination_address')
  String get destinationAddress;

  SelfCustodialWithdrawalCreateRequest._();

  factory SelfCustodialWithdrawalCreateRequest([void updates(SelfCustodialWithdrawalCreateRequestBuilder b)]) = _$SelfCustodialWithdrawalCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SelfCustodialWithdrawalCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SelfCustodialWithdrawalCreateRequest> get serializer => _$SelfCustodialWithdrawalCreateRequestSerializer();
}

class _$SelfCustodialWithdrawalCreateRequestSerializer implements PrimitiveSerializer<SelfCustodialWithdrawalCreateRequest> {
  @override
  final Iterable<Type> types = const [SelfCustodialWithdrawalCreateRequest, _$SelfCustodialWithdrawalCreateRequest];

  @override
  final String wireName = r'SelfCustodialWithdrawalCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SelfCustodialWithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'wallet_id';
    yield serializers.serialize(
      object.walletId,
      specifiedType: const FullType(String),
    );
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(SelfCustodialWithdrawalChain),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'destination_address';
    yield serializers.serialize(
      object.destinationAddress,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SelfCustodialWithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SelfCustodialWithdrawalCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletId = valueDes;
          break;
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SelfCustodialWithdrawalChain),
          ) as SelfCustodialWithdrawalChain;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'destination_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAddress = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SelfCustodialWithdrawalCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SelfCustodialWithdrawalCreateRequestBuilder();
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

