//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/restricted_region.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_region.g.dart';

/// AccessRegion
///
/// Properties:
/// * [countryCode] - 判定出的国家（ISO 3166-1 alpha-2）；无法判定时为 null
/// * [source_] - 国家判定来源：CDN 边缘、服务端 IP 地理库，或无法判定
/// * [restricted] - 当前请求是否来自受限地区
/// * [restrictedCountries] - 受限名单的国家代码，升序
/// * [restrictedRegions] - 受限名单，按提示文案的展示顺序排列
@BuiltValue()
abstract class AccessRegion implements Built<AccessRegion, AccessRegionBuilder> {
  /// 判定出的国家（ISO 3166-1 alpha-2）；无法判定时为 null
  @BuiltValueField(wireName: r'country_code')
  String? get countryCode;

  /// 国家判定来源：CDN 边缘、服务端 IP 地理库，或无法判定
  @BuiltValueField(wireName: r'source')
  AccessRegionSource_Enum get source_;
  // enum source_Enum {  edge,  geoip,  unknown,  };

  /// 当前请求是否来自受限地区
  @BuiltValueField(wireName: r'restricted')
  bool get restricted;

  /// 受限名单的国家代码，升序
  @BuiltValueField(wireName: r'restricted_countries')
  BuiltList<String> get restrictedCountries;

  /// 受限名单，按提示文案的展示顺序排列
  @BuiltValueField(wireName: r'restricted_regions')
  BuiltList<RestrictedRegion> get restrictedRegions;

  AccessRegion._();

  factory AccessRegion([void updates(AccessRegionBuilder b)]) = _$AccessRegion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessRegionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessRegion> get serializer => _$AccessRegionSerializer();
}

class _$AccessRegionSerializer implements PrimitiveSerializer<AccessRegion> {
  @override
  final Iterable<Type> types = const [AccessRegion, _$AccessRegion];

  @override
  final String wireName = r'AccessRegion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessRegion object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'country_code';
    yield object.countryCode == null ? null : serializers.serialize(
      object.countryCode,
      specifiedType: const FullType.nullable(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(AccessRegionSource_Enum),
    );
    yield r'restricted';
    yield serializers.serialize(
      object.restricted,
      specifiedType: const FullType(bool),
    );
    yield r'restricted_countries';
    yield serializers.serialize(
      object.restrictedCountries,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'restricted_regions';
    yield serializers.serialize(
      object.restrictedRegions,
      specifiedType: const FullType(BuiltList, [FullType(RestrictedRegion)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessRegion object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessRegionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'country_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.countryCode = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccessRegionSource_Enum),
          ) as AccessRegionSource_Enum;
          result.source_ = valueDes;
          break;
        case r'restricted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.restricted = valueDes;
          break;
        case r'restricted_countries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.restrictedCountries.replace(valueDes);
          break;
        case r'restricted_regions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RestrictedRegion)]),
          ) as BuiltList<RestrictedRegion>;
          result.restrictedRegions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessRegion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessRegionBuilder();
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

class AccessRegionSource_Enum extends EnumClass {

  /// 国家判定来源：CDN 边缘、服务端 IP 地理库，或无法判定
  @BuiltValueEnumConst(wireName: r'edge')
  static const AccessRegionSource_Enum edge = _$accessRegionSourceEnum_edge;
  /// 国家判定来源：CDN 边缘、服务端 IP 地理库，或无法判定
  @BuiltValueEnumConst(wireName: r'geoip')
  static const AccessRegionSource_Enum geoip = _$accessRegionSourceEnum_geoip;
  /// 国家判定来源：CDN 边缘、服务端 IP 地理库，或无法判定
  @BuiltValueEnumConst(wireName: r'unknown')
  static const AccessRegionSource_Enum unknown = _$accessRegionSourceEnum_unknown;

  static Serializer<AccessRegionSource_Enum> get serializer => _$accessRegionSourceEnumSerializer;

  const AccessRegionSource_Enum._(String name): super(name);

  static BuiltSet<AccessRegionSource_Enum> get values => _$accessRegionSourceEnumValues;
  static AccessRegionSource_Enum valueOf(String name) => _$accessRegionSourceEnumValueOf(name);
}

