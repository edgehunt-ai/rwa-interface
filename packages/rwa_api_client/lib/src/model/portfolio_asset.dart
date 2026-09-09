//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_price_source.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_warning_code.dart';
import 'package:rwa_api_client/src/model/portfolio_asset_source_kind.dart';
import 'package:rwa_api_client/src/model/portfolio_asset_network.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_asset.g.dart';

/// 只读余额事实。EVM 资产的 network 仅使用 BSC、Arbitrum、Base、Ethereum 四链 allowlist；venue 资产使用 Hyperliquid。任何标识都由服务端已验证的 用户钱包集合或 venue account 派生，客户端不能覆盖所有权输入。 
///
/// Properties:
/// * [assetId] 
/// * [source_] 
/// * [network] 
/// * [walletId] 
/// * [accountRef] - Server-issued opaque account reference; clients cannot override it.
/// * [contractAddress] 
/// * [native_] 
/// * [symbol] 
/// * [decimals] 
/// * [balanceRaw] - 无符号十进制整数形式的最小单位余额，不允许小数点或负号。
/// * [balance] - 十进制字符串，避免浮点误差
/// * [priceUsd] - 十进制字符串，避免浮点误差
/// * [pricingSource] - USD 估值来源；不代表余额或钱包所有权来源。
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [observedAt] 
/// * [blockNumber] 
/// * [blockHash] 
/// * [freshness] 
/// * [warnings] 
@BuiltValue()
abstract class PortfolioAsset implements Built<PortfolioAsset, PortfolioAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'source')
  PortfolioAssetSourceKind get source_;
  // enum source_Enum {  evm_rpc,  hyperliquid_info,  };

  @BuiltValueField(wireName: r'network')
  PortfolioAssetNetwork get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  };

  @BuiltValueField(wireName: r'wallet_id')
  String? get walletId;

  /// Server-issued opaque account reference; clients cannot override it.
  @BuiltValueField(wireName: r'account_ref')
  String? get accountRef;

  @BuiltValueField(wireName: r'contract_address')
  String? get contractAddress;

  @BuiltValueField(wireName: r'native')
  bool get native_;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  /// 无符号十进制整数形式的最小单位余额，不允许小数点或负号。
  @BuiltValueField(wireName: r'balance_raw')
  String get balanceRaw;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'balance')
  String get balance;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price_usd')
  String? get priceUsd;

  /// USD 估值来源；不代表余额或钱包所有权来源。
  @BuiltValueField(wireName: r'pricing_source')
  PortfolioPriceSource get pricingSource;
  // enum pricingSourceEnum {  fixed_peg,  dodoex,  unavailable,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'block_number')
  int? get blockNumber;

  @BuiltValueField(wireName: r'block_hash')
  String? get blockHash;

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioWarningCode> get warnings;

  PortfolioAsset._();

  factory PortfolioAsset([void updates(PortfolioAssetBuilder b)]) = _$PortfolioAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAsset> get serializer => _$PortfolioAssetSerializer();
}

class _$PortfolioAssetSerializer implements PrimitiveSerializer<PortfolioAsset> {
  @override
  final Iterable<Type> types = const [PortfolioAsset, _$PortfolioAsset];

  @override
  final String wireName = r'PortfolioAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(PortfolioAssetSourceKind),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PortfolioAssetNetwork),
    );
    if (object.walletId != null) {
      yield r'wallet_id';
      yield serializers.serialize(
        object.walletId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.accountRef != null) {
      yield r'account_ref';
      yield serializers.serialize(
        object.accountRef,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.contractAddress != null) {
      yield r'contract_address';
      yield serializers.serialize(
        object.contractAddress,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'native';
    yield serializers.serialize(
      object.native_,
      specifiedType: const FullType(bool),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
    yield r'balance_raw';
    yield serializers.serialize(
      object.balanceRaw,
      specifiedType: const FullType(String),
    );
    yield r'balance';
    yield serializers.serialize(
      object.balance,
      specifiedType: const FullType(String),
    );
    if (object.priceUsd != null) {
      yield r'price_usd';
      yield serializers.serialize(
        object.priceUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'pricing_source';
    yield serializers.serialize(
      object.pricingSource,
      specifiedType: const FullType(PortfolioPriceSource),
    );
    if (object.valueUsd != null) {
      yield r'value_usd';
      yield serializers.serialize(
        object.valueUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.blockNumber != null) {
      yield r'block_number';
      yield serializers.serialize(
        object.blockNumber,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.blockHash != null) {
      yield r'block_hash';
      yield serializers.serialize(
        object.blockHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioWarningCode)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAssetSourceKind),
          ) as PortfolioAssetSourceKind;
          result.source_ = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAssetNetwork),
          ) as PortfolioAssetNetwork;
          result.network = valueDes;
          break;
        case r'wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.walletId = valueDes;
          break;
        case r'account_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountRef = valueDes;
          break;
        case r'contract_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contractAddress = valueDes;
          break;
        case r'native':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.native_ = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.decimals = valueDes;
          break;
        case r'balance_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.balanceRaw = valueDes;
          break;
        case r'balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.balance = valueDes;
          break;
        case r'price_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.priceUsd = valueDes;
          break;
        case r'pricing_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioPriceSource),
          ) as PortfolioPriceSource;
          result.pricingSource = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'block_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.blockNumber = valueDes;
          break;
        case r'block_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.blockHash = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioWarningCode)]),
          ) as BuiltList<PortfolioWarningCode>;
          result.warnings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAssetBuilder();
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

