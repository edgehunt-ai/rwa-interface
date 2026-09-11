//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_asset.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_summary.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_balance.g.dart';

/// 当前唯一已绑定Hyperliquid钱包的外部资产快照，不是AccountBalance内部账本。 共享抵押物只计一次，包含同钱包原生perps贡献，不按HIP3产品分摊。 保留summary的partial/stale及未估值标记；不表示本次已查询确认统一账户模式。 
///
/// Properties:
/// * [scope] 
/// * [signer] 
/// * [environment] 
/// * [summary] 
/// * [assets] 
@BuiltValue()
abstract class Hip3RealtimeBalance implements Built<Hip3RealtimeBalance, Hip3RealtimeBalanceBuilder> {
  @BuiltValueField(wireName: r'scope')
  Hip3RealtimeBalanceScopeEnum get scope;
  // enum scopeEnum {  hyperliquid_wallet,  };

  @BuiltValueField(wireName: r'signer')
  String get signer;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'summary')
  PortfolioSummary get summary;

  @BuiltValueField(wireName: r'assets')
  BuiltList<PortfolioAsset> get assets;

  Hip3RealtimeBalance._();

  factory Hip3RealtimeBalance([void updates(Hip3RealtimeBalanceBuilder b)]) = _$Hip3RealtimeBalance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeBalanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeBalance> get serializer => _$Hip3RealtimeBalanceSerializer();
}

class _$Hip3RealtimeBalanceSerializer implements PrimitiveSerializer<Hip3RealtimeBalance> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeBalance, _$Hip3RealtimeBalance];

  @override
  final String wireName = r'Hip3RealtimeBalance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(Hip3RealtimeBalanceScopeEnum),
    );
    yield r'signer';
    yield serializers.serialize(
      object.signer,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(PortfolioSummary),
    );
    yield r'assets';
    yield serializers.serialize(
      object.assets,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioAsset)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeBalanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeBalanceScopeEnum),
          ) as Hip3RealtimeBalanceScopeEnum;
          result.scope = valueDes;
          break;
        case r'signer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signer = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioSummary),
          ) as PortfolioSummary;
          result.summary.replace(valueDes);
          break;
        case r'assets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioAsset)]),
          ) as BuiltList<PortfolioAsset>;
          result.assets.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimeBalance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeBalanceBuilder();
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

class Hip3RealtimeBalanceScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid_wallet')
  static const Hip3RealtimeBalanceScopeEnum hyperliquidWallet = _$hip3RealtimeBalanceScopeEnum_hyperliquidWallet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeBalanceScopeEnum unknownDefaultOpenApi = _$hip3RealtimeBalanceScopeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeBalanceScopeEnum> get serializer => _$hip3RealtimeBalanceScopeEnumSerializer;

  const Hip3RealtimeBalanceScopeEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeBalanceScopeEnum> get values => _$hip3RealtimeBalanceScopeEnumValues;
  static Hip3RealtimeBalanceScopeEnum valueOf(String name) => _$hip3RealtimeBalanceScopeEnumValueOf(name);
}

