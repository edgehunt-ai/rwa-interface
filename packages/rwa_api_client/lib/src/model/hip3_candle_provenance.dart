//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_candle_provenance.g.dart';

/// HIP3 K 线读取批次的真实来源，kind=perp 的当前服务端返回此对象；bStocks 不受影响。 product_id 是包含 DEX 前缀的完整标识，environment 是公共行情网络，不是用户交易账户网络。 updated_at 是服务端数据源观察时间，不是蜡烛开盘时间、HTTP 返回时间或客户端接收时间； 它不是交易所保证的全局修订序号。仅相同产品、网络、来源及 interval 的观察可以比较。 fresh_until 表示该次观察的有效期，不表示历史窗口之后没有交易或已结束蜡烛永不修正。 实时事件只补充近期蜡烛，不替代 REST 历史。缺少本对象时客户端仍可展示 REST， 但不能用客户端接收时间冒充来源版本来决定实时覆盖。 
///
/// Properties:
/// * [productId] 
/// * [environment] 
/// * [source_] 
/// * [updatedAt] 
/// * [freshUntil] 
@BuiltValue()
abstract class Hip3CandleProvenance implements Built<Hip3CandleProvenance, Hip3CandleProvenanceBuilder> {
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'fresh_until')
  DateTime get freshUntil;

  Hip3CandleProvenance._();

  factory Hip3CandleProvenance([void updates(Hip3CandleProvenanceBuilder b)]) = _$Hip3CandleProvenance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3CandleProvenanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3CandleProvenance> get serializer => _$Hip3CandleProvenanceSerializer();
}

class _$Hip3CandleProvenanceSerializer implements PrimitiveSerializer<Hip3CandleProvenance> {
  @override
  final Iterable<Type> types = const [Hip3CandleProvenance, _$Hip3CandleProvenance];

  @override
  final String wireName = r'Hip3CandleProvenance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3CandleProvenance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(String),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'fresh_until';
    yield serializers.serialize(
      object.freshUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3CandleProvenance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3CandleProvenanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.source_ = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'fresh_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.freshUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3CandleProvenance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3CandleProvenanceBuilder();
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

