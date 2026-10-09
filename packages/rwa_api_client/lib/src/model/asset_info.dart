//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'asset_info.g.dart';

/// 详情页 Asset & Rights 卡片；产品详情的 asset_info 与独立 asset-info 接口使用同一投影。 标题、简介与权益行按设计稿返回，简介中的标的名称取当前产品，不固定为 NVIDIA。 bStocks 默认值为产品设计文案，不是实时链上核验结果；运营配置的有效披露可覆盖对应权益值， 仍须精确匹配 product_id、chain_id、token contract 及有效期。此卡片不展示技术诊断或披露状态行。 
///
/// Properties:
/// * [title] 
/// * [badge] - 当前设计无副标题，返回空字符串；前端为空时不渲染角标或占位行。
/// * [description] 
/// * [rows] - 按返回顺序展示，不要硬编码数组下标。 HIP-3：Product Type / Underlying Exposure / Share Ownership / Dividend Rights / Voting Rights / Position Type。 bStocks：Issuer / Backing / Corporate Actions / Dividend Treatment / Voting Rights / Asset Location。 不返回 Venue、Environment、Execution、Decimals、Admission status 等技术说明行。 
@BuiltValue()
abstract class AssetInfo implements Built<AssetInfo, AssetInfoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 当前设计无副标题，返回空字符串；前端为空时不渲染角标或占位行。
  @BuiltValueField(wireName: r'badge')
  String get badge;

  @BuiltValueField(wireName: r'description')
  String get description;

  /// 按返回顺序展示，不要硬编码数组下标。 HIP-3：Product Type / Underlying Exposure / Share Ownership / Dividend Rights / Voting Rights / Position Type。 bStocks：Issuer / Backing / Corporate Actions / Dividend Treatment / Voting Rights / Asset Location。 不返回 Venue、Environment、Execution、Decimals、Admission status 等技术说明行。 
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

