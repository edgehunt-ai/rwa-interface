//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'asset_info.g.dart';

/// 资产详情与权益
///
/// Properties:
/// * [title] 
/// * [badge] 
/// * [description] 
/// * [rows] - 权益明细。bStocks 典型项：发行方 / 资产支持 / 公司行动 / 股息再投资 / 股息形式 / 投票权 / 资产结果。HIP-3 典型项：产品形态 / 底层权益 / 保证金模式 / 股息再投资 / 资金费率 / 费率方向 / 资产结果。 
@BuiltValue()
abstract class AssetInfo implements Built<AssetInfo, AssetInfoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'badge')
  String get badge;

  @BuiltValueField(wireName: r'description')
  String get description;

  /// 权益明细。bStocks 典型项：发行方 / 资产支持 / 公司行动 / 股息再投资 / 股息形式 / 投票权 / 资产结果。HIP-3 典型项：产品形态 / 底层权益 / 保证金模式 / 股息再投资 / 资金费率 / 费率方向 / 资产结果。 
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

