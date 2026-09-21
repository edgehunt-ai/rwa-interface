//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_route_leg.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_route.g.dart';

/// BstocksPreviewRoute
///
/// Properties:
/// * [kind] 
/// * [expectedAmountOutRaw] - 十进制字符串，避免浮点误差
/// * [netAmountOutRaw] - 十进制字符串，避免浮点误差
/// * [legs] 
/// * [indicative] 
@BuiltValue()
abstract class BstocksPreviewRoute implements Built<BstocksPreviewRoute, BstocksPreviewRouteBuilder> {
  @BuiltValueField(wireName: r'kind')
  BstocksPreviewRouteKindEnum get kind;
  // enum kindEnum {  single,  split,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'expected_amount_out_raw')
  String get expectedAmountOutRaw;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'net_amount_out_raw')
  String get netAmountOutRaw;

  @BuiltValueField(wireName: r'legs')
  BuiltList<BstocksPreviewRouteLeg> get legs;

  @BuiltValueField(wireName: r'indicative')
  bool get indicative;

  BstocksPreviewRoute._();

  factory BstocksPreviewRoute([void updates(BstocksPreviewRouteBuilder b)]) = _$BstocksPreviewRoute;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewRouteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewRoute> get serializer => _$BstocksPreviewRouteSerializer();
}

class _$BstocksPreviewRouteSerializer implements PrimitiveSerializer<BstocksPreviewRoute> {
  @override
  final Iterable<Type> types = const [BstocksPreviewRoute, _$BstocksPreviewRoute];

  @override
  final String wireName = r'BstocksPreviewRoute';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewRoute object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstocksPreviewRouteKindEnum),
    );
    yield r'expected_amount_out_raw';
    yield serializers.serialize(
      object.expectedAmountOutRaw,
      specifiedType: const FullType(String),
    );
    yield r'net_amount_out_raw';
    yield serializers.serialize(
      object.netAmountOutRaw,
      specifiedType: const FullType(String),
    );
    yield r'legs';
    yield serializers.serialize(
      object.legs,
      specifiedType: const FullType(BuiltList, [FullType(BstocksPreviewRouteLeg)]),
    );
    yield r'indicative';
    yield serializers.serialize(
      object.indicative,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewRoute object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewRouteBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewRouteKindEnum),
          ) as BstocksPreviewRouteKindEnum;
          result.kind = valueDes;
          break;
        case r'expected_amount_out_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expectedAmountOutRaw = valueDes;
          break;
        case r'net_amount_out_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.netAmountOutRaw = valueDes;
          break;
        case r'legs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BstocksPreviewRouteLeg)]),
          ) as BuiltList<BstocksPreviewRouteLeg>;
          result.legs.replace(valueDes);
          break;
        case r'indicative':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.indicative = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPreviewRoute deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewRouteBuilder();
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

class BstocksPreviewRouteKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'single')
  static const BstocksPreviewRouteKindEnum single = _$bstocksPreviewRouteKindEnum_single;
  @BuiltValueEnumConst(wireName: r'split')
  static const BstocksPreviewRouteKindEnum split = _$bstocksPreviewRouteKindEnum_split;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksPreviewRouteKindEnum unknownDefaultOpenApi = _$bstocksPreviewRouteKindEnum_unknownDefaultOpenApi;

  static Serializer<BstocksPreviewRouteKindEnum> get serializer => _$bstocksPreviewRouteKindEnumSerializer;

  const BstocksPreviewRouteKindEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewRouteKindEnum> get values => _$bstocksPreviewRouteKindEnumValues;
  static BstocksPreviewRouteKindEnum valueOf(String name) => _$bstocksPreviewRouteKindEnumValueOf(name);
}

