//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_history_range.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_archive_coverage.g.dart';

/// 仅source=archive非null。区间包含两端，排序且不重叠，共同覆盖请求窗口；缺口不是零流水。 事实及覆盖冻结在同一数据库视图，翻页不会混入新采集结果。完整仅指已归档来源窗口，不保证上游永久保留。 归档查询最多31天、筛选后10000条事件、32MiB事实、100000个强平仓位或覆盖区间；超限返回422且不保存截断快照。 
///
/// Properties:
/// * [coveredRanges] 
/// * [missingRanges] 
@BuiltValue()
abstract class Hip3ArchiveCoverage implements Built<Hip3ArchiveCoverage, Hip3ArchiveCoverageBuilder> {
  @BuiltValueField(wireName: r'covered_ranges')
  BuiltList<Hip3HistoryRange> get coveredRanges;

  @BuiltValueField(wireName: r'missing_ranges')
  BuiltList<Hip3HistoryRange> get missingRanges;

  Hip3ArchiveCoverage._();

  factory Hip3ArchiveCoverage([void updates(Hip3ArchiveCoverageBuilder b)]) = _$Hip3ArchiveCoverage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ArchiveCoverageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ArchiveCoverage> get serializer => _$Hip3ArchiveCoverageSerializer();
}

class _$Hip3ArchiveCoverageSerializer implements PrimitiveSerializer<Hip3ArchiveCoverage> {
  @override
  final Iterable<Type> types = const [Hip3ArchiveCoverage, _$Hip3ArchiveCoverage];

  @override
  final String wireName = r'Hip3ArchiveCoverage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ArchiveCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'covered_ranges';
    yield serializers.serialize(
      object.coveredRanges,
      specifiedType: const FullType(BuiltList, [FullType(Hip3HistoryRange)]),
    );
    yield r'missing_ranges';
    yield serializers.serialize(
      object.missingRanges,
      specifiedType: const FullType(BuiltList, [FullType(Hip3HistoryRange)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ArchiveCoverage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ArchiveCoverageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'covered_ranges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3HistoryRange)]),
          ) as BuiltList<Hip3HistoryRange>;
          result.coveredRanges.replace(valueDes);
          break;
        case r'missing_ranges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3HistoryRange)]),
          ) as BuiltList<Hip3HistoryRange>;
          result.missingRanges.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ArchiveCoverage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ArchiveCoverageBuilder();
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

