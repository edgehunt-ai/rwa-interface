//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_liquidation_history_coverage.g.dart';

/// Hip3LiquidationHistoryCoverage
///
/// Properties:
/// * [source_] 
/// * [status] 
/// * [from] 
/// * [to] 
/// * [resumeFrom] - live部分结果续查包含边界；archive为第一个缺口起点。source_exhausted或archive_complete时null。
/// * [retentionGuaranteed] 
@BuiltValue()
abstract class Hip3LiquidationHistoryCoverage implements Built<Hip3LiquidationHistoryCoverage, Hip3LiquidationHistoryCoverageBuilder> {
  @BuiltValueField(wireName: r'source')
  Hip3LiquidationHistoryCoverageSource_Enum get source_;
  // enum source_Enum {  hyperliquid_userNonFundingLedgerUpdates,  };

  @BuiltValueField(wireName: r'status')
  Hip3LiquidationHistoryCoverageStatusEnum get status;
  // enum statusEnum {  source_exhausted,  page_limit,  timestamp_saturated,  upstream_unavailable,  archive_complete,  archive_partial,  };

  @BuiltValueField(wireName: r'from')
  DateTime get from;

  @BuiltValueField(wireName: r'to')
  DateTime get to;

  /// live部分结果续查包含边界；archive为第一个缺口起点。source_exhausted或archive_complete时null。
  @BuiltValueField(wireName: r'resume_from')
  DateTime? get resumeFrom;

  @BuiltValueField(wireName: r'retention_guaranteed')
  bool get retentionGuaranteed;

  Hip3LiquidationHistoryCoverage._();

  factory Hip3LiquidationHistoryCoverage([void updates(Hip3LiquidationHistoryCoverageBuilder b)]) = _$Hip3LiquidationHistoryCoverage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3LiquidationHistoryCoverageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3LiquidationHistoryCoverage> get serializer => _$Hip3LiquidationHistoryCoverageSerializer();
}

class _$Hip3LiquidationHistoryCoverageSerializer implements PrimitiveSerializer<Hip3LiquidationHistoryCoverage> {
  @override
  final Iterable<Type> types = const [Hip3LiquidationHistoryCoverage, _$Hip3LiquidationHistoryCoverage];

  @override
  final String wireName = r'Hip3LiquidationHistoryCoverage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3LiquidationHistoryCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(Hip3LiquidationHistoryCoverageSource_Enum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3LiquidationHistoryCoverageStatusEnum),
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
    Hip3LiquidationHistoryCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3LiquidationHistoryCoverageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3LiquidationHistoryCoverageSource_Enum),
          ) as Hip3LiquidationHistoryCoverageSource_Enum;
          result.source_ = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3LiquidationHistoryCoverageStatusEnum),
          ) as Hip3LiquidationHistoryCoverageStatusEnum;
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
  Hip3LiquidationHistoryCoverage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3LiquidationHistoryCoverageBuilder();
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

class Hip3LiquidationHistoryCoverageSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid_userNonFundingLedgerUpdates')
  static const Hip3LiquidationHistoryCoverageSource_Enum hyperliquidUserNonFundingLedgerUpdates = _$hip3LiquidationHistoryCoverageSourceEnum_hyperliquidUserNonFundingLedgerUpdates;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationHistoryCoverageSource_Enum unknownDefaultOpenApi = _$hip3LiquidationHistoryCoverageSourceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationHistoryCoverageSource_Enum> get serializer => _$hip3LiquidationHistoryCoverageSourceEnumSerializer;

  const Hip3LiquidationHistoryCoverageSource_Enum._(String name): super(name);

  static BuiltSet<Hip3LiquidationHistoryCoverageSource_Enum> get values => _$hip3LiquidationHistoryCoverageSourceEnumValues;
  static Hip3LiquidationHistoryCoverageSource_Enum valueOf(String name) => _$hip3LiquidationHistoryCoverageSourceEnumValueOf(name);
}

class Hip3LiquidationHistoryCoverageStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'source_exhausted')
  static const Hip3LiquidationHistoryCoverageStatusEnum sourceExhausted = _$hip3LiquidationHistoryCoverageStatusEnum_sourceExhausted;
  @BuiltValueEnumConst(wireName: r'page_limit')
  static const Hip3LiquidationHistoryCoverageStatusEnum pageLimit = _$hip3LiquidationHistoryCoverageStatusEnum_pageLimit;
  @BuiltValueEnumConst(wireName: r'timestamp_saturated')
  static const Hip3LiquidationHistoryCoverageStatusEnum timestampSaturated = _$hip3LiquidationHistoryCoverageStatusEnum_timestampSaturated;
  @BuiltValueEnumConst(wireName: r'upstream_unavailable')
  static const Hip3LiquidationHistoryCoverageStatusEnum upstreamUnavailable = _$hip3LiquidationHistoryCoverageStatusEnum_upstreamUnavailable;
  @BuiltValueEnumConst(wireName: r'archive_complete')
  static const Hip3LiquidationHistoryCoverageStatusEnum archiveComplete = _$hip3LiquidationHistoryCoverageStatusEnum_archiveComplete;
  @BuiltValueEnumConst(wireName: r'archive_partial')
  static const Hip3LiquidationHistoryCoverageStatusEnum archivePartial = _$hip3LiquidationHistoryCoverageStatusEnum_archivePartial;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3LiquidationHistoryCoverageStatusEnum unknownDefaultOpenApi = _$hip3LiquidationHistoryCoverageStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3LiquidationHistoryCoverageStatusEnum> get serializer => _$hip3LiquidationHistoryCoverageStatusEnumSerializer;

  const Hip3LiquidationHistoryCoverageStatusEnum._(String name): super(name);

  static BuiltSet<Hip3LiquidationHistoryCoverageStatusEnum> get values => _$hip3LiquidationHistoryCoverageStatusEnumValues;
  static Hip3LiquidationHistoryCoverageStatusEnum valueOf(String name) => _$hip3LiquidationHistoryCoverageStatusEnumValueOf(name);
}

