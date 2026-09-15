//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:rwa_api_client/src/model/token_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_balance.g.dart';

/// AccountBalance
///
/// Properties:
/// * [account] 
/// * [label] 
/// * [address] 
/// * [walletId] - 服务端已验证钱包标识；不接受客户端作为资产所有权输入。
/// * [chain] 
/// * [totalValueUsd] - 该账户已成功估值资产的合计。没有任何资产估值成功时为 `null`， 不得把未估值资产当作零价值计入。 
/// * [availableUsd] - 该账户可用于下单的金额，语义由 `available_requires_transfer` 限定：  * `available_requires_transfer: false`（venue 账户，如 `hip3`）——   来自 venue 上报的 withdrawable/available collateral，可直接下单； * `available_requires_transfer: true`（钱包账户，如 `app`、`bstocks`）——   钱包中已估值稳定币的小计，下单前必须先 Transfer 到交易账户。   跨链路由存在手续费、gas 与滑点，实际可交割金额以 Funding Plan 询价为准，   该值只是上界近似，不是下单承诺。  来源缺失、报价失败或该账户无可用资产时为 `null`，不得回退为 `\"0\"`。 
/// * [availableRequiresTransfer] - `available_usd` 是否需要先经 Transfer/Funding Plan 才能用于下单。 venue 账户为 `false`，钱包账户为 `true`。客户端不得把 `true` 的金额 展示为「立即可交易」。 
/// * [marginUsedUsd] - 十进制字符串，避免浮点误差
/// * [balances] 
@BuiltValue()
abstract class AccountBalance implements Built<AccountBalance, AccountBalanceBuilder> {
  @BuiltValueField(wireName: r'account')
  AccountKind get account;
  // enum accountEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'address')
  String? get address;

  /// 服务端已验证钱包标识；不接受客户端作为资产所有权输入。
  @BuiltValueField(wireName: r'wallet_id')
  String? get walletId;

  @BuiltValueField(wireName: r'chain')
  Chain? get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 该账户已成功估值资产的合计。没有任何资产估值成功时为 `null`， 不得把未估值资产当作零价值计入。 
  @BuiltValueField(wireName: r'total_value_usd')
  String? get totalValueUsd;

  /// 该账户可用于下单的金额，语义由 `available_requires_transfer` 限定：  * `available_requires_transfer: false`（venue 账户，如 `hip3`）——   来自 venue 上报的 withdrawable/available collateral，可直接下单； * `available_requires_transfer: true`（钱包账户，如 `app`、`bstocks`）——   钱包中已估值稳定币的小计，下单前必须先 Transfer 到交易账户。   跨链路由存在手续费、gas 与滑点，实际可交割金额以 Funding Plan 询价为准，   该值只是上界近似，不是下单承诺。  来源缺失、报价失败或该账户无可用资产时为 `null`，不得回退为 `\"0\"`。 
  @BuiltValueField(wireName: r'available_usd')
  String? get availableUsd;

  /// `available_usd` 是否需要先经 Transfer/Funding Plan 才能用于下单。 venue 账户为 `false`，钱包账户为 `true`。客户端不得把 `true` 的金额 展示为「立即可交易」。 
  @BuiltValueField(wireName: r'available_requires_transfer')
  bool? get availableRequiresTransfer;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'margin_used_usd')
  String? get marginUsedUsd;

  @BuiltValueField(wireName: r'balances')
  BuiltList<TokenBalance> get balances;

  AccountBalance._();

  factory AccountBalance([void updates(AccountBalanceBuilder b)]) = _$AccountBalance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountBalanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountBalance> get serializer => _$AccountBalanceSerializer();
}

class _$AccountBalanceSerializer implements PrimitiveSerializer<AccountBalance> {
  @override
  final Iterable<Type> types = const [AccountBalance, _$AccountBalance];

  @override
  final String wireName = r'AccountBalance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account';
    yield serializers.serialize(
      object.account,
      specifiedType: const FullType(AccountKind),
    );
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.walletId != null) {
      yield r'wallet_id';
      yield serializers.serialize(
        object.walletId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.chain != null) {
      yield r'chain';
      yield serializers.serialize(
        object.chain,
        specifiedType: const FullType(Chain),
      );
    }
    if (object.totalValueUsd != null) {
      yield r'total_value_usd';
      yield serializers.serialize(
        object.totalValueUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.availableUsd != null) {
      yield r'available_usd';
      yield serializers.serialize(
        object.availableUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.availableRequiresTransfer != null) {
      yield r'available_requires_transfer';
      yield serializers.serialize(
        object.availableRequiresTransfer,
        specifiedType: const FullType(bool),
      );
    }
    if (object.marginUsedUsd != null) {
      yield r'margin_used_usd';
      yield serializers.serialize(
        object.marginUsedUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'balances';
    yield serializers.serialize(
      object.balances,
      specifiedType: const FullType(BuiltList, [FullType(TokenBalance)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountBalanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountKind),
          ) as AccountKind;
          result.account = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.walletId = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Chain),
          ) as Chain?;
          if (valueDes == null) continue;
          result.chain = valueDes;
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totalValueUsd = valueDes;
          break;
        case r'available_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.availableUsd = valueDes;
          break;
        case r'available_requires_transfer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.availableRequiresTransfer = valueDes;
          break;
        case r'margin_used_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marginUsedUsd = valueDes;
          break;
        case r'balances':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TokenBalance)]),
          ) as BuiltList<TokenBalance>;
          result.balances.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountBalance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountBalanceBuilder();
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

