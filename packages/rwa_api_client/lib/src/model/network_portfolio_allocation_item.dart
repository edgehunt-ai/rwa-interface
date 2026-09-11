//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_asset_network.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'network_portfolio_allocation_item.g.dart';

/// NetworkPortfolioAllocationItem
///
/// Properties:
/// * [network] 
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class NetworkPortfolioAllocationItem implements Built<NetworkPortfolioAllocationItem, NetworkPortfolioAllocationItemBuilder> {
  @BuiltValueField(wireName: r'network')
  PortfolioAssetNetwork get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String get valueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String get percent;

  NetworkPortfolioAllocationItem._();

  factory NetworkPortfolioAllocationItem([void updates(NetworkPortfolioAllocationItemBuilder b)]) = _$NetworkPortfolioAllocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NetworkPortfolioAllocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NetworkPortfolioAllocationItem> get serializer => _$NetworkPortfolioAllocationItemSerializer();
}

class _$NetworkPortfolioAllocationItemSerializer implements PrimitiveSerializer<NetworkPortfolioAllocationItem> {
  @override
  final Iterable<Type> types = const [NetworkPortfolioAllocationItem, _$NetworkPortfolioAllocationItem];

  @override
  final String wireName = r'NetworkPortfolioAllocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NetworkPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PortfolioAssetNetwork),
    );
    yield r'value_usd';
    yield serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType(String),
    );
    yield r'percent';
    yield serializers.serialize(
      object.percent,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NetworkPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NetworkPortfolioAllocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAssetNetwork),
          ) as PortfolioAssetNetwork;
          result.network = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valueUsd = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.percent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NetworkPortfolioAllocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NetworkPortfolioAllocationItemBuilder();
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

