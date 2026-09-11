//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_funding_history_coverage.g.dart';

/// Hip3FundingHistoryCoverage
///
/// Properties:
/// * [source_] 
/// * [status] 
/// * [from] 
/// * [to] 
/// * [resumeFrom] - source_exhausted或archive_complete时null；live部分结果从此包含边界续查，不加1毫秒。archive_partial为第一个缺口起点，全部缺口见archive_coverage。
/// * [retentionGuaranteed] 
@BuiltValue()
abstract class Hip3FundingHistoryCoverage implements Built<Hip3FundingHistoryCoverage, Hip3FundingHistoryCoverageBuilder> {
  @BuiltValueField(wireName: r'source')
  Hip3FundingHistoryCoverageSource_Enum get source_;
  // enum source_Enum {  hyperliquid_userFunding,  };

  @BuiltValueField(wireName: r'status')
  Hip3FundingHistoryCoverageStatusEnum get status;
  // enum statusEnum {  source_exhausted,  page_limit,  timestamp_saturated,  upstream_unavailable,  archive_complete,  archive_partial,  };

  @BuiltValueField(wireName: r'from')
  DateTime get from;

  @BuiltValueField(wireName: r'to')
  DateTime get to;

  /// source_exhausted或archive_complete时null；live部分结果从此包含边界续查，不加1毫秒。archive_partial为第一个缺口起点，全部缺口见archive_coverage。
  @BuiltValueField(wireName: r'resume_from')
  DateTime? get resumeFrom;

  @BuiltValueField(wireName: r'retention_guaranteed')
  bool get retentionGuaranteed;

  Hip3FundingHistoryCoverage._();

  factory Hip3FundingHistoryCoverage([void updates(Hip3FundingHistoryCoverageBuilder b)]) = _$Hip3FundingHistoryCoverage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3FundingHistoryCoverageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3FundingHistoryCoverage> get serializer => _$Hip3FundingHistoryCoverageSerializer();
}

class _$Hip3FundingHistoryCoverageSerializer implements PrimitiveSerializer<Hip3FundingHistoryCoverage> {
  @override
  final Iterable<Type> types = const [Hip3FundingHistoryCoverage, _$Hip3FundingHistoryCoverage];

  @override
  final String wireName = r'Hip3FundingHistoryCoverage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3FundingHistoryCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(Hip3FundingHistoryCoverageSource_Enum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3FundingHistoryCoverageStatusEnum),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(DateTime),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(DateTime),
    );
    yield r'resume_from';
    yield object.resumeFrom == null ? null : serializers.serialize(
      object.resumeFrom,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'retention_guaranteed';
    yield serializers.serialize(
      object.retentionGuaranteed,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3FundingHistoryCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3FundingHistoryCoverageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3FundingHistoryCoverageSource_Enum),
          ) as Hip3FundingHistoryCoverageSource_Enum;
          result.source_ = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3FundingHistoryCoverageStatusEnum),
          ) as Hip3FundingHistoryCoverageStatusEnum;
          result.status = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.to = valueDes;
          break;
        case r'resume_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.resumeFrom = valueDes;
          break;
        case r'retention_guaranteed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.retentionGuaranteed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3FundingHistoryCoverage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3FundingHistoryCoverageBuilder();
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

class Hip3FundingHistoryCoverageSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid_userFunding')
  static const Hip3FundingHistoryCoverageSource_Enum hyperliquidUserFunding = _$hip3FundingHistoryCoverageSourceEnum_hyperliquidUserFunding;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3FundingHistoryCoverageSource_Enum unknownDefaultOpenApi = _$hip3FundingHistoryCoverageSourceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3FundingHistoryCoverageSource_Enum> get serializer => _$hip3FundingHistoryCoverageSourceEnumSerializer;

  const Hip3FundingHistoryCoverageSource_Enum._(String name): super(name);

  static BuiltSet<Hip3FundingHistoryCoverageSource_Enum> get values => _$hip3FundingHistoryCoverageSourceEnumValues;
  static Hip3FundingHistoryCoverageSource_Enum valueOf(String name) => _$hip3FundingHistoryCoverageSourceEnumValueOf(name);
}

class Hip3FundingHistoryCoverageStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'source_exhausted')
  static const Hip3FundingHistoryCoverageStatusEnum sourceExhausted = _$hip3FundingHistoryCoverageStatusEnum_sourceExhausted;
  @BuiltValueEnumConst(wireName: r'page_limit')
  static const Hip3FundingHistoryCoverageStatusEnum pageLimit = _$hip3FundingHistoryCoverageStatusEnum_pageLimit;
  @BuiltValueEnumConst(wireName: r'timestamp_saturated')
  static const Hip3FundingHistoryCoverageStatusEnum timestampSaturated = _$hip3FundingHistoryCoverageStatusEnum_timestampSaturated;
  @BuiltValueEnumConst(wireName: r'upstream_unavailable')
  static const Hip3FundingHistoryCoverageStatusEnum upstreamUnavailable = _$hip3FundingHistoryCoverageStatusEnum_upstreamUnavailable;
  @BuiltValueEnumConst(wireName: r'archive_complete')
  static const Hip3FundingHistoryCoverageStatusEnum archiveComplete = _$hip3FundingHistoryCoverageStatusEnum_archiveComplete;
  @BuiltValueEnumConst(wireName: r'archive_partial')
  static const Hip3FundingHistoryCoverageStatusEnum archivePartial = _$hip3FundingHistoryCoverageStatusEnum_archivePartial;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3FundingHistoryCoverageStatusEnum unknownDefaultOpenApi = _$hip3FundingHistoryCoverageStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3FundingHistoryCoverageStatusEnum> get serializer => _$hip3FundingHistoryCoverageStatusEnumSerializer;

  const Hip3FundingHistoryCoverageStatusEnum._(String name): super(name);

  static BuiltSet<Hip3FundingHistoryCoverageStatusEnum> get values => _$hip3FundingHistoryCoverageStatusEnumValues;
  static Hip3FundingHistoryCoverageStatusEnum valueOf(String name) => _$hip3FundingHistoryCoverageStatusEnumValueOf(name);
}

