//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_holding_page_all_of_coverage.g.dart';

/// HIP3 持仓展示覆盖；不承诺原生 perpetual 或全钱包所有资产。计数在分页前计算。
///
/// Properties:
/// * [scope] 
/// * [observedPositionCount] 
/// * [displayedPositionCount] 
/// * [unmappedPositionCount] 
/// * [excludedNonHip3PositionCount] - 可验证的非 HIP3 排除数；数据源未提供该数量时为 null，不猜为零。
@BuiltValue()
abstract class PortfolioHoldingPageAllOfCoverage implements Built<PortfolioHoldingPageAllOfCoverage, PortfolioHoldingPageAllOfCoverageBuilder> {
  @BuiltValueField(wireName: r'scope')
  PortfolioHoldingPageAllOfCoverageScopeEnum get scope;
  // enum scopeEnum {  hip3,  };

  @BuiltValueField(wireName: r'observed_position_count')
  int get observedPositionCount;

  @BuiltValueField(wireName: r'displayed_position_count')
  int get displayedPositionCount;

  @BuiltValueField(wireName: r'unmapped_position_count')
  int get unmappedPositionCount;

  /// 可验证的非 HIP3 排除数；数据源未提供该数量时为 null，不猜为零。
  @BuiltValueField(wireName: r'excluded_non_hip3_position_count')
  int? get excludedNonHip3PositionCount;

  PortfolioHoldingPageAllOfCoverage._();

  factory PortfolioHoldingPageAllOfCoverage([void updates(PortfolioHoldingPageAllOfCoverageBuilder b)]) = _$PortfolioHoldingPageAllOfCoverage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioHoldingPageAllOfCoverageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioHoldingPageAllOfCoverage> get serializer => _$PortfolioHoldingPageAllOfCoverageSerializer();
}

class _$PortfolioHoldingPageAllOfCoverageSerializer implements PrimitiveSerializer<PortfolioHoldingPageAllOfCoverage> {
  @override
  final Iterable<Type> types = const [PortfolioHoldingPageAllOfCoverage, _$PortfolioHoldingPageAllOfCoverage];

  @override
  final String wireName = r'PortfolioHoldingPageAllOfCoverage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioHoldingPageAllOfCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(PortfolioHoldingPageAllOfCoverageScopeEnum),
    );
    yield r'observed_position_count';
    yield serializers.serialize(
      object.observedPositionCount,
      specifiedType: const FullType(int),
    );
    yield r'displayed_position_count';
    yield serializers.serialize(
      object.displayedPositionCount,
      specifiedType: const FullType(int),
    );
    yield r'unmapped_position_count';
    yield serializers.serialize(
      object.unmappedPositionCount,
      specifiedType: const FullType(int),
    );
    yield r'excluded_non_hip3_position_count';
    yield object.excludedNonHip3PositionCount == null ? null : serializers.serialize(
      object.excludedNonHip3PositionCount,
      specifiedType: const FullType.nullable(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioHoldingPageAllOfCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioHoldingPageAllOfCoverageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioHoldingPageAllOfCoverageScopeEnum),
          ) as PortfolioHoldingPageAllOfCoverageScopeEnum;
          result.scope = valueDes;
          break;
        case r'observed_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.observedPositionCount = valueDes;
          break;
        case r'displayed_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.displayedPositionCount = valueDes;
          break;
        case r'unmapped_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unmappedPositionCount = valueDes;
          break;
        case r'excluded_non_hip3_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.excludedNonHip3PositionCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioHoldingPageAllOfCoverage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioHoldingPageAllOfCoverageBuilder();
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

class PortfolioHoldingPageAllOfCoverageScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3')
  static const PortfolioHoldingPageAllOfCoverageScopeEnum hip3 = _$portfolioHoldingPageAllOfCoverageScopeEnum_hip3;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioHoldingPageAllOfCoverageScopeEnum unknownDefaultOpenApi = _$portfolioHoldingPageAllOfCoverageScopeEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioHoldingPageAllOfCoverageScopeEnum> get serializer => _$portfolioHoldingPageAllOfCoverageScopeEnumSerializer;

  const PortfolioHoldingPageAllOfCoverageScopeEnum._(String name): super(name);

  static BuiltSet<PortfolioHoldingPageAllOfCoverageScopeEnum> get values => _$portfolioHoldingPageAllOfCoverageScopeEnumValues;
  static PortfolioHoldingPageAllOfCoverageScopeEnum valueOf(String name) => _$portfolioHoldingPageAllOfCoverageScopeEnumValueOf(name);
}

