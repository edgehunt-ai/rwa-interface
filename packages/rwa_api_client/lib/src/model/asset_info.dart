//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'asset_info.g.dart';

/// 资产详情与权益。bStocks 披露由运营配置并精确绑定 product_id、chain_id、token contract 及有效期；configured 仅表示配置当前有效，不代表平台已独立核实发行人主张。 
///
/// Properties:
/// * [title] 
/// * [badge] 
/// * [description] 
/// * [rows] - 权益明细。当前 bStocks 披露项为 Issuer、Asset backing、Custody、Dividends、 Corporate actions、Voting rights；缺失、未生效或过期字段展示 unavailable，不能推断为无投票权。 Disclosure status 为 not_provided、not_yet_current、expired 或 configured；有配置记录时 还返回 Disclosure source、Disclosure as of、Disclosure expires 字符串行。不要依赖固定数组下标。 HIP-3 典型项：产品形态 / 底层权益 / 保证金模式 / 股息再投资 / 资金费率 / 费率方向 / 资产结果。 
@BuiltValue()
abstract class AssetInfo implements Built<AssetInfo, AssetInfoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'badge')
  String get badge;

  @BuiltValueField(wireName: r'description')
  String get description;

  /// 权益明细。当前 bStocks 披露项为 Issuer、Asset backing、Custody、Dividends、 Corporate actions、Voting rights；缺失、未生效或过期字段展示 unavailable，不能推断为无投票权。 Disclosure status 为 not_provided、not_yet_current、expired 或 configured；有配置记录时 还返回 Disclosure source、Disclosure as of、Disclosure expires 字符串行。不要依赖固定数组下标。 HIP-3 典型项：产品形态 / 底层权益 / 保证金模式 / 股息再投资 / 资金费率 / 费率方向 / 资产结果。 
  @BuiltValueField(wireName: r'rows')
  BuiltList<KeyValue> get rows;

  AssetInfo._();

  factory AssetInfo([void updates(AssetInfoBuilder b)]) = _$AssetInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssetInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssetInfo> get serializer => _$AssetInfoSerializer();
}

class _$AssetInfoSerializer implements PrimitiveSerializer<AssetInfo> {
  @override
  final Iterable<Type> types = const [AssetInfo, _$AssetInfo];

  @override
  final String wireName = r'AssetInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssetInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'badge';
    yield serializers.serialize(
      object.badge,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'rows';
    yield serializers.serialize(
      object.rows,
      specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AssetInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssetInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'badge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.badge = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'rows':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
          ) as BuiltList<KeyValue>;
          result.rows.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssetInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssetInfoBuilder();
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

